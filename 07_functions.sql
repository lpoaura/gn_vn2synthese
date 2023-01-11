/*
FUNCTIONS
---------
A collection of various helper fonctions
*/


/* Function to get taxo group from visionature id_species */

BEGIN
;

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_taxo_group_values_from_vn (_key TEXT, _site TEXT, _id INTEGER, OUT _result TEXT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxo_group_values_from_vn(_key TEXT, _site TEXT, _id INTEGER, OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'select item ->> $1 from src_vn_json.taxo_groups_json where taxo_groups_json.id = $3 and taxo_groups_json.site like $2 limit 1;' INTO _result
        USING _key, _site, _id;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_taxo_group_values_from_vn (_key TEXT, _site TEXT, _id INTEGER, OUT _result TEXT) IS 'Function to get taxo group from visionature id_species'
;


/* Function to get taxref datas from VN id_sp */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_taxref_values_from_vn (_field_name ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxref_values_from_vn(_field_name ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE format(
            'SELECT taxref.%I from taxonomie.cor_c_vn_taxref join taxonomie.taxref on cor_c_vn_taxref.cd_nom = taxref.cd_nom where vn_id = $1 limit 1',
            _field_name) INTO _result
        USING _id_species;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_taxref_values_from_vn (_field_name ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT) IS 'Function to get taxref datas from VN id_sp'
;


/* Function to get visionature species datas from VN id_sp */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_species_values_from_vn (_key ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_species_values_from_vn(_key ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'select item ->> $1 from src_vn_json.species_json where species_json.id = $2 limit 1;' INTO _result
        USING _key, _id_species;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_species_values_from_vn (_key ANYELEMENT, _id_species INTEGER, OUT _result ANYELEMENT) IS 'Function to get visionature species datas from VN id_sp'
;


/* Function to get observer full name from VisioNature observer universal id*/
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_observer_full_name_from_vn (_id_universal INTEGER, OUT _result TEXT)
;

CREATE FUNCTION src_lpodatas.fct_c_get_observer_full_name_from_vn(_id_universal INTEGER, OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE format('select concat(UPPER(item ->> ''name''), '' '', item ->> ''surname'') as text from src_vn_json.observers_json where observers_json.id_universal = $1 limit 1') INTO _result
        USING _id_universal;
END;
$$
;


COMMENT ON FUNCTION src_lpodatas.fct_c_get_observer_full_name_from_vn (_id_universal INTEGER, OUT _result TEXT) IS 'Function to get observer full name from VisioNature observer universal id'
;


/* Function to get entity name from VisioNature observer universal id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_entity_from_observer_site_uid (_uid INTEGER, _site TEXT, OUT _result TEXT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_entity_from_observer_site_uid(_uid INTEGER, _site TEXT, OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT INTO _result
        CASE
            WHEN ent.item ->> 'short_name' = '-' THEN
                NULL
            ELSE
                ent.item ->> 'short_name'
            END
        FROM
            src_vn_json.observers_json usr
                JOIN src_vn_json.entities_json ent ON (usr.site,
                                                       cast(usr.item ->> 'id_entity' AS INT)) = (ent.site,
                                                                                                 ent.id)
        WHERE
              usr.id_universal = _uid
          AND usr.site = _site;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_entity_from_observer_site_uid (_uid INTEGER, _site TEXT, OUT _result TEXT) IS 'Function to get entity name from VisioNature observer universal id'
;


/* Function to generate an array of behaviours from VisioNature datas */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array (_behaviours JSONB, OUT _result TEXT[])
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array(_behaviours JSONB, OUT _result TEXT[])
    RETURNS TEXT[]
    LANGUAGE plpgsql
AS
$$
DECLARE
    _array_id TEXT[];
BEGIN
    IF _behaviours IS NOT NULL THEN
        SELECT
            array_agg(u.x)::TEXT[]
            INTO _array_id
            FROM
                (
                    SELECT
                        t.value ->> '@id' AS x
                        FROM
                            jsonb_array_elements(_behaviours) AS t) AS u;
        SELECT INTO _result
            array_agg(item ->> 'text')
            FROM
                src_vn_json.field_details_json
            WHERE
                    id IN (
                    SELECT
                        unnest(_array_id));
    ELSE
        SELECT
            NULL
            INTO _result;
    END IF;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array (_behaviours JSONB, OUT _result TEXT[]) IS 'Function to generate an array of behaviours from VisioNature datas'
;


/* list visionature medias URL from medias details */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (_medias JSONB, OUT _result TEXT)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array(_medias JSONB, OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF _medias IS NOT NULL THEN
        SELECT
            string_agg(u.x, ', ')::TEXT
            INTO _result
            FROM
                (
                    SELECT
                        concat(t.value ->> 'path', '/', t.value ->> 'filename') AS x
                        FROM
                            jsonb_array_elements(_medias) AS t) AS u;
    ELSE
        SELECT
            NULL
            INTO _result;
    END IF;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (_medias JSONB, OUT _result TEXT) IS 'Function to list medias URL from VisioNature datas'
;


/* Function to get observation generated UUID */
/* NOTE: removed because uuid are now available in faune-france API */

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_observation_uuid (_site CHARACTER VARYING, _id INTEGER) CASCADE
;


CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_observation_uuid(_site CHARACTER VARYING, _id INTEGER) RETURNS UUID
    LANGUAGE plpgsql
AS
$$
DECLARE
    the_uuid UUID DEFAULT NULL;
BEGIN
    IF (SELECT
            exists(
                    SELECT *
                        FROM
                            information_schema.tables
                        WHERE
                              table_schema = 'src_vn_json'
                          AND table_name = 'uuid_xref'
                )) THEN
        SELECT uuid INTO the_uuid FROM src_vn_json.uuid_xref WHERE site LIKE _site AND id = _id LIMIT 1;
    END IF;
    RETURN the_uuid;
END;
$$
;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_observation_uuid IS 'Function to get observation generated UUID'
;


CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxon_diffusion_level(_cd_nom INT)
    RETURNS INT AS
$$
DECLARE
    the_nomenclature_id INT;
BEGIN
    SELECT
        id_nomenclature_diffusion_level
        INTO the_nomenclature_id
        FROM
            src_lpodatas.t_c_rules_diffusion_level
        WHERE
            cd_nom = _cd_nom;
    RETURN the_nomenclature_id;
END;
$$ LANGUAGE plpgsql
;

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_committees_validation_status(_committees_validation JSONB)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_committees_validation_status(_committees_validation JSONB)
    RETURNS TEXT[] AS
$$
DECLARE
    the_values TEXT[];
    the_rec    RECORD;
BEGIN
    FOR the_rec IN (SELECT jsonb_object_keys(_committees_validation) AS key)
        LOOP
            SELECT
                array_append(the_values, _committees_validation ->> the_rec.key)
                INTO the_values;
        END LOOP;
    RETURN the_values;
END;
$$ LANGUAGE plpgsql
;

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_committees_validation_is_accepted(_committees_validation JSONB)
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_committees_validation_is_accepted(_committees_validation JSONB)
    RETURNS BOOLEAN AS
$$
DECLARE
    is_accepted BOOLEAN;
BEGIN
    SELECT 'ACCEPTED' = ANY (src_lpodatas.fct_c_get_committees_validation_status(_committees_validation)) INTO is_accepted;
    RETURN is_accepted;
END;
$$ LANGUAGE plpgsql
;


COMMIT
;