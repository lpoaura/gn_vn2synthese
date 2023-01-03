/*
ENTITIES
--------
Populate UsersHub organisms from VisioNature entities
*/

BEGIN;

ALTER TABLE utilisateurs.bib_organismes
    ADD COLUMN IF NOT EXISTS additional_data JSONB
        DEFAULT '{}'::JSONB
;

CREATE OR REPLACE FUNCTION public.fct_c_slugify(_value TEXT, _disallow_unicode BOOLEAN DEFAULT TRUE)
    RETURNS TEXT AS
$$

WITH
    normalized AS (
        SELECT
            CASE
                WHEN _disallow_unicode THEN unaccent(_value)
                ELSE _value
                END AS value
    )
SELECT
    regexp_replace(
            trim(
                    lower(
                            regexp_replace(
                                    value,
                                    E'[^\\w\\s-]',
                                    '',
                                    'gi'
                                )
                        )
                ),
            E'[-\\s]+', '_', 'gi'
        )
    FROM
        normalized;

$$ LANGUAGE sql STRICT
                IMMUTABLE
;


CREATE UNIQUE INDEX IF NOT EXISTS i_c_organism_adddata_vn_short_name ON utilisateurs.bib_organismes ((additional_data #>> '{from_vn, short_name}'))
;

/* Function to basically create new dataset attached to an acquisition_framework find by name */
CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_tri_upsert_entities()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$upsert_entities$
DECLARE
    theorganismid             INT;
    theorganismrecord         RECORD;
    theacquisitionframeworkid INT;
BEGIN
    IF (
        SELECT
            exists(
                    SELECT
                        1
                        FROM
                            utilisateurs.bib_organismes
                        WHERE
                                    bib_organismes.additional_data #>> '{from_vn,short_name}' =
                                    public.fct_c_slugify(new.item ->> 'short_name'))) THEN
        /* Si le JDD par défaut existe déjà, on récupère son ID */
        RAISE DEBUG '<fct_c_tri_upsert_entities> Entity % Already exists', new.item ->> 'short_name';
        SELECT *
            INTO theorganismrecord
            FROM
                utilisateurs.bib_organismes
            WHERE
                        bib_organismes.additional_data #>> '{from_vn,short_name}' =
                        public.fct_c_slugify(new.item ->> 'short_name');
        SELECT theorganismrecord.id_organisme INTO theorganismid;
        IF NOT (theorganismrecord.additional_data -> 'from_vn' ? new.site AND
                theorganismrecord.additional_data #> ('{from_vn,' || new.site || '}')::TEXT[] ? 'id_entity')
        THEN
            UPDATE utilisateurs.bib_organismes
            SET
                additional_data = jsonb_set(
                        additional_data,
                        ('{from_vn,' || new.site || '}')::TEXT[],
                        jsonb_build_object('id_entity', new.id),
                        TRUE
                    )
                WHERE
                    id_organisme = theorganismid;
        END IF;
        RAISE DEBUG '<fct_c_tri_upsert_entities> Entity with VisioNature shortname % exists with get ID : %',
            theorganismrecord.nom_organisme, theorganismid;
    ELSE
        RAISE DEBUG '<fct_c_tri_upsert_entities> Entity % not found, start create', new.item ->> 'short_name';
        RAISE DEBUG '% \n % \n %', new.item ->> 'full_name_french', new.item ->> 'url', jsonb_build_object(
                        'from_vn',
                        jsonb_build_object(
                                new.site,
                                jsonb_build_object(
                                        'id_entity',
                                        new.item ->> 'id'
                                    ),
                                'short_name',
                                public.fct_c_slugify(new.item ->> 'short_name')
                            ));
        INSERT INTO
            utilisateurs.bib_organismes (nom_organisme, url_organisme, additional_data)
            VALUES
                (new.item ->> 'full_name_french', new.item ->> 'url', jsonb_build_object(
                        'from_vn',
                        jsonb_build_object(
                                new.site,
                                jsonb_build_object(
                                        'id_entity',
                                        new.item ->> 'id'
                                    ),
                                'short_name',
                                public.fct_c_slugify(new.item ->> 'short_name')
                            )))
        ON CONFLICT ((additional_data #>> '{from_vn, short_name}'))  DO UPDATE
            SET
                additional_data =
                    jsonb_set(excluded.additional_data,
                              ('{from_vn,' || new.site || '}')::TEXT[],
                              jsonb_build_object('id_entity', new.item -> 'id_entity'),
                              TRUE)
            RETURNING id_organisme INTO theorganismid;
        RAISE DEBUG '<fct_c_tri_upsert_entities> entity % upserted', new.item ->> 'short_name';
    END IF;
    SELECT INTO theacquisitionframeworkid
        src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework(public.fct_c_slugify(new.item ->> 'short_name'),
                                                                     'Autogenerated acquisition framework from VisioNature',
                                                                     now()::DATE);
    PERFORM
        src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id(public.fct_c_slugify(new.item ->> 'short_name'),
                                                                NULL::text,
                                                                theacquisitionframeworkid
            );
    RETURN new;
END
$upsert_entities$
;

-- ALTER FUNCTION src_lpodatas.fct_c_tri_upsert_entities(_site VARCHAR, _item JSONB) OWNER TO geonatadmin;

COMMENT ON FUNCTION src_lpodatas.fct_c_tri_upsert_entities() IS 'Upsert visionature entity to Usershub organisms'
;

DROP TRIGGER IF EXISTS tri_c_upsert_entities ON src_vn_json.entities_json
;

CREATE TRIGGER tri_c_upsert_entities
    BEFORE INSERT OR UPDATE
    ON src_vn_json.entities_json
    FOR EACH ROW
EXECUTE FUNCTION src_lpodatas.fct_c_tri_upsert_entities()
;


/* Function to get organism id from entity site/id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_organisme_from_vn_id(_site VARCHAR, _id INT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_organisme_from_vn_id(_site VARCHAR, _id TEXT)
    RETURNS INTEGER
    LANGUAGE plpgsql AS
$get_organisme_from_vn_id$
DECLARE
    theorganismid INT;
BEGIN
    SELECT INTO
        theorganismid
        id_organisme
        FROM
            utilisateurs.bib_organismes
        WHERE
            additional_data #>> ('{from_vn,' || _site || ',id_entity}')::TEXT[] = _id
        LIMIT 1;
    RETURN theorganismid;
END;
$get_organisme_from_vn_id$
;


CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_dataset_from_observer_uid(_uid TEXT)
    RETURNS INTEGER
    LANGUAGE plpgsql AS
$get_organisme_from_vn_id$
DECLARE
    thedatasetid INT;
BEGIN
    SELECT INTO
        thedatasetid
        id_dataset
        FROM
            gn_meta.t_datasets
          , utilisateurs.t_roles
                JOIN utilisateurs.bib_organismes ON t_roles.id_organisme = bib_organismes.id_organisme
        WHERE
              t_roles.champs_addi #>> '{from_vn,id_universal}' = _uid
          AND t_datasets.additional_data #>> '{standard_name}' = bib_organismes.additional_data #>> '{from_vn, short_name}'
        LIMIT 1;
    RETURN thedatasetid;
END;
$get_organisme_from_vn_id$
    IMMUTABLE
    STRICT
;

COMMIT;