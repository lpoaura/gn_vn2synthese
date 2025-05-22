/* Prérequis, disposer d'un export complet dans le schéma src_vn_json_check */

/* Mode opératoire
   Import complet initial
   Import mensuel complet des 2 derniers mois tous les mois
   Check
   */

CREATE SCHEMA IF NOT EXISTS dbadmin;

CREATE OR REPLACE FUNCTION dbadmin.email_notify(
    message TEXT, subject CHARACTER VARYING, recipient CHARACTER VARYING
) RETURNS VOID
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE FORMAT('COPY (SELECT ''%s'') TO PROGRAM ''mail -s "%s" %s'' WITH ( FORMAT TEXT)',
                   message, subject, recipient);
END ;
$$;

CREATE TABLE IF NOT EXISTS dbadmin.monitoring_vn_check_to_prod
(
    id     BIGINT GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    date   TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    action VARCHAR                                NOT NULL,
    count  INTEGER
);

/* Add GEOM to check table*/
/*ALTER TABLE src_vn_json_check.observations_json
    DROP COLUMN geom;

ALTER TABLE src_vn_json_check.observations_json
    ADD COLUMN geom GEOMETRY(point, 4326)
        GENERATED ALWAYS AS (
            st_setsrid(st_makepoint(
                               (item #>> '{observers,0,coord_lon}')::FLOAT,
                               (item #>> '{observers,0,coord_lat}')::FLOAT
                       ),
                       4326)
            ) STORED;

CREATE INDEX ON src_vn_json_check.observations_json USING gist (geom);
  */


CREATE INDEX IF NOT EXISTS ix_observation_json_update_ts ON src_vn_json_check.observations_json (update_ts);
CREATE INDEX IF NOT EXISTS ix_observation_json_update_ts ON src_vn_json.observations_json (update_ts);

DROP MATERIALIZED VIEW IF EXISTS src_vn_json_check.mv_check_observations_json_id_update_ts CASCADE;


DROP MATERIALIZED VIEW IF EXISTS src_vn_json_check.mv_data_missing_or_not_updated CASCADE;
CREATE MATERIALIZED VIEW src_vn_json_check.mv_data_missing_or_not_updated AS
SELECT checkdata.id                             AS checkdata_id
     , checkdata.update_ts                      AS checkdata_update_ts
     , maindata.update_ts                       AS maindata_update_ts
     , CASE
           WHEN checkdata.update_ts > maindata.update_ts THEN 'not_updated'
           WHEN checkdata.update_ts = maindata.update_ts THEN 'up_to_date'
           WHEN checkdata.update_ts < maindata.update_ts THEN 'wrongly_updated'
           WHEN maindata.id IS NULL THEN 'missing'
    END                                         AS data_prod_status
     , checkdata.update_ts > maindata.update_ts AS data_not_up_to_date
FROM src_vn_json_check.observations_json AS checkdata
         LEFT JOIN
     src_vn_json.observations_json AS maindata
     ON checkdata.id = maindata.id
WHERE maindata.id IS NULL
   OR (
          maindata.update_ts IS NOT NULL
              AND checkdata.update_ts > maindata.update_ts
          )
    AND maindata.update_ts <= (SELECT MAX(update_ts) FROM src_vn_json_check.observations_json);


DROP MATERIALIZED VIEW IF EXISTS src_vn_json_check.qgis_data;
CREATE MATERIALIZED VIEW IF NOT EXISTS src_vn_json_check.qgis_data AS
SELECT checkdata_obs.id
     , checkdata_obs.site
     , checkdata_obs.item
     , checkdata_obs.update_ts
     , checkdata_obs.id_form_universal
     , st_setsrid(st_makepoint(
                          (checkdata_obs.item #>> '{observers,0,coord_lon}')::FLOAT,
                          (checkdata_obs.item #>> '{observers,0,coord_lat}')::FLOAT
                  ),
                  4326) AS geom
FROM src_vn_json_check.observations_json AS checkdata_obs
         INNER JOIN src_vn_json_check.mv_data_missing_or_not_updated
                    ON checkdata_obs.id = mv_data_missing_or_not_updated.checkdata_id;

CREATE UNIQUE INDEX ON src_vn_json_check.qgis_data (id);
CREATE INDEX ON src_vn_json_check.qgis_data USING gist (geom);

CREATE OR REPLACE PROCEDURE src_vn_json_check.fct_fix_sync(IN _email BOOLEAN DEFAULT TRUE)
    LANGUAGE plpgsql
AS
$$
DECLARE
    inserted_rows INTEGER;
    updated_rows  INTEGER;
BEGIN
    /* INSERT Missing data from check to prod schemas */
    WITH inserted_rows AS (INSERT INTO src_vn_json.observations_json (id, site, item, update_ts, id_form_universal)
        SELECT obs_check.id, obs_check.site, obs_check.item, obs_check.update_ts, obs_check.id_form_universal
        FROM src_vn_json_check.observations_json obs_check
                 FULL JOIN src_vn_json.observations_json obs_orig
                           ON (obs_check.id, obs_check.site) = (obs_orig.id, obs_orig.site)
        WHERE obs_orig IS NULL RETURNING 1)
    INSERT
    INTO dbadmin.monitoring_vn_check_to_prod(action, count)
    SELECT 'insert', COUNT(*)
    FROM inserted_rows
    RETURNING count::TEXT INTO inserted_rows;
    /* UPDATE data not up to date */
    WITH updated_rows AS (UPDATE src_vn_json.observations_json
        SET (item, update_ts, id_form_universal) = (obs_check.item, obs_check.update_ts, obs_check.id_form_universal)
        FROM src_vn_json_check.observations_json AS obs_check
        WHERE (obs_check.id, obs_check.site) = (observations_json.id, observations_json.site)
            AND obs_check.update_ts >
                observations_json.update_ts RETURNING 1)
    INSERT
    INTO dbadmin.monitoring_vn_check_to_prod(action, count)
    SELECT 'update', COUNT(*)
    FROM updated_rows
    RETURNING count::TEXT INTO updated_rows;

    RAISE NOTICE '<src_vn_json_check.fct_fix_sync> % rows inserted, % rows updated', inserted_rows, updated_rows;
    IF (_email AND EXISTS (SELECT *
                           FROM pg_catalog.pg_proc p
                                    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                           WHERE proname = 'email_notify'
                             AND nspname = 'dbadmin')) THEN
        PERFORM dbadmin.email_notify(
                ('<src_vn_json_check.fct_fix_sync> ' || inserted_rows || ' inserts / ' || updated_rows ||
                 ' updates in ' ||
                 CURRENT_DATABASE() ||
                 '.src_vn_json.observations_json')::TEXT,
                '[' || CURRENT_DATABASE() || '] Upsert missing data from visionature'::VARCHAR,
                'webadmin.aura@lpo.fr'::VARCHAR);
    END IF;
END;
$$;
