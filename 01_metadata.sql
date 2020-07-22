/* Create a default dataset for new studies */

DROP FUNCTION IF EXISTS gn_meta.fct_insert_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE);

CREATE OR REPLACE FUNCTION gn_meta.fct_insert_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) RETURNS INTEGER
AS
$$
DECLARE
    thenewid INT ;
BEGIN
    IF (SELECT
            exists(SELECT
                       1
                       FROM
                           gn_meta.t_acquisition_frameworks
                       WHERE
                           acquisition_framework_name LIKE _name)) THEN
        SELECT
            id_acquisition_framework
            INTO thenewid
            FROM
                gn_meta.t_acquisition_frameworks
            WHERE
                acquisition_framework_name = _name;
        RAISE NOTICE 'Acquisition framework named % already exists', _name;
    ELSE

        INSERT INTO
            gn_meta.t_acquisition_frameworks( acquisition_framework_name
                                            , acquisition_framework_desc
                                            , acquisition_framework_start_date)
            VALUES
                (_name, _desc, _startdate)
            RETURNING id_acquisition_framework INTO thenewid;
        RAISE NOTICE 'Acquisition framework named % inserted with id %', _name, thenewid;
    END IF;
    RETURN thenewid;
END
$$
    LANGUAGE plpgsql;

ALTER FUNCTION gn_meta.fct_insert_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.fct_insert_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) IS 'function to basically create acquisition framework';

/* Function to basically create new dataset attached to an acquisition_framework find by name */

DROP FUNCTION IF EXISTS gn_meta.fct_insert_or_get_dataset_from_shortname(_acname TEXT, _shortname TEXT);

CREATE OR REPLACE FUNCTION gn_meta.fct_insert_or_get_dataset_from_shortname(_acname TEXT, _shortname TEXT) RETURNS INTEGER
AS
$$
DECLARE
    thenewid INT ;
BEGIN
    IF (SELECT
            exists(SELECT
                       1
                       FROM
                           gn_meta.t_datasets
                       WHERE
                           dataset_shortname LIKE _shortname)) THEN
        SELECT id_dataset INTO thenewid FROM gn_meta.t_datasets WHERE dataset_shortname LIKE _shortname;
        RAISE NOTICE 'Dataset shortnamed % already exists with id %', _shortname, thenewid;
    ELSE
        INSERT INTO
            gn_meta.t_datasets( id_acquisition_framework
                              , dataset_name
                              , dataset_shortname
                              , dataset_desc
                              , marine_domain
                              , terrestrial_domain)
            VALUES
            ( gn_meta.fct_get_id_acquisition_framework_by_name(_acname)
            , '[' || _shortname || '] Jeu de données compléter'
            , _shortname
            , 'A compléter'
            , FALSE
            , TRUE)
            RETURNING id_dataset INTO thenewid;
        RAISE NOTICE 'Dataset shortnamed % inserted with id %', _shortname, thenewid;
        RETURN thenewid;
    END IF;
    RETURN thenewid;
END
$$
    LANGUAGE plpgsql;

ALTER FUNCTION gn_meta.fct_insert_or_get_dataset_from_shortname(_acname TEXT, _shortname TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.fct_insert_or_get_dataset_from_shortname(_acname TEXT, _shortname TEXT) IS 'function to basically create acquisition framework';

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

DROP FUNCTION IF EXISTS gn_meta.fct_get_id_acquisition_framework_by_name(_name TEXT);

CREATE OR REPLACE FUNCTION gn_meta.fct_get_id_acquisition_framework_by_name(_name TEXT) RETURNS INTEGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    theidacquisitionframework INTEGER;
BEGIN
    --Retrouver l'id du module par son code
    SELECT INTO theidacquisitionframework
        id_acquisition_framework
        FROM
            gn_meta.t_acquisition_frameworks
        WHERE
            acquisition_framework_name ILIKE _name
        LIMIT 1;
    RETURN theidacquisitionframework;
END;
$$;

ALTER FUNCTION gn_meta.fct_get_id_acquisition_framework_by_name(_name TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.fct_get_id_acquisition_framework_by_name(_name TEXT) IS 'function to get acquisition framework id by name';

SELECT gn_meta.fct_get_id_acquisition_framework_by_name('<unclassified>');


/* New function to get dataset id by shortname */

DROP FUNCTION IF EXISTS gn_meta.fct_get_id_dataset_by_shortname(_shortname TEXT);

CREATE OR REPLACE FUNCTION gn_meta.fct_get_id_dataset_by_shortname(_shortname TEXT) RETURNS INTEGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    theiddataset INTEGER;
BEGIN
    --Retrouver l'id du module par son code
    SELECT INTO theiddataset
        id_dataset
        FROM
            gn_meta.t_datasets
        WHERE
            dataset_shortname ILIKE _shortname;
    RETURN theiddataset;
END;
$$;

ALTER FUNCTION gn_meta.fct_get_id_dataset_by_shortname(_shortname TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.fct_get_id_dataset_by_shortname(_shortname TEXT) IS 'function to get dataset id by shortname';

--SELECT gn_meta.get_id_dataset_by_shortname('dbChiroGCRA');


/* Create default acquisition framework */

SELECT
    gn_meta.fct_insert_basic_acquisition_framework('<unclassified>',
                                                   '[Ne pas toucher] Cadre d''acquisition par défaut pour tout nouveau code étude',
                                                   '1900-01-01');


