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

ALTER FUNCTION dbadmin.email_notify(TEXT, VARCHAR, VARCHAR) OWNER TO dbadmin;

select dbadmin.email_notify('Test message','Harfang', 'frederic.cloitre@lpo.fr')

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


/* Lightweight base check data */

CREATE INDEX ON src_vn_json_check.observations_json (update_ts);
CREATE INDEX ON src_vn_json.observations_json (update_ts);

DROP MATERIALIZED VIEW IF EXISTS src_vn_json_check.mv_check_observations_json_id_update_ts CASCADE;

-- CREATE MATERIALIZED VIEW src_vn_json_check.mv_check_observations_json_id_update_ts AS
-- SELECT id, update_ts
-- FROM src_vn_json_check.observations_json;
-- CREATE INDEX ON src_vn_json_check.mv_check_observations_json_id_update_ts (id);


/* Lightweight base prod data */
-- DROP MATERIALIZED VIEW IF EXISTS src_vn_json.observations_json CASCADE;
--
-- CREATE MATERIALIZED VIEW src_vn_json.observations_json AS
-- SELECT id, update_ts
-- FROM src_vn_json.observations_json;
-- CREATE INDEX ON src_vn_json.observations_json (id);
-- CREATE INDEX ON src_vn_json.observations_json (update_ts);


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

-- SELECT data_prod_status, count(*)
-- FROM src_vn_json_check.mv_data_missing_or_not_updated
-- GROUP BY 1;
DROP MATERIALIZED VIEW src_vn_json_check.qgis_data;
CREATE MATERIALIZED VIEW src_vn_json_check.qgis_data AS
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

CREATE OR REPLACE PROCEDURE src_vn_json_check.fct_fix_sync()
AS
$$
DECLARE
    nb_rows INT;
BEGIN
    --REFRESH MATERIALIZED VIEW src_vn_json_check.mv_check_observations_json_id_update_ts;
    REFRESH MATERIALIZED VIEW src_vn_json_check.mv_data_missing_or_not_updated;
    WITH upsert_rows AS (
        INSERT INTO src_vn_json.observations_json (id, site, item, update_ts, id_form_universal)
            SELECT checkdata_obs.id
                 , checkdata_obs.site
                 , checkdata_obs.item
                 , checkdata_obs.update_ts
                 , checkdata_obs.id_form_universal
            FROM src_vn_json_check.observations_json AS checkdata_obs
                     JOIN src_vn_json_check.mv_data_missing_or_not_updated
                          ON checkdata_obs.id = mv_data_missing_or_not_updated.checkdata_id
--                      and mv_data_missing_or_not_updated.data_not_updated = 'Something went wrong ?'
            WHERE TO_TIMESTAMP(checkdata_update_ts) > (NOW() - INTERVAL '1 month')
            ON CONFLICT (id,site)
                DO UPDATE SET item = excluded.item,
                    update_ts = excluded.update_ts,
                    id_form_universal = excluded.id_form_universal
            RETURNING *)
    SELECT COUNT(*)
    INTO nb_rows
    FROM upsert_rows;
    RAISE NOTICE '<src_vn_json_check.fct_fix_sync> % rows upserted', nb_rows;
    PERFORM dbadmin.email_notify(
            ('<src_vn_json_check.fct_fix_sync> ' || nb_rows || ' rows upserted in ' || CURRENT_DATABASE() ||
             '.src_vn_json.observations_json')::TEXT,
            '[' || CURRENT_DATABASE() || '] Upsert missing data from visionature'::VARCHAR,
            'webadmin.aura@lpo.fr'::VARCHAR);
END ;
$$ LANGUAGE plpgsql;

--
-- DO
-- $$
--     DECLARE
--         nb_rows INT;
--     BEGIN
--         WITH upsert_rows AS (
--             INSERT INTO src_vn_json.observations_json (id, site, item, update_ts, id_form_universal)
--                 SELECT checkdata_obs.id,
--                        checkdata_obs.site,
--                        checkdata_obs.item,
--                        checkdata_obs.update_ts,
--                        checkdata_obs.id_form_universal
--                 FROM src_vn_json_check.observations_json AS checkdata_obs
--                          JOIN src_vn_json_check.mv_data_missing_or_not_updated
--                               ON checkdata_obs.id = mv_data_missing_or_not_updated.checkdata_id
-- --                      and mv_data_missing_or_not_updated.data_not_updated = 'Something went wrong ?'
--                 ON CONFLICT (id,site)
--                     DO UPDATE SET item = excluded.item,
--                         update_ts = excluded.update_ts,
--                         id_form_universal = excluded.id_form_universal
--                 RETURNING *)
--         SELECT count(*)
--         INTO nb_rows
--         FROM upsert_rows;
--         RAISE NOTICE '<src_vn_json_check.fct_fix_sync> % rows upserted', nb_rows;
--     END
-- $$;

SELECT COUNT(*)
FROM src_vn_json_check.qgis_data;

SELECT 'https://www.faune-france.org/index.php?m_id=54&id=' || id
FROM src_vn_json_check.qgis_data;
