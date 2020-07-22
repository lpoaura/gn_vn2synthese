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
    the_cd_nom                               INTEGER;
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
    the_id_sp_source                         INTEGER;
    the_groupe_taxo                          VARCHAR(50);
    the_taxon_vrai                           BOOLEAN;
    the_nom_vern                             VARCHAR(250);
    the_nom_sci                              VARCHAR(250);
    the_pseudo_observer_uid                  VARCHAR(200);
    the_oiso_code_nidif                      INTEGER;
    the_oiso_statut_nidif                    VARCHAR(20);
    the_cs_colo_repro                        BOOLEAN;
    the_cs_is_gite                           BOOLEAN;
    the_cs_periode                           VARCHAR(20);
    the_code_estimation                      VARCHAR(50);
    the_date_an                              INTEGER;
    the_mortalite                            BOOLEAN;
    the_mortalite_cause                      VARCHAR(250);
    the_exp_excl                             BOOLEAN;
    the_code_etude                           VARCHAR(250);
    the_pers_morale                          VARCHAR(100);
    the_comportement                         TEXT[];
    the_precision                            VARCHAR(50);
    the_details                              JSONB;
    the_id_place                             INT;
    the_place                                VARCHAR(250);
    the_formulaire                           VARCHAR(50);
    the_id_formulaire                        VARCHAR(20);
    the_is_valid                             BOOLEAN;
    the_donnee_cachee                        BOOLEAN;
    the_json_data                            JSONB;
    the_source_id                            INTEGER;
    the_id_sp_source                         INTEGER;
    the_groupe_taxo                          VARCHAR(50);
    the_taxon_vrai                           BOOLEAN;
    the_nom_vern                             VARCHAR(250);
    the_nom_sci                              VARCHAR(250);
    the_pseudo_observer_uid                  VARCHAR(200);
    the_oiso_code_nidif                      INTEGER;
    the_oiso_statut_nidif                    VARCHAR(20);
    the_cs_colo_repro                        BOOLEAN;
    the_cs_is_gite                           BOOLEAN;
    the_cs_periode                           VARCHAR(20);
    the_code_estimation                      VARCHAR(50);
    the_date_an                              INTEGER;
    the_mortalite                            BOOLEAN;
    the_mortalite_cause                      VARCHAR(250);
    the_exp_excl                             BOOLEAN;
    the_code_etude                           VARCHAR(250);
    the_pers_morale                          VARCHAR(100);
    the_comportement                         TEXT[];
    the_precision                            VARCHAR(50);
    the_details                              JSONB;
    the_id_place                             INT;
    the_place                                VARCHAR(250);
    the_formulaire                           VARCHAR(50);
    the_id_formulaire                        VARCHAR(20);
    the_is_valid                             BOOLEAN;
    the_donnee_cachee                        BOOLEAN DEFAULT FALSE
BEGIN
    /* Partie gn_synthese.synthese */

    SELECT src_lpodatas.get_observation_uuid(new.site, new.id) INTO the_unique_id_sinp;
    /* TODO récupérer un UUID pour les formulaires */
    SELECT NULL INTO the_unique_id_sinp_grp;
    SELECT src_lpodatas.fct_upsert_or_get_source_from_visionature(new.site) INTO the_id_source;
    SELECT new.id INTO the_entity_source_pk_value;
    SELECT
        gn_meta.fct_insert_or_get_dataset_from_shortname(((new.item -> 'observers') -> 0) ->> 'project_code')
        INTO the_id_dataset;
    /* TODO Suite */
    SELECT change INTO the_id_nomenclature_geo_object_nature;
    SELECT change INTO the_id_nomenclature_geo_object_nature;
    SELECT change INTO the_id_nomenclature_grp_typ;
    SELECT change INTO the_id_nomenclature_obs_meth;
    SELECT change INTO the_id_nomenclature_obs_technique;
    SELECT change INTO the_id_nomenclature_bio_status;
    SELECT change INTO the_id_nomenclature_bio_condition;
    SELECT change INTO the_id_nomenclature_naturalness;
    SELECT change INTO the_id_nomenclature_exist_proof;
    SELECT change INTO the_id_nomenclature_valid_status;
    SELECT change INTO the_id_nomenclature_diffusion_level;
    SELECT change INTO the_id_nomenclature_life_stage;
    SELECT change INTO the_id_nomenclature_sex;
    SELECT change INTO the_id_nomenclature_obj_count;
    SELECT change INTO the_id_nomenclature_type_count;
    SELECT change INTO the_id_nomenclature_sensitivity;
    SELECT change INTO the_id_nomenclature_observation_status;
    SELECT change INTO the_id_nomenclature_blurring;
    SELECT change INTO the_id_nomenclature_source_status;
    SELECT change INTO the_id_nomenclature_info_geo_type;
    SELECT change INTO the_count_min;
    SELECT change INTO the_count_max;
    SELECT change INTO the_cd_nom;
    SELECT change INTO the_nom_cite;
    SELECT change INTO the_meta_v_taxref;
    SELECT change INTO the_sample_number_proof;
    SELECT change INTO the_digital_proof;
    SELECT change INTO the_non_digital_proof;
    SELECT change INTO the_altitude_min;
    SELECT change INTO the_altitude_max;
    SELECT change INTO _the_geom_4326;
    SELECT change INTO _the_geom_point;
    SELECT change INTO _the_geom_local;
    SELECT change INTO the_date_min;
    SELECT change INTO the_date_max;
    SELECT change INTO the_validation_comment;
    SELECT change INTO the_observers;
    SELECT change INTO the_id_digitiser;
    SELECT change INTO the_id_nomenclature_determination_method;
    SELECT change INTO the_comments;
    SELECT change INTO the_meta_create_date;
    SELECT change INTO the_meta_update_date;
    /* Partie src_lpodatas.synthese_extended */
    SELECT change INTO the_id_sp_source;
    SELECT change INTO the_groupe_taxo;
    SELECT change INTO the_taxon_vrai;
    SELECT change INTO the_nom_vern;
    SELECT change INTO the_nom_sci;
    SELECT change INTO the_pseudo_observer_uid;
    SELECT change INTO the_oiso_code_nidif;
    SELECT change INTO the_oiso_statut_nidif;
    SELECT change INTO the_cs_colo_repro;
    SELECT change INTO the_cs_is_gite;
    SELECT change INTO the_cs_periode;
    SELECT change INTO the_code_estimation;
    SELECT change INTO the_date_an;
    SELECT change INTO the_mortalite;
    SELECT change INTO the_mortalite_cause;
    SELECT change INTO the_exp_excl;
    SELECT change INTO the_code_etude;
    SELECT change INTO the_pers_morale;
    SELECT change INTO the_comportement;
    SELECT change INTO the_precision;
    SELECT change INTO the_details;
    SELECT change INTO the_id_place;
    SELECT change INTO the_place;
    SELECT change INTO the_formulaire;
    SELECT change INTO the_id_formulaire;
    SELECT change INTO the_is_valid;
    SELECT change INTO the_donnee_cachee;
    SELECT change INTO the_json_data;
    SELECT change INTO the_source_id;
    SELECT change INTO the_id_sp_source;
    SELECT change INTO the_groupe_taxo;
    SELECT change INTO the_taxon_vrai;
    SELECT change INTO the_nom_vern;
    SELECT change INTO the_nom_sci;
    SELECT change INTO the_pseudo_observer_uid;
    SELECT change INTO the_oiso_code_nidif;
    SELECT change INTO the_oiso_statut_nidif;
    SELECT change INTO the_cs_colo_repro;
    SELECT change INTO the_cs_is_gite;
    SELECT change INTO the_cs_periode;
    SELECT change INTO the_code_estimation;
    SELECT change INTO the_date_an;
    SELECT change INTO the_mortalite;
    SELECT change INTO the_mortalite_cause;
    SELECT change INTO the_exp_excl;
    SELECT change INTO the_code_etude;
    SELECT change INTO the_pers_morale;
    SELECT change INTO the_comportement;
    SELECT change INTO the_precision;
    SELECT change INTO the_details;
    SELECT change INTO the_id_place;
    SELECT change INTO the_place;
    SELECT change INTO the_formulaire;
    SELECT change INTO the_id_formulaire;
    SELECT change INTO the_is_valid;
    SELECT change INTO the_donnee_cachee;


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
