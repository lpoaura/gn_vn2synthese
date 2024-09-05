/*
FUNCTIONS
---------
A collection of various helper fonctions
 */
/* Function to get taxo group from visionature id_species */
BEGIN;

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_taxo_group_values_from_vn (_key
    TEXT , _site TEXT , _id INTEGER , OUT _result TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxo_group_values_from_vn
    (_key TEXT , _site TEXT , _id INTEGER , OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE 'select item ->> $1 from src_vn_json.taxo_groups_json where taxo_groups_json.id = $3 and taxo_groups_json.site like $2 limit 1;' INTO _result
    USING _key , _site , _id;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_taxo_group_values_from_vn (_key TEXT
    , _site TEXT , _id INTEGER , OUT _result TEXT) IS 'Function to get taxo group from visionature id_species';


/* Function to get taxref datas from VN id_sp */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_taxref_values_from_vn
    (_field_name ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxref_values_from_vn
    (_field_name ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE format('SELECT taxref.%I from taxonomie.cor_c_vn_taxref join taxonomie.taxref on cor_c_vn_taxref.cd_nom = taxref.cd_nom where vn_id = $1 limit 1' , _field_name) INTO _result
    USING _id_species;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_taxref_values_from_vn (_field_name
    ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT) IS 'Function to get taxref datas from VN id_sp';


/* Function to get visionature species datas from VN id_sp */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_species_values_from_vn (_key
    ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_species_values_from_vn (_key
    ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE 'select item ->> $1 from src_vn_json.species_json where species_json.id = $2 limit 1;' INTO _result
    USING _key , _id_species;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_species_values_from_vn (_key
    ANYELEMENT , _id_species INTEGER , OUT _result ANYELEMENT) IS 'Function to get visionature species datas from VN id_sp';


/* Function to get observer full name from VisioNature observer universal id*/
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_observer_full_name_from_vn
    (_id_universal INTEGER , OUT _result TEXT);

CREATE FUNCTION src_lpodatas.fct_c_get_observer_full_name_from_vn
    (_id_universal INTEGER , OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE format('select concat(UPPER(item ->> ''name''), '' '', item ->> ''surname'') as text from src_vn_json.observers_json where observers_json.id_universal = $1 limit 1') INTO _result
    USING _id_universal;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_observer_full_name_from_vn
    (_id_universal INTEGER , OUT _result TEXT) IS 'Function to get observer full name from VisioNature observer universal id';


/* Function to get entity name from VisioNature observer universal id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_entity_from_observer_site_uid
    (_uid INTEGER , _site TEXT , OUT _result TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_entity_from_observer_site_uid
    (_uid INTEGER , _site TEXT , OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT
        INTO _result CASE WHEN ent.item ->> 'short_name' = '-' THEN
            NULL
        ELSE
            ent.item ->> 'short_name'
        END
    FROM
        src_vn_json.observers_json usr
        JOIN src_vn_json.entities_json ent ON (usr.site
            , cast(usr.item ->> 'id_entity' AS INT)) = (ent.site
            , ent.id)
    WHERE
        usr.id_universal = _uid
        AND usr.site = _site;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_entity_from_observer_site_uid (_uid
    INTEGER , _site TEXT , OUT _result TEXT) IS 'Function to get entity name from VisioNature observer universal id';


/* Function to generate an array of behaviours from VisioNature datas */
DROP FUNCTION IF EXISTS
    src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array (_behaviours
    JSONB , OUT _result TEXT[]);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array (_behaviours
    JSONB , OUT _result TEXT[])
    RETURNS TEXT[]
    LANGUAGE plpgsql
    AS $$
DECLARE
    _array_id TEXT[];
BEGIN
    IF _behaviours IS NOT NULL THEN
        SELECT
            array_agg(u.x)::TEXT[] INTO _array_id
        FROM (
            SELECT
                t.value ->> '@id' AS x
            FROM
                jsonb_array_elements(_behaviours) AS t) AS u;
        SELECT
            INTO _result array_agg(item ->> 'text')
        FROM
            src_vn_json.field_details_json
        WHERE
            id IN (
                SELECT
                    unnest(_array_id));
    ELSE
        SELECT
            NULL INTO _result;
    END IF;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array
    (_behaviours JSONB , OUT _result TEXT[]) IS 'Function to generate an array of behaviours from VisioNature datas';


/* list visionature medias URL from medias details */
DROP FUNCTION IF EXISTS
    src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (_medias
    JSONB , OUT _result TEXT);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (_medias
    JSONB , OUT _result TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF _medias IS NOT NULL THEN
        SELECT
            string_agg(u.x , ', ')::TEXT INTO _result
        FROM (
            SELECT
                concat(t.value ->> 'path' , '/' , t.value ->> 'filename') AS x
            FROM
                jsonb_array_elements(_medias) AS t) AS u;
    ELSE
        SELECT
            NULL INTO _result;
    END IF;
END;
$$;

COMMENT ON FUNCTION
    src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (_medias
    JSONB , OUT _result TEXT) IS 'Function to list medias URL from VisioNature datas';


/* Function to get observation generated UUID */
/* NOTE: removed because uuid are now available in faune-france API */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_observation_uuid (_site
    CHARACTER VARYING , _id INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_observation_uuid (_site
    CHARACTER VARYING , _id INTEGER)
    RETURNS UUID
    LANGUAGE plpgsql
    AS $$
DECLARE
    the_uuid UUID DEFAULT NULL;
BEGIN
    IF (
        SELECT
            EXISTS (
            SELECT
                *
            FROM
                information_schema.tables
            WHERE
                table_schema = 'src_vn_json' AND table_name = 'uuid_xref')) THEN
        SELECT
            uuid INTO the_uuid
        FROM
            src_vn_json.uuid_xref
        WHERE
            site LIKE _site
            AND id = _id
        LIMIT 1;
    END IF;
    RETURN the_uuid;
END;
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_observation_uuid () IS 'Function to get observation generated UUID';

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_taxon_diffusion_level (_cd_nom INT)
    RETURNS INT
    AS $$
DECLARE
    the_nomenclature_id INT;
BEGIN
    SELECT
        id_nomenclature_diffusion_level INTO the_nomenclature_id
    FROM
        src_lpodatas.t_c_rules_diffusion_level
    WHERE
        cd_nom = _cd_nom;
    RETURN the_nomenclature_id;
END;
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_committees_validation_status
    (_committees_validation JSONB);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_committees_validation_status
    (_committees_validation JSONB)
    RETURNS TEXT[]
    AS $$
DECLARE
    the_values TEXT[];
    the_rec RECORD;
BEGIN
    FOR the_rec IN (
        SELECT
            jsonb_object_keys(_committees_validation) AS key)
        LOOP
            SELECT
                array_append(the_values , _committees_validation ->> the_rec.key) INTO the_values;
        END LOOP;
    RETURN the_values;
END;
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS
    src_lpodatas.fct_c_get_committees_validation_is_accepted
    (_committees_validation JSONB);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_committees_validation_is_accepted
    (_committees_validation JSONB)
    RETURNS BOOLEAN
    AS $$
DECLARE
    is_accepted BOOLEAN;
BEGIN
    SELECT
	'ACCEPTED' = ANY
	    (src_lpodatas.fct_c_get_committees_validation_status
	    (_committees_validation)) INTO is_accepted;
    RETURN is_accepted;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_check_hidden_rules (_cd_nom INT ,
    _date_min TIMESTAMP , _raw_bird_breed_code INT)
    RETURNS BOOL
    AS $$
DECLARE
    the_bird_breed_code INT;
    the_has_hidden_rule BOOL;
BEGIN
    SELECT
        CASE WHEN _raw_bird_breed_code = 99 THEN
            NULL
        WHEN _raw_bird_breed_code = 30 THEN
            2
        WHEN _raw_bird_breed_code = 40 THEN
            4
        WHEN _raw_bird_breed_code = 50 THEN
            11
        ELSE
            _raw_bird_breed_code
        END INTO the_bird_breed_code;
    SELECT
        EXISTS (
            SELECT
                *
            FROM
                src_lpodatas.t_c_visionature_hidding_rules rule
            WHERE
                rule.cd_nom = _cd_nom
                AND (rule.all_time_restriction
		    OR (_date_min BETWEEN make_date(extract(YEAR FROM
			now())::INT , rule.restriction_start_month::INT ,
			rule.restriction_start_day::INT)
			AND make_date(extract(YEAR FROM now())::INT ,
			    rule.restriction_end_month::INT ,
			    rule.restriction_end_day::INT))
                    AND (rule.restriction_atlas_min_code IS NULL)
                    OR (rule.restriction_atlas_min_code IS NOT NULL
                        AND (the_bird_breed_code IS NOT NULL
                            AND the_bird_breed_code >= rule.restriction_atlas_min_code)))) INTO the_has_hidden_rule;
    RETURN the_has_hidden_rule;
END;
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_check_hidden_rules () IS 'Detect observations hidden by sensitivity rules';

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_diffusion_level (_cd_nom INT
    , _date_min TIMESTAMP , _raw_bird_breed_code INT , _item JSONB)
    RETURNS INT
    AS $$
DECLARE
    the_id_nomenclature_diffusion_level INT DEFAULT NULL;
    the_hidden_by_rules BOOL DEFAULT FALSE;
BEGIN
    /* Si la table des données de sensibilté visionature existe */
    IF (
        SELECT
            EXISTS (
            SELECT
            FROM
                information_schema.tables
            WHERE
                table_schema = 'src_lpodatas' AND table_name = 't_c_visionature_hidding_rules')) THEN
        /* Identifie si La donnée est cachée par une règle de sensibilité faune-france */
        SELECT
	    src_lpodatas.fct_c_check_hidden_rules (_cd_nom , _date_min ,
		_raw_bird_breed_code) INTO the_hidden_by_rules;


        /* Si la donnée est automatiquement cachée par une règle de sensibilité, alors on la diffuse précisément */
        --	 IF the_hidden_by_rules THEN
        --			 SELECT
        --       ref_nomenclatures.get_id_nomenclature('NIV_PRECIS',
        --	    '5')
        --			 INTO the_id_nomenclature_diffusion_level;
    END IF;


    /* sinon, on fait le check courant */
    SELECT
        CASE
        -- Taxons sensibles, règle dans la table src_lpodatas.t_c_rules_diffusion_level >
        --	    diffusion au cas par cas
        WHEN _cd_nom IN (
            SELECT
                cd_nom
            FROM
                src_lpodatas.t_c_rules_diffusion_level) THEN
            src_lpodatas.fct_c_get_taxon_diffusion_level (_cd_nom)
            -- Observation "cachée" automatiquement par les règles de sensibilités de
            --	    visionature > diffusion précise
        WHEN the_hidden_by_rules THEN
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS' , '5')
            -- Observation a priori cachée par l'observateur
        WHEN cast(_item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL) THEN
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS' , '2')
            -- Observation "invalide" (> refused) ou en ffquestionnement (> question)
        WHEN _item #>> '{observers,0,admin_hidden_type}' IN ('refused' , 'question') THEN
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS' , '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS' , '5')
        END INTO the_id_nomenclature_diffusion_level;
    RETURN the_id_nomenclature_diffusion_level;
END;
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_diffusion_level () IS 'Défini les règles de diffusion des données cachées';

COMMIT;
