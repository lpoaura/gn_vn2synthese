/* Create a default dataset for new studies */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT, _desc TEXT, _startdate DATE);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name text, _desc text, _startdate date)
    RETURNS integer
    AS $$
DECLARE
    the_new_id int;
BEGIN
    IF (
        SELECT
            EXISTS (
            SELECT
                1
            FROM
                gn_meta.t_acquisition_frameworks
            WHERE
                acquisition_framework_name LIKE _name)) THEN
        SELECT
            id_acquisition_framework INTO the_new_id
        FROM
            gn_meta.t_acquisition_frameworks
        WHERE
            acquisition_framework_name = _name;
        RAISE NOTICE 'Acquisition framework named % already exists', _name;
    ELSE
        INSERT INTO gn_meta.t_acquisition_frameworks (acquisition_framework_name, acquisition_framework_desc, acquisition_framework_start_date, meta_create_date)
            VALUES (_name, _desc, _startdate, now())
        RETURNING
            id_acquisition_framework INTO the_new_id;
        RAISE NOTICE 'Acquisition framework named % inserted with id %', _name, the_new_id;
    END IF;
    RETURN the_new_id;
END
$$
LANGUAGE plpgsql;

ALTER FUNCTION src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT, _desc TEXT, _startdate DATE) OWNER TO gnadm;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT, _desc TEXT, _startdate DATE) IS 'function to basically create acquisition framework';


/* Function to basically create new dataset attached to an acquisition_framework find by name */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (_shortname TEXT, _default_dataset TEXT, _default_acquisition_framework TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (_shortname text, _default_dataset text, _default_acquisition_framework text)
    RETURNS integer
    AS $$
DECLARE
    the_id_dataset int;
    the_id_acquisition_framework int;
    the_shortname text;
BEGIN
    /*  Si shortname est NULL:
     Si Dataset par défaut existe alors on récupère l'ID de ce dataset
     Sinon, on créée le dataset et on récupère son ID
     Si shortname est non NULL:
     Si Dataset basé sur ce shortname existe, alors on récupère l'ID de ce dataset
     Sinon, on le créée et on récupère son ID
     */
    SELECT
        coalesce(_shortname, gn_commons.get_default_parameter (_default_dataset)) INTO the_shortname;
    RAISE NOTICE '<fct_c_get_or_insert_dataset_from_shortname> Data dataset is % ', the_shortname;
    IF (
        SELECT
            EXISTS (
            SELECT
                1
            FROM
                gn_meta.t_datasets
            WHERE
                dataset_shortname LIKE the_shortname)) THEN
        /* Si le JDD par défaut existe déjà, on récupère son ID */
        SELECT
            id_dataset INTO the_id_dataset
        FROM
            gn_meta.t_datasets
        WHERE
            dataset_shortname LIKE the_shortname;
        RAISE NOTICE '<fct_c_get_or_insert_dataset_from_shortname> Dataset with shortname % exists with get ID : %', the_shortname, the_id_dataset;
    ELSE
        INSERT INTO gn_meta.t_datasets (id_acquisition_framework, dataset_name, dataset_shortname, dataset_desc, marine_domain, terrestrial_domain, meta_create_date)
            VALUES (src_lpodatas.fct_c_get_id_acquisition_framework_by_name (gn_commons.get_default_parameter (_default_acquisition_framework)), '[' || the_shortname || '] Jeu de données compléter', the_shortname, 'A compléter', FALSE, TRUE, now())
        RETURNING
            id_dataset INTO the_id_dataset;
        RAISE NOTICE '<fct_c_get_or_insert_dataset_from_shortname> Data dataset doesn''t exists, new dataset with shortname % created with ID : %', the_shortname, the_id_dataset;
    END IF;
    RETURN the_id_dataset;
END
$$
LANGUAGE plpgsql;

ALTER FUNCTION src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (_shortname TEXT, _default_dataset TEXT, _default_acquisition_framework TEXT) OWNER TO gnadm;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (_shortname TEXT, _default_dataset TEXT, _default_acquisition_framework TEXT) IS 'function to basically create acquisition framework';


/* TESTS */
--
-- SELECT gn_meta.create_default_dataset_with_shortname('<unclassified>', 'test');
-- DELETE
--     FROM
--         gn_meta.t_datasets
--     WHERE
--             id_acquisition_framework IN
--             (SELECT
--                  id_acquisition_framework
--                  FROM
--                      gn_meta.t_acquisition_frameworks
--                  WHERE
--                      acquisition_framework_name LIKE '<unclassified>');
/* New function to get acquisition framework id by name */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_id_acquisition_framework_by_name (_name TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_id_acquisition_framework_by_name (_name text)
    RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    theidacquisitionframework integer;
BEGIN
    --Retrouver l'id du module par son code
    SELECT
        INTO theidacquisitionframework id_acquisition_framework
    FROM
        gn_meta.t_acquisition_frameworks
    WHERE
        acquisition_framework_name ILIKE _name
    LIMIT 1;
    RETURN theidacquisitionframework;
END;
$$;

ALTER FUNCTION src_lpodatas.fct_c_get_id_acquisition_framework_by_name (_name TEXT) OWNER TO gnadm;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_acquisition_framework_by_name (_name TEXT) IS 'function to get acquisition framework id by name';


/* New function to get dataset id by shortname */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_id_dataset_by_shortname (_shortname TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_id_dataset_by_shortname (_shortname text)
    RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    theiddataset integer;
BEGIN
    --Retrouver l'id du module par son code
    SELECT
        INTO theiddataset id_dataset
    FROM
        gn_meta.t_datasets
    WHERE
        dataset_shortname ILIKE _shortname;
    RETURN theiddataset;
END;
$$;

ALTER FUNCTION src_lpodatas.fct_c_get_id_dataset_by_shortname (_shortname TEXT) OWNER TO gnadm;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_dataset_by_shortname (_shortname TEXT) IS 'function to get dataset id by shortname';

--SELECT gn_meta.get_id_dataset_by_shortname('dbChiroGCRA');
/* Create default acquisition framework */
--
--
-- SELECT DISTINCT
--     src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(item #>> '{observers,0,project_code}',
--                                                           'visionature_default_dataset',
--                                                           'visionature_default_acquisition_framework')
--   , count(*)
--     FROM
--         src_vn_json.observations_json
--     GROUP BY
--         item #>> '{observers,0,project_code}';
--
--
-- src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(_shortname TEXT, _default_dataset TEXT,
--                                                                                  _default_acquisition_framework TEXT
