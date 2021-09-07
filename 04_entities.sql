/*
 Manage entities (= organismes) from VisioNature observers datas
 */

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


CREATE UNIQUE INDEX i_c_organism_adddata_vn_short_name ON utilisateurs.bib_organismes ((additional_data #>> '{from_vn, short_name}'))
;

/* Function to basically create new dataset attached to an acquisition_framework find by name */
CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_tri_upsert_entities()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$upsert_entities$
DECLARE
    theorganismid     INT;
    theorganismrecord RECORD;
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
        RAISE NOTICE '<fct_c_tri_upsert_entities> Entity % Already exists', new.item ->> 'short_name';
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
        RAISE NOTICE '<fct_c_tri_upsert_entities> Entity with VisioNature shortname % exists with get ID : %',
            theorganismrecord.nom_organisme, theorganismid;
    ELSE
        RAISE NOTICE '<fct_c_tri_upsert_entities> Entity % not found, start create', new.item ->> 'short_name';
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
        ON CONFLICT ((additional_data #>> '{from_vn, short_name}')) DO UPDATE
            SET
                additional_data =
                    jsonb_set(excluded.additional_data,
                              ('{from_vn,' || new.site || '}')::TEXT[],
                              jsonb_build_object('id_entity', new.item -> 'id_entity'),
                              TRUE)
            RETURNING id_organisme INTO theorganismid;
        RAISE NOTICE '<fct_c_tri_upsert_entities> entity % upserted', new.item ->> 'short_name';
    END IF;
    RETURN new;
END
$upsert_entities$
;

-- ALTER FUNCTION src_lpodatas.fct_c_tri_upsert_entities(_site VARCHAR, _item JSONB) OWNER TO geonatadmin;

COMMENT ON FUNCTION src_lpodatas.fct_c_tri_upsert_entities() IS 'Upsert visionature entity to Usershub organisms'
;

DROP TRIGGER tri_c_upsert_entities ON src_vn_json.entities_json
;

CREATE TRIGGER tri_c_upsert_entities
    BEFORE INSERT OR UPDATE
    ON src_vn_json.entities_json
    FOR EACH ROW
EXECUTE FUNCTION src_lpodatas.fct_c_tri_upsert_entities()
;


/* Function to get organism id from entity site/id */
DROP FUNCTION src_lpodatas.fct_c_get_organisme_from_vn_id(_site VARCHAR, _id INT);
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


--
-- UPDATE src_vn_json.entities_json
-- SET
--     site = site
-- ;
--

