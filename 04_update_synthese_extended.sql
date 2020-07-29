/* Peuplement auto de la synthèse étendue LPO */

/* Générer les sources si absentes */

SELECT *
    FROM
        gn_synthese.t_sources;


CREATE FUNCTION src_lpodatas.fct_tri_upsert_observer() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    /* Partie gn_synthese.synthese */
    the_unique_id_sinp                       UUID;
    the_unique_id_sinp_grp                   UUID;
    the_id_source                            INTEGER;
    the_entity_source_pk_value               VARCHAR;
    the_id_dataset                           INTEGER;
    the_id_nomenclature_geo_object_nature    INTEGER;
    the_id_nomenclature_geo_object_nature    INTEGER;
    the_id_nomenclature_grp_typ              INTEGER;
    the_id_nomenclature_obs_meth             INTEGER;
    the_id_nomenclature_obs_technique        INTEGER;
    the_id_nomenclature_bio_status           INTEGER;
    the_id_nomenclature_bio_condition        INTEGER;
    the_id_nomenclature_naturalness          INTEGER;
    the_id_nomenclature_exist_proof          INTEGER;
    the_id_nomenclature_valid_status         INTEGER;
    the_id_nomenclature_diffusion_level      INTEGER;
    the_id_nomenclature_life_stage           INTEGER;
    the_id_nomenclature_sex                  INTEGER;
    the_id_nomenclature_obj_count            INTEGER;
    the_id_nomenclature_type_count           INTEGER;
    the_id_nomenclature_sensitivity          INTEGER;
    the_id_nomenclature_observation_status   INTEGER;
    the_id_nomenclature_blurring             INTEGER;
    the_id_nomenclature_source_status        INTEGER;
    the_id_nomenclature_info_geo_type        INTEGER;
    the_count_min                            INTEGER;
    the_count_max                            INTEGER;
    the_cd_nom                               INTEGER; -- TODO Pour les non match, cd_nom de Animalia
    the_nom_cite                             VARCHAR;
    the_meta_v_taxref                        VARCHAR;
    the_sample_number_proof                  VARCHAR;
    the_digital_proof                        VARCHAR;
    the_non_digital_proof                    VARCHAR;
    the_altitude_min                         INTEGER;
    the_altitude_max                         INTEGER;
    _the_geom_4326                           GEOMETRY(Geometry, 4326);
    _the_geom_point                          GEOMETRY(Point, 4326);
    _the_geom_local                          GEOMETRY(Geometry, 2154);
    the_date_min                             TIMESTAMP;
    the_date_max                             TIMESTAMP;
    the_validation_comment                   TEXT;
    the_observers                            TEXT;
    the_id_digitiser                         INTEGER;
    the_id_nomenclature_determination_method INTEGER;
    the_comments                             TEXT;
    the_meta_create_date                     TIMESTAMP;
    the_meta_update_date                     TIMESTAMP;

    /* Partie src_lpodatas.synthese_extended */
    the_observation_detail                   JSONB,
    the_id_sp_source                         INTEGER,
    the_taxo_group          VARCHAR(50),
    the_taxo_real           BOOLEAN, -- TODO plus tard, taxon vrai uniquement si rang IN ('ES','SSES')
    the_common_name         VARCHAR(250),
    the_pseudo_observer_uid VARCHAR(200), -- TODO Renseigner avec la fonction actuelle
    the_bird_breed_code     INTEGER,
    the_bird_breed_status   VARCHAR(20),
    the_bat_breed_colo      BOOLEAN,
    the_bat_is_gite         BOOLEAN,
    the_bat_period          VARCHAR(20),
    the_estimation_code     VARCHAR(50),
    the_date_year           INTEGER,
    the_mortality           BOOLEAN,
    the_mortality_cause     VARCHAR(250),
    the_export_excluded     BOOLEAN,
    the_project_code        VARCHAR(250),
    the_juridical_person    VARCHAR(100),
    the_behaviour           TEXT[],
    the_geo_accuracy        VARCHAR(50),
    the_details             JSONB,
    the_id_place            INT,
    the_place               VARCHAR(250),
    the_id_form             VARCHAR(20),
    the_is_valid            BOOLEAN,
    the_private_comment     TEXT,
    the_is_hidden           BOOLEAN DEFAULT FALSE
BEGIN
    SELECT CAST(new.item #>> '{species,@id}' AS INTEGER) INTO the_id_sp_source;

    /* Partie gn_synthese.synthese */

    SELECT src_lpodatas.get_observation_uuid(new.site, new.id) INTO the_unique_id_sinp;
    /* TODO récupérer un UUID pour les formulaires */
    SELECT NULL INTO the_unique_id_sinp_grp;
    SELECT src_lpodatas.fct_upsert_or_get_source_from_visionature(new.site) INTO the_id_source;
    SELECT new.id INTO the_entity_source_pk_value;
    SELECT
        gn_meta.fct_insert_or_get_dataset_from_shortname(new.item #>> '{observers,0,project_code}')
        INTO the_id_dataset;
    /* TODO Suite */
    SELECT
        ref_nomenclatures.fct_get_synonymes_nomenclature('NAT_OBJ_GEO',
                                                         (new.item #>> '{observers,0,precision}')
                                                             INTO the_id_nomenclature_geo_object_nature;
    SELECT
        gn_synthese.get_default_nomenclature_value(
                'TYP_GRP'::CHARACTER VARYING)
        INTO the_id_nomenclature_grp_typ;
    SELECT
--         ref_nomenclatures.fct_get_synonymes_nomenclature('METH_OBS',
--                                                          new.item #>> '{observers,0,details,0,condition}')
gn_synthese.get_default_nomenclature_value('METH_OBS')
        INTO the_id_nomenclature_obs_meth;
    SELECT
--         coalesce(
--                 ref_nomenclatures.fct_get_synonymes_nomenclature('TECHNIQUE_OBS',
--                                                                  new.item #>> '{observers,0,details,0,condition}'),
--                 ref_nomenclatures.fct_get_synonymes_nomenclature('TECHNIQUE_OBS',
--                                                                  new.item #>> '{observers,0,details,0,age}'))
gn_synthese.get_default_nomenclature_value('TECHNIQUE_OBS')
        INTO the_id_nomenclature_obs_technique;
    SELECT
--         coalesce(
--                 coalesce(
--                         ref_nomenclatures.fct_get_synonymes_nomenclature('STATUT_BIO',
--                                                                          new.item #>> '{observers,0,details,atlas_code}'),
--                         ref_nomenclatures.fct_get_synonymes_nomenclature('STATUT_BIO',
--                                                                          new.item #>> '{observers,0,details,0,condition}'))
--             , gn_synthese.get_default_nomenclature_value('STATUT_BIO'))
gn_synthese.get_default_nomenclature_value('STATUT_BIO')
        INTO the_id_nomenclature_bio_status;
    SELECT
--         coalesce(
--                 ref_nomenclatures.fct_get_synonymes_nomenclature('ETA_BIO',
--                                                                  new.item #>> '{observers,0,details,0,condition}'),
--             , gn_synthese.get_default_nomenclature_value('ETA_BIO'))
gn_synthese.get_default_nomenclature_value('ETA_BIO') )
        INTO the_id_nomenclature_bio_condition;
    SELECT
        gn_synthese.get_default_nomenclature_value(
                'NATURALITE'::CHARACTER VARYING)
        INTO the_id_nomenclature_naturalness;
    SELECT
        coalesce(ref_nomenclatures.fct_get_synonymes_nomenclature('PREUVE_EXIST',
                                                                  new.item #>> '{observers,0,medias,0,type}'),
                 gn_synthese.get_default_nomenclature_value('PREUVE_EXIST'))
        INTO the_id_nomenclature_exist_proof;
    SELECT
            --TODO When chr or chn accepted then certain, when admin_hidden then is douteux else probable.
        INTO the_id_nomenclature_valid_status;
    SELECT
        CASE
            WHEN cast(new.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL)
                THEN ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '4')
            ELSE ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '5')
            END
        INTO the_id_nomenclature_diffusion_level;
    SELECT
--         coalesce(ref_nomenclatures.fct_get_synonymes_nomenclature('STADE_VIE',
--                                                                   new.item #>> '{observers,0,details,0,age}'),
--                  gn_synthese.get_default_nomenclature_value('STADE_VIE'))
gn_synthese.get_default_nomenclature_value('STADE_VIE') )
    INTO
        INTO the_id_nomenclature_life_stage;
    SELECT gn_synthese.get_default_nomenclature_value('SEXE') INTO the_id_nomenclature_sex;
    SELECT ref_nomenclatures.get_id_nomenclature('OBJ_DENBR', 'IND') INTO the_id_nomenclature_obj_count;
    SELECT
        ref_nomenclatures.fct_get_synonymes_nomenclature('STADE_VIE',
                                                         new.item #>> '{observers,0,estimation_code}')
        INTO the_id_nomenclature_type_count;
    SELECT
        CASE
            WHEN new.item #>> '{observers,0,hidden}' THEN ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '4')
            ELSE ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '0') END
        INTO the_id_nomenclature_sensitivity;
    SELECT
        CASE
            WHEN (cast(new.item #>> '{observers,0,count}' AS INTEGER) = '0' AND
                  cast(new.item #>> '{observers,0,count}' AS INTEGER) LIKE 'EXACT_VALUE')
                THEN ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
            ELSE ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'Pr')
            END
        INTO the_id_nomenclature_observation_status;
    SELECT ref_nomenclatures.get_id_nomenclature('DEE_FLOU', 'NON') INTO the_id_nomenclature_blurring;
    SELECT ref_nomenclatures.get_id_nomenclature('DEE_FLOU', 'NSP') INTO the_id_nomenclature_source_status;
    SELECT
        ref_nomenclatures.fct_get_synonymes_nomenclature('TYP_INF_GEO', new.item #>> '{observers,0,precision}')
        INTO the_id_nomenclature_info_geo_type;
    SELECT CAST(new.item #>> '{observers,0,count}' AS INTEGER) INTO the_count_min;
    SELECT CAST(new.item #>> '{observers,0,count}' AS INTEGER) INTO the_count_max;
    SELECT src_lpodatas.fct_get_taxref_values_from_vn('cd_nom', the_id_sp_source) INTO the_cd_nom;
    SELECT src_lpodatas.get_species_values_from_vn('latin_name', the_id_sp_source) INTO the_nom_cite;
    SELECT gn_commons.get_default_parameter('taxref_version', NULL) INTO the_meta_v_taxref;
    SELECT NULL INTO the_sample_number_proof;
    SELECT
        src_lpodatas.fct_get_medias_url_from_visionature_medias_array(new.item #> '{observers,0,medias}')
        INTO the_digital_proof;
    SELECT NULL INTO the_non_digital_proof;
    SELECT CAST(new.item #>> '{observers,0,altitude}' AS INTEGER) INTO the_altitude_min;
    SELECT CAST(new.item #>> '{observers,0,altitude}' AS INTEGER) INTO the_altitude_max;
    SELECT
        public.st_makepoint(
                CAST(((new.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
                CAST(((new.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT))
      , 4326)
        INTO _the_geom_4326;
    SELECT _the_geom_4326 INTO _the_geom_point;
    SELECT public.st_transform(_the_geom_4326, 2154) INTO _the_geom_local;
    SELECT to_timestamp(CAST(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION)) INTO the_date_min;
    SELECT to_timestamp(CAST(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION)) INTO the_date_max;
    SELECT NULL INTO the_validation_comment;
    SELECT
        src_lpodatas.fct_get_observer_full_name_from_vn(CAST((new.item #>> '{observers,0,@uid}') AS INTEGER))
        INTO the_observers;
    SELECT src_lpodatas.fct_get_id_role_from_visionature_uid(new.item #>> '{observers,0,@uid}') INTO the_id_digitiser;
    SELECT
--         COALESCE(
--                 ref_nomenclatures.fct_get_synonymes_nomenclature('METH_DETERMIN',
--                                                                  new.item #>> '{observers,0,details,0,condition}'),
--             , gn_synthese.get_default_nomenclature_value('METH_DETERMIN'))
gn_synthese.get_default_nomenclature_value('METH_DETERMIN')
        INTO the_id_nomenclature_determination_method;
    SELECT new.item #>> '{observers,0,comment}' INTO the_comments;
    SELECT to_timestamp(CAST(new.item #>> '{observers,0,insert_date}' AS DOUBLE PRECISION)) INTO the_meta_create_date;
    SELECT to_timestamp(CAST(new.item #>> '{observers,0,update_date}' AS DOUBLE PRECISION)) INTO the_meta_update_date;
    /* Partie src_lpodatas.synthese_extended */

    SELECT
        src_lpodatas.fct_get_taxo_group_values_from_vn('name', new.site, CAST(new.item #>> '{species,taxonomy}' AS INT))
        INTO the_taxo_group;
    SELECT
            src_lpodatas.fct_get_taxref_values_from_vn('id_rang'::TEXT, cast(item #>> '{species,@id}' AS INTEGER)) IN
            ('ES', 'SSES')
        INTO the_taxo_real;
    SELECT
        CASE
            WHEN src_lpodatas.fct_get_taxref_values_from_vn('cd_nom'::TEXT, the_id_sp_source) IS NOT NULL
                THEN split_part(src_lpodatas.fct_get_taxref_values_from_vn('nom_vern'::TEXT, the_source_id_sp), ',', 1)
            ELSE src_lpodatas.get_species_values_from_vn('french_name'::TEXT, the_id_sp_source)
            END
        INTO the_common_name;
    SELECT change INTO the_pseudo_observer_uid;
    SELECT CAST(new.item #>> '{observers,0,atlas_code}' AS INTEGER) INTO the_bird_breed_code;
    SELECT
        ref_nomenclatures.get_nomenclature_label_from_id('VN_ATLAS_CODE', new.item #>> '{observers,0,atlas_code}')
        INTO the_bird_breed_status;
    SELECT NULL INTO the_bat_breed_colo;
    SELECT NULL INTO the_bat_is_gite;
    SELECT NULL INTO the_bat_period;
    SELECT new.item #>> '{observers,0,atlas_code}' INTO the_estimation_code;
    SELECT
        CAST(EXTRACT(YEAR FROM to_timestamp(CAST(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))) AS INTEGER)
        INTO the_date_year;
    SELECT
        CAST(((new.item #>> '{observers,0,extended_info,mortality}'::TEXT[]) IS NOT NULL) AS BOOLEAN)
        INTO the_mortality;
    SELECT new.item #>> '{observers,0,extended_info, mortality, death_cause2}' INTO the_mortality_cause;
    SELECT FALSE INTO the_export_excluded;
    SELECT new.item #>> '{observers,0,project_code}' INTO the_project_code;
    SELECT
        src_lpodatas.fct_get_entity_from_observer_site_uid(
                CAST((new.item #>> '{observers,0,@uid}') AS INTEGER), new.site)
        INTO the_juridical_person;
    SELECT
        src_lpodatas.fct_get_behaviours_texts_array_from_id_array(new.item #> '{observers,0,behaviours}')
        INTO the_behaviour;
    SELECT new.item #>> '{observers,0,precision}' INTO the_geo_accuracy;
    SELECT new.item #> '{observers,0,details}' INTO the_details;
    SELECT CAST(new.item #>> '{place,@id}' AS INTEGER) INTO the_id_place;
    SELECT new.item #>> '{place,name}' INTO the_place;
    SELECT new.id_form_universal INTO the_id_form;
    SELECT COALESCE(NOT CAST(((new.item #>> '{observers,0,admin_hidden}' AS BOOLEAN), TRUE) INTO the_is_valid;
    SELECT new.item #>> '{observers,0,hidden_comment}' INTO the_private_comment;
    SELECT CAST(new.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL) INTO the_is_hidden;
END;
$$;
--
-- drop function test(_source TEXT);
-- CREATE FUNCTION test(_source TEXT) RETURNS INTEGER
--     LANGUAGE plpgsql
-- AS
-- $$
-- DECLARE
--     /* Partie gn_synthese.synthese */
--     the_id_source INTEGER;
-- BEGIN
--     /* Partie gn_synthese.synthese */
--     SELECT src_lpodatas.fct_upsert_or_get_source_from_visionature(_source) INTO the_id_source;
--     RETURN the_id_source;
-- END;
-- $$;
-- select test('vn07');
