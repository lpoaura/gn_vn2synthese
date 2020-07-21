/*
  Child table with specific datas from:
    - VisioNature
    - dbChiroWeb

*/

CREATE TABLE IF NOT EXISTS gn_synthese.custom_datas
(
    id_sp_source        INTEGER,
    groupe_taxo         VARCHAR(50),
    taxon_vrai          BOOLEAN,
    nom_vern            VARCHAR(250),
    nom_sci             VARCHAR(250),
    pseudo_observer_uid VARCHAR(200),
    oiso_code_nidif     INTEGER,
    oiso_statut_nidif   VARCHAR(20),
    cs_colo_repro       BOOLEAN,
    cs_is_gite          BOOLEAN,
    cs_periode          VARCHAR(20),
    code_estimation     VARCHAR(50),
    date_an             INTEGER,
    mortalite           BOOLEAN,
    mortalite_cause     VARCHAR(250),
    exp_excl            BOOLEAN,
    code_etude          VARCHAR(250),
    pers_morale         VARCHAR(100),
    comportement        TEXT[],
    precision           VARCHAR(50),
    details             JSONB,
    id_place            INT,
    place               VARCHAR(250),
    formulaire          VARCHAR(50),
    id_formulaire       VARCHAR(20),
    is_valid            BOOLEAN,
    donnee_cachee       BOOLEAN DEFAULT FALSE
) INHERITS (gn_synthese.synthese);

COMMENT ON COLUMN gn_synthese.custom_datas.id_sp_source IS 'Code espèce de la source (VisioNature/dbChiroWeb)';
COMMENT ON COLUMN gn_synthese.custom_datas.groupe_taxo IS 'Groupe taxonomique VisioNature';
COMMENT ON COLUMN gn_synthese.custom_datas.taxon_vrai IS 'True si Taxon Vrai';
COMMENT ON COLUMN gn_synthese.custom_datas.nom_vern IS 'Nom vernaculaire';
COMMENT ON COLUMN gn_synthese.custom_datas.nom_sci IS 'Nom scientifique';
COMMENT ON COLUMN gn_synthese.custom_datas.pseudo_observer_uid IS 'Identifiant chiffré de l''Observateur pour anonymisation';
COMMENT ON COLUMN gn_synthese.custom_datas.oiso_code_nidif IS 'Codes "Biolovision" de nidification https://wiki.biolovision.net/Correspondance_codes_atlas';
COMMENT ON COLUMN gn_synthese.custom_datas.oiso_statut_nidif IS 'Statut de nidification simplifié (Nicheur possible, probable, certain) d''après oiso_code_nidif';
COMMENT ON COLUMN gn_synthese.custom_datas.cs_colo_repro IS 'Colonie de reproduction de chauves-souris';
COMMENT ON COLUMN gn_synthese.custom_datas.cs_is_gite IS 'Gite à chauves-souris';
COMMENT ON COLUMN gn_synthese.custom_datas.cs_period IS 'Période du cycle annuel des chauves-souris (hivernage, transit printanier ou automnal, estivage)';
COMMENT ON COLUMN gn_synthese.custom_datas.code_estimation IS 'Code caractérisant le type d''estimation du comptage';
COMMENT ON COLUMN gn_synthese.custom_datas.date_an IS 'Année de l''observation';
COMMENT ON COLUMN gn_synthese.custom_datas.mortalite IS 'Est une donnée de mortalité';
COMMENT ON COLUMN gn_synthese.custom_datas.mortalite_cause IS 'Cause identifiée de la mortalité';
COMMENT ON COLUMN gn_synthese.custom_datas.exp_excl IS 'A exclure des exports';
COMMENT ON COLUMN gn_synthese.custom_datas.code_etude IS 'Code étude';
COMMENT ON COLUMN gn_synthese.custom_datas.pers_morale IS 'Personne morale';
COMMENT ON COLUMN gn_synthese.custom_datas.comportement IS 'Liste (format ARRAY) des comportements observés';
COMMENT ON COLUMN gn_synthese.custom_datas.precision IS 'Précision géographique de la donnée';
COMMENT ON COLUMN gn_synthese.custom_datas.details IS 'Détails de la donnée (format JSON)';
COMMENT ON COLUMN gn_synthese.custom_datas.id_place IS 'identifiant du Lieu-dit';
COMMENT ON COLUMN gn_synthese.custom_datas.place IS 'Nom du Lieu-dit';
COMMENT ON COLUMN gn_synthese.custom_datas.formulaire IS 'Type de formulaire';
COMMENT ON COLUMN gn_synthese.custom_datas.id_formulaire IS 'identifiant du formulaire';
COMMENT ON COLUMN gn_synthese.custom_datas.is_valid IS 'Donnée validée';
COMMENT ON COLUMN gn_synthese.custom_datas.donnee_cachee IS 'Donnée cachée';


/* Create a default dataset for new studies */

DROP FUNCTION IF EXISTS gn_meta.create_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE);

CREATE OR REPLACE FUNCTION gn_meta.create_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) RETURNS VOID
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
END
$$
    LANGUAGE plpgsql;

ALTER FUNCTION gn_meta.create_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.create_basic_acquisition_framework(_name TEXT, _desc TEXT, _startdate DATE) IS 'function to basically create acquisition framework';

/* Function to basically create new dataset attached to an acquisition_framework find by name */

DROP FUNCTION IF EXISTS gn_meta.create_default_dataset_with_shortname(_acname TEXT, _shortname TEXT);

CREATE OR REPLACE FUNCTION gn_meta.create_default_dataset_with_shortname(_acname TEXT, _shortname TEXT) RETURNS INTEGER
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
            ( gn_meta.get_id_acquisition_framework_by_name(_acname)
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

ALTER FUNCTION gn_meta.create_default_dataset_with_shortname(_acname TEXT, _shortname TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.create_default_dataset_with_shortname(_acname TEXT, _shortname TEXT) IS 'function to basically create acquisition framework';


SELECT gn_meta.create_default_dataset_with_shortname('<unclassified>', 'test');
DELETE
    FROM
        gn_meta.t_datasets
    WHERE
            id_acquisition_framework IN
            (SELECT
                 id_acquisition_framework
                 FROM
                     gn_meta.t_acquisition_frameworks
                 WHERE
                     acquisition_framework_name LIKE '<unclassified>');


/* New function to get acquisition framework id by name */

DROP FUNCTION IF EXISTS gn_meta.get_id_acquisition_framework_by_name(_name TEXT);

CREATE OR REPLACE FUNCTION gn_meta.get_id_acquisition_framework_by_name(_name TEXT) RETURNS INTEGER
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

ALTER FUNCTION gn_meta.get_id_acquisition_framework_by_name(_name TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.get_id_acquisition_framework_by_name(_name TEXT) IS 'function to get acquisition framework id by name';

SELECT gn_meta.get_id_acquisition_framework_by_name('<unclassified>');


/* New function to get dataset id by shortname */

DROP FUNCTION IF EXISTS gn_meta.get_id_dataset_by_shortname(_shortname TEXT);

CREATE OR REPLACE FUNCTION gn_meta.get_id_dataset_by_shortname(_shortname TEXT) RETURNS INTEGER
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

ALTER FUNCTION gn_meta.get_id_dataset_by_shortname(_shortname TEXT) OWNER TO geonature;

COMMENT ON FUNCTION gn_meta.get_id_dataset_by_shortname(_shortname TEXT) IS 'function to get dataset id by shortname';

--SELECT gn_meta.get_id_dataset_by_shortname('dbChiroGCRA');


/* Create default acquisition framework */

SELECT
    gn_meta.create_basic_acquisition_framework('<unclassified>',
                                               '[Ne pas toucher] Cadre d''acquisition par défaut pour tout nouveau code étude',
                                               '1900-01-01');















