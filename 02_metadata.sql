/*
METADATA
--------
Various functions to generate metadata from VisioNature datas such as:
 - project_code
 - default values from gn_commons.t_parameters (if no project code)
 */
BEGIN;

DROP FUNCTION IF EXISTS
    src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT ,
    _desc TEXT , _startdate DATE);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT ,
    _desc TEXT , _startdate DATE)
    RETURNS INTEGER
    AS $$
DECLARE
    the_new_id INT;
BEGIN
    IF (
        SELECT EXISTS (
            SELECT 1
            FROM gn_meta.t_acquisition_frameworks
            WHERE t_acquisition_frameworks.additional_data #>> '{standard_name}' LIKE _name)) THEN
        SELECT id_acquisition_framework INTO the_new_id
        FROM gn_meta.t_acquisition_frameworks
        WHERE t_acquisition_frameworks.additional_data #>> '{standard_name}' LIKE _name;
        RAISE DEBUG 'Acquisition framework named % already exists' , _name;
    ELSE
	INSERT INTO gn_meta.t_acquisition_frameworks
	    (acquisition_framework_name , acquisition_framework_desc ,
	    acquisition_framework_start_date , additional_data ,
	    meta_create_date)
            VALUES (_name , _desc , _startdate , jsonb_build_object('standard_name' , _name) , now())
        RETURNING id_acquisition_framework INTO the_new_id;
        RAISE DEBUG 'Acquisition framework named % inserted with id %' , _name , the_new_id;
    END IF;
    RETURN the_new_id;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION
    src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework (_name TEXT ,
    _desc TEXT , _startdate DATE) IS 'function to basically create acquisition framework';

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_id_acquisition_framework_by_name
    (_name TEXT);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_id_acquisition_framework_by_name (_name TEXT)
    RETURNS INTEGER
    LANGUAGE plpgsql
    AS $$
DECLARE
    the_id_acquisition_framework INTEGER;
BEGIN
    --Retrouver l'id du module par son code
    SELECT INTO the_id_acquisition_framework id_acquisition_framework
    FROM gn_meta.t_acquisition_frameworks
    WHERE additional_data ->> 'standard_name' ILIKE _name
    LIMIT 1;
    RETURN the_id_acquisition_framework;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_acquisition_framework_by_name
    (_name TEXT) IS 'function to get acquisition framework id by name';


/* Function to basically create new dataset attached to an acquisition_framework find by name */
DROP FUNCTION IF EXISTS
    src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id
    (_shortname TEXT , _default_dataset TEXT , _id_framework INT);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id
    (_shortname TEXT , _default_dataset TEXT , _id_framework INT)
    RETURNS INTEGER
    AS $$
DECLARE
    the_id_dataset INT;
    the_shortname TEXT;
BEGIN
    /*  Si shortname est NULL:
     Si Dataset par défaut existe alors on récupère l'ID de ce dataset
     Sinon, on créée le dataset et on récupère son ID
     Si shortname est non NULL:
     Si Dataset basé sur ce shortname existe, alors on récupère l'ID de ce dataset
     Sinon, on le créée et on récupère son ID
     */
    SELECT coalesce(_shortname , gn_commons.get_default_parameter
	(_default_dataset , NULL)) INTO the_shortname;
    RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Data dataset is % ' , the_shortname;
    IF (
        SELECT EXISTS (
            SELECT 1
            FROM gn_meta.t_datasets
            WHERE additional_data #>> '{standard_name}' LIKE the_shortname)) THEN
        /* Si le JDD par défaut existe déjà, on récupère son ID */
        SELECT id_dataset INTO the_id_dataset
        FROM gn_meta.t_datasets
        WHERE additional_data #>> '{standard_name}' LIKE the_shortname;
        RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Dataset with shortname % exists with get ID : %' , the_shortname , the_id_dataset;
    ELSE
	INSERT INTO gn_meta.t_datasets (id_acquisition_framework , dataset_name
	    , dataset_shortname , dataset_desc , marine_domain ,
	    terrestrial_domain , additional_data , meta_create_date)
	    VALUES (_id_framework , '[' || the_shortname ||
		'] Jeu de données à compléter' , the_shortname , 'A compléter' , FALSE ,
		TRUE , jsonb_build_object('standard_name' , the_shortname) ,
		now())
        RETURNING id_dataset INTO the_id_dataset;
        RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Data dataset doesn''t exists, new dataset with shortname % created with ID : %' , the_shortname , the_id_dataset;
    END IF;
    RETURN the_id_dataset;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION
    src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id
    (_shortname TEXT , _default_dataset TEXT , _id_framework INT) IS
    'function to basically create acquisition framework with id_framework';


/* Function to basically create new dataset attached to an acquisition_framework find by name */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_or_insert_dataset_from_shortname
    (_shortname TEXT , _default_dataset TEXT , _default_acquisition_framework
    TEXT);

CREATE OR REPLACE FUNCTION
    src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (_shortname TEXT ,
    _default_dataset TEXT , _default_acquisition_framework TEXT)
    RETURNS INTEGER
    AS $$
DECLARE
    the_id_dataset INT;
    the_shortname TEXT;
BEGIN
    /*  Si shortname est NULL:
     Si Dataset par défaut existe alors on récupère l'ID de ce dataset
     Sinon, on créée le dataset et on récupère son ID
     Si shortname est non NULL:
     Si Dataset basé sur ce shortname existe, alors on récupère l'ID de ce dataset
     Sinon, on le créée et on récupère son ID
     */
    SELECT coalesce(_shortname , gn_commons.get_default_parameter
	(_default_dataset , NULL)) INTO the_shortname;
    RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Data dataset is % ' , the_shortname;
    IF (
        SELECT EXISTS (
            SELECT 1
            FROM gn_meta.t_datasets
            WHERE additional_data ->> 'standard_name' LIKE the_shortname)) THEN
        /* Si le JDD par défaut existe déjà, on récupère son ID */
        SELECT id_dataset INTO the_id_dataset
        FROM gn_meta.t_datasets
        WHERE additional_data ->> 'standard_name' LIKE the_shortname;
        RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Dataset with shortname % exists with get ID : %' , the_shortname , the_id_dataset;
    ELSE
	INSERT INTO gn_meta.t_datasets (id_acquisition_framework , dataset_name
	    , dataset_shortname , dataset_desc , marine_domain ,
	    terrestrial_domain , additional_data , meta_create_date)
	    VALUES
		(src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework
		(gn_commons.get_default_parameter
		(_default_acquisition_framework , NULL) , ''::TEXT ,
		now()::DATE) , '[' || the_shortname ||
		'] Jeu de données à compléter' , the_shortname , 'A compléter' , FALSE ,
		TRUE , jsonb_build_object('standard_name' , the_shortname) ,
		now())
        RETURNING id_dataset INTO the_id_dataset;
	INSERT INTO gn_meta.cor_dataset_actor (id_dataset , id_organism ,
	    id_nomenclature_actor_role)
	SELECT the_id_dataset , id_organisme ,
	    ref_nomenclatures.get_id_nomenclature ('ROLE_ACTEUR' ,
	    '6')
        FROM utilisateurs.bib_organismes
        WHERE additional_data #>> '{from_vn, short_name}' = _shortname
        LIMIT 1
    ON CONFLICT ON CONSTRAINT check_is_unique_cor_dataset_actor_organism
        DO NOTHING;

        IF (
            SELECT EXISTS (
                SELECT 1
                FROM utilisateurs.bib_organismes
		WHERE id_organisme = gn_commons.get_default_parameter
		    ('visionature_default_actor' , NULL)::INT)) THEN
	    INSERT INTO gn_meta.cor_dataset_actor (id_dataset , id_organism ,
		id_nomenclature_actor_role)
	SELECT the_id_dataset , gn_commons.get_default_parameter
	    ('visionature_default_metadata_actor' , NULL)::INT ,
	    ref_nomenclatures.get_id_nomenclature ('ROLE_ACTEUR' ,
	    '8')
        FROM utilisateurs.bib_organismes
        WHERE additional_data #>> '{from_vn, short_name}' = _shortname
        LIMIT 1
    ON CONFLICT ON CONSTRAINT check_is_unique_cor_dataset_actor_organism
        DO NOTHING;
        END IF;

        RAISE DEBUG '<fct_c_get_or_insert_dataset_from_shortname> Data dataset doesn''t exists, new dataset with shortname % created with ID : %' , the_shortname , the_id_dataset;
    END IF;
    RETURN the_id_dataset;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_or_insert_dataset_from_shortname
    (_shortname TEXT , _default_dataset TEXT , _default_acquisition_framework
    TEXT) IS 'function to basically create acquisition framework';

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_id_dataset_by_shortname
    (_shortname TEXT)
    RETURNS INTEGER
    LANGUAGE plpgsql
    AS $$
DECLARE
    the_id_dataset INTEGER;
BEGIN
    --Retrouver l'id du module par son code
    SELECT INTO the_id_dataset id_dataset
    FROM gn_meta.t_datasets
    WHERE additional_data ->> 'standard_name' LIKE _shortname;
    RETURN the_id_dataset;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_dataset_by_shortname (_shortname
    TEXT) IS 'function to get dataset id by shortname';

COMMIT;
