/* Peuplement auto de la synthèse étendue LPO */
/* Générer les sources si absentes */

DROP TRIGGER IF EXISTS tri_c_upsert_vn_observation_to_geonature ON src_vn_json.observations_json
;

DROP FUNCTION IF EXISTS src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature () CASCADE
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    the_id_synthese integer;

    /* Partie gn_synthese.synthese */
    the_unique_id_sinp uuid;
    the_unique_id_sinp_grp uuid;
    the_id_source integer;
    the_entity_source_pk_value varchar;
    the_id_dataset integer;
    the_id_nomenclature_geo_object_nature integer;
    the_id_nomenclature_grp_typ integer;
    -- the_id_nomenclature_obs_meth             INTEGER;
    the_id_nomenclature_obs_technique integer;
    the_id_nomenclature_bio_status integer;
    the_id_nomenclature_bio_condition integer;
    the_id_nomenclature_naturalness integer;
    the_id_nomenclature_exist_proof integer;
    the_id_nomenclature_valid_status integer;
    the_id_nomenclature_diffusion_level integer;
    the_id_nomenclature_life_stage integer;
    the_id_nomenclature_sex integer;
    the_id_nomenclature_obj_count integer;
    the_id_nomenclature_type_count integer;
    the_id_nomenclature_sensitivity integer;
    the_id_nomenclature_observation_status integer;
    the_id_nomenclature_blurring integer;
    the_id_nomenclature_source_status integer;
    the_id_nomenclature_info_geo_type integer;
    the_count_min integer;
    the_count_max integer;
    the_cd_nom integer;
    -- TODO Pour les non match, cd_nom de Animalia
    the_nom_cite varchar;
    the_meta_v_taxref varchar;
    the_sample_number_proof varchar;
    the_digital_proof varchar;
    the_non_digital_proof varchar;
    the_altitude_min integer;
    the_altitude_max integer;
    _the_geom_4326 GEOMETRY(Geometry, 4326);
    _the_geom_point GEOMETRY(Point, 4326);
    _the_geom_local GEOMETRY(Geometry, dbSrid);
    the_date_min timestamp;
    the_date_max timestamp;
    the_validation_comment text;
    the_observers text;
    the_id_digitiser integer;
    the_id_nomenclature_determination_method integer;
    the_comments text;
    the_meta_create_date timestamp;
    the_meta_update_date timestamp;

    /* Partie .t_c_synthese_extended */
    the_observation_detail jsonb;
    the_id_sp_source integer;
    the_taxo_group varchar(50);
    the_taxo_real boolean;
    -- TODO plus tard; taxon vrai uniquement si rang IN ('ES';'SSES')
    the_common_name varchar(250);
    the_pseudo_observer_uid varchar(200);
    -- TODO Renseigner avec la fonction actuelle
    the_bird_breed_code integer;
    the_bird_breed_status varchar(20);
    the_bat_breed_colo boolean;
    the_bat_is_gite boolean;
    the_bat_period varchar(20);
    the_estimation_code varchar(50);
    the_date_year integer;
    the_mortality boolean;
    the_mortality_cause varchar(250);
    the_export_excluded boolean;
    the_project_code varchar(250);
    the_juridical_person varchar(100);
    the_behaviour text[];
    the_geo_accuracy varchar(50);
    the_details jsonb;
    the_id_place int;
    the_place varchar(250);
    the_id_form varchar(20);
    the_is_valid boolean;
    the_private_comment text;
    the_is_hidden boolean DEFAULT FALSE;
BEGIN
    SELECT
        CAST(NEW.item #>> '{species,@id}' AS integer) INTO the_id_sp_source;

    /* Partie gn_synthese.synthese */
    SELECT
        CAST(NEW.item #>> '{observers,0,uuid}' AS UUID) INTO the_unique_id_sinp;

    /* TODO récupérer un UUID pour les formulaires */
    SELECT
        NULL INTO the_unique_id_sinp_grp;
    SELECT
        src_lpodatas.fct_c_upsert_or_get_source_from_visionature (NEW.site) INTO the_id_source;
    SELECT
        NEW.id INTO the_entity_source_pk_value;
    SELECT
        src_lpodatas.fct_c_get_or_insert_dataset_from_shortname (NEW.item #>> '{observers,0,project_code}', 'visionature_default_dataset', 'visionature_default_acquisition_framework') INTO the_id_dataset;
    SELECT
        ref_nomenclatures.fct_c_get_synonyms_nomenclature ('NAT_OBJ_GEO', NEW.item #>> '{observers,0,precision}') INTO the_id_nomenclature_geo_object_nature;
    SELECT
        gn_synthese.get_default_nomenclature_value ('TYP_GRP'::character VARYING) INTO the_id_nomenclature_grp_typ;
    -- SELECT gn_synthese.get_default_nomenclature_value('METH_OBS') INTO the_id_nomenclature_obs_meth;
    --         ref_nomenclatures.fct_c_get_synonyms_nomenclature('METH_OBS',
    --                                                          new.item #>> '{observers,0,details,0,condition}')
    SELECT
        gn_synthese.get_default_nomenclature_value ('METH_OBS') INTO the_id_nomenclature_obs_technique;
    --         coalesce(
    --                 ref_nomenclatures.fct_c_get_synonyms_nomenclature('TECHNIQUE_OBS',
    --                                                                  new.item #>> '{observers,0,details,0,condition}'),
    --                 ref_nomenclatures.fct_c_get_synonyms_nomenclature('TECHNIQUE_OBS',
    --                                                                  new.item #>> '{observers,0,details,0,age}'))
    --     SELECT gn_synthese.get_default_nomenclature_value('STATUT_BIO') INTO the_id_nomenclature_bio_status;
    SELECT
        coalesce(coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature ('STATUT_BIO', NEW.item #>> '{observers,0,atlas_code}'), ref_nomenclatures.fct_c_get_synonyms_nomenclature ('STATUT_BIO', NEW.item #>> '{observers,0,details,0,condition}')), gn_synthese.get_default_nomenclature_value ('STATUT_BIO')) INTO the_id_nomenclature_bio_status;
    SELECT
        gn_synthese.get_default_nomenclature_value ('ETA_BIO') INTO the_id_nomenclature_bio_condition;
    --         coalesce(
    --                 ref_nomenclatures.fct_c_get_synonyms_nomenclature('ETA_BIO',
    --                                                                  new.item #>> '{observers,0,details,0,condition}'),
    --             , gn_synthese.get_default_nomenclature_value('ETA_BIO'))
    SELECT
        gn_synthese.get_default_nomenclature_value ('NATURALITE'::character VARYING) INTO the_id_nomenclature_naturalness;
    SELECT
        CASE WHEN NEW.item #> '{observers,0}' ? 'medias' THEN
            ref_nomenclatures.get_id_nomenclature ('PREUVE_EXIST', '1')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('PREUVE_EXIST', '0')
        END INTO the_id_nomenclature_exist_proof;
    SELECT
        -- When chr or chn accepted then certain, when admin_hidden then is douteux else probable.
        CASE WHEN NEW.item #>> '{observers,0,committees_validation,chr}' LIKE 'ACCEPTED'
            OR NEW.item #>> '{observers,0,committees_validation,chn}' LIKE 'ACCEPTED' THEN
            ref_nomenclatures.get_id_nomenclature ('STATUT_VALID', '1')
        WHEN CAST(NEW.item #>> '{observers,0,admin_hidden}' AS boolean) THEN
            ref_nomenclatures.get_id_nomenclature ('STATUT_VALID', '3')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('STATUT_VALID', '2')
        END INTO the_id_nomenclature_valid_status;
    SELECT
        CASE WHEN cast(NEW.item #>> '{observers,0,hidden}' IS NOT NULL AS bool) THEN
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('NIV_PRECIS', '5')
        END INTO the_id_nomenclature_diffusion_level;
    SELECT
        --         coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature('STADE_VIE',
        --                                                                   new.item #>> '{observers,0,details,0,age}'),
        --                  gn_synthese.get_default_nomenclature_value('STADE_VIE'))
        gn_synthese.get_default_nomenclature_value ('STADE_VIE') INTO the_id_nomenclature_life_stage;
    SELECT
        gn_synthese.get_default_nomenclature_value ('SEXE') INTO the_id_nomenclature_sex;
    SELECT
        ref_nomenclatures.get_id_nomenclature ('OBJ_DENBR', 'IND') INTO the_id_nomenclature_obj_count;
    SELECT
        ref_nomenclatures.fct_c_get_synonyms_nomenclature ('STADE_VIE', NEW.item #>> '{observers,0,estimation_code}') INTO the_id_nomenclature_type_count;
    SELECT
        CASE WHEN cast(NEW.item #>> '{observers,0,hidden}' AS boolean) THEN
            ref_nomenclatures.get_id_nomenclature ('SENSIBILITE', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('SENSIBILITE', '0')
        END INTO the_id_nomenclature_sensitivity;
    SELECT
        CASE WHEN (NEW.item #>> '{observers,0,count}' = '0'
            AND NEW.item #>> '{observers,0,estimation_code}' LIKE 'EXACT_VALUE') THEN
            ref_nomenclatures.get_id_nomenclature ('STATUT_OBS', 'No')
        ELSE
            ref_nomenclatures.get_id_nomenclature ('STATUT_OBS', 'Pr')
        END INTO the_id_nomenclature_observation_status;
    SELECT
        ref_nomenclatures.get_id_nomenclature ('DEE_FLOU', 'NON') INTO the_id_nomenclature_blurring;
    SELECT
        ref_nomenclatures.get_id_nomenclature ('STATUT_SOURCE', 'NSP') INTO the_id_nomenclature_source_status;
    SELECT
        ref_nomenclatures.get_id_nomenclature ('TYP_INF_GEO', '1')
        --         ref_nomenclatures.fct_c_get_synonyms_nomenclature('TYP_INF_GEO', new.item #>> '{observers,0,precision}')
        INTO the_id_nomenclature_info_geo_type;
    SELECT
        CAST(NEW.item #>> '{observers,0,count}' AS integer) INTO the_count_min;
    SELECT
        CAST(NEW.item #>> '{observers,0,count}' AS integer) INTO the_count_max;
    SELECT
        cast(coalesce(src_lpodatas.fct_c_get_taxref_values_from_vn ('cd_nom'::text, CAST(NEW.item #>> '{species,@id}' AS integer)), gn_commons.get_default_parameter ('visionature_default_cd_nom')) AS integer) INTO the_cd_nom;
    SELECT
        src_lpodatas.fct_c_get_species_values_from_vn ('latin_name'::text, the_id_sp_source) INTO the_nom_cite;
    SELECT
        gn_commons.get_default_parameter ('taxref_version', NULL) INTO the_meta_v_taxref;
    SELECT
        NULL INTO the_sample_number_proof;
    SELECT
        src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array (NEW.item #> '{observers,0,medias}') INTO the_digital_proof;
    SELECT
        NULL INTO the_non_digital_proof;
    SELECT
        CAST(NEW.item #>> '{observers,0,altitude}' AS integer) INTO the_altitude_min;
    SELECT
        CAST(NEW.item #>> '{observers,0,altitude}' AS integer) INTO the_altitude_max;
    SELECT
        public.st_setsrid (public.st_makepoint (CAST(((NEW.item -> 'observers') -> 0) ->> 'coord_lon' AS float), CAST(((NEW.item -> 'observers') -> 0) ->> 'coord_lat' AS float)), 4326) INTO _the_geom_4326;
    SELECT
        _the_geom_4326 INTO _the_geom_point;
    SELECT
        public.st_transform (_the_geom_4326, dbSrid) INTO _the_geom_local;
    SELECT
        to_timestamp(CAST(NEW.item #>> '{date,@timestamp}' AS double precision)) INTO the_date_min;
    SELECT
        to_timestamp(CAST(NEW.item #>> '{date,@timestamp}' AS double precision)) INTO the_date_max;
    SELECT
        NULL INTO the_validation_comment;
    SELECT
        src_lpodatas.fct_c_get_observer_full_name_from_vn (CAST((NEW.item #>> '{observers,0,@uid}') AS integer)) INTO the_observers;
    SELECT
        src_lpodatas.fct_c_get_id_role_from_visionature_uid (NEW.item #>> '{observers,0,@uid}') INTO the_id_digitiser;
    SELECT
        gn_synthese.get_default_nomenclature_value ('METH_DETERMIN') INTO the_id_nomenclature_determination_method;
    --         COALESCE(
    --                 ref_nomenclatures.fct_c_get_synonyms_nomenclature('METH_DETERMIN',
    --                                                                  new.item #>> '{observers,0,details,0,condition}'),
    --             , gn_synthese.get_default_nomenclature_value('METH_DETERMIN'))
    SELECT
        NEW.item #>> '{observers,0,comment}' INTO the_comments;
    SELECT
        to_timestamp(CAST(NEW.item #>> '{observers,0,insert_date}' AS double precision)) INTO the_meta_create_date;
    SELECT
        to_timestamp(CAST(NEW.item #>> '{observers,0,update_date}' AS double precision)) INTO the_meta_update_date;

    /* Partie .t_c_synthese_extended */
    SELECT
        src_lpodatas.fct_c_get_taxo_group_values_from_vn ('name', NEW.site, CAST(NEW.item #>> '{species,taxonomy}' AS int)) INTO the_taxo_group;
    SELECT
        src_lpodatas.fct_c_get_taxref_values_from_vn ('id_rang'::text, cast(NEW.item #>> '{species,@id}' AS integer)) IN ('ES', 'SSES') INTO the_taxo_real;
    SELECT
        CASE WHEN src_lpodatas.fct_c_get_taxref_values_from_vn ('cd_nom'::text, the_id_sp_source) IS NOT NULL THEN
            split_part(src_lpodatas.fct_c_get_taxref_values_from_vn ('nom_vern'::text, the_id_sp_source), ',', 1)
        ELSE
            src_lpodatas.fct_c_get_species_values_from_vn ('french_name'::text, the_id_sp_source)
        END INTO the_common_name;
    SELECT
        encode(hmac(CAST((NEW.item #>> '{observers,0,@uid}') AS text), 'cyifoE!A5r', 'sha1'), 'hex') INTO the_pseudo_observer_uid;
    SELECT
        CAST(NEW.item #>> '{observers,0,atlas_code}' AS integer) INTO the_bird_breed_code;
    SELECT
        CASE WHEN (NEW.item #> '{observers,0}') ? 'atlas_code' THEN
            ref_nomenclatures.get_nomenclature_label_by_cdnom_mnemonique ('VN_ATLAS_CODE', NEW.item #>> '{observers,0,atlas_code}')
        ELSE
            NULL
        END INTO the_bird_breed_status;
    SELECT
        NULL INTO the_bat_breed_colo;
    SELECT
        NULL INTO the_bat_is_gite;
    SELECT
        NULL INTO the_bat_period;
    SELECT
        NEW.item #>> '{observers,0,estimation_code}' INTO the_estimation_code;
    SELECT
        CAST(EXTRACT(YEAR FROM to_timestamp(CAST(NEW.item #>> '{date,@timestamp}' AS double precision))) AS integer) INTO the_date_year;
    SELECT
        CAST(((NEW.item #>> '{observers,0,extended_info,mortality}'::text[]) IS NOT NULL) AS boolean) INTO the_mortality;
    SELECT
        NEW.item #>> '{observers,0,extended_info, mortality, death_cause2}' INTO the_mortality_cause;
    SELECT
        FALSE INTO the_export_excluded;
    SELECT
        NEW.item #>> '{observers,0,project_code}' INTO the_project_code;
    SELECT
        src_lpodatas.fct_c_get_entity_from_observer_site_uid (CAST((NEW.item #>> '{observers,0,@uid}') AS integer), NEW.site) INTO the_juridical_person;
    SELECT
        src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array (NEW.item #> '{observers,0,behaviours}') INTO the_behaviour;
    SELECT
        NEW.item #>> '{observers,0,precision}' INTO the_geo_accuracy;
    SELECT
        NEW.item #> '{observers,0,details}' INTO the_details;
    SELECT
        CAST(NEW.item #>> '{place,@id}' AS integer) INTO the_id_place;
    SELECT
        NEW.item #>> '{place,name}' INTO the_place;
    SELECT
        NEW.id_form_universal INTO the_id_form;
    SELECT
        COALESCE(NOT CAST(NEW.item #>> '{observers,0,admin_hidden}' AS boolean), TRUE) INTO the_is_valid;
    SELECT
        NEW.item #>> '{observers,0,hidden_comment}' INTO the_private_comment;
    SELECT
        CAST(NEW.item #>> '{observers,0,hidden}' IS NOT NULL AS bool) INTO the_is_hidden;
    IF (tg_op = 'UPDATE')
    -- DO UPDATE IF trigger action is an UPDATE
    THEN
        RAISE NOTICE 'Try update data % from site % with uuid %', NEW.id, NEW.site, the_unique_id_sinp;
        -- Updating data on gn_synthese.synthese when raw data is updated
        UPDATE
            gn_synthese.synthese
        SET
            unique_id_sinp = the_unique_id_sinp,
            unique_id_sinp_grp = the_unique_id_sinp_grp,
            id_source = the_id_source,
            entity_source_pk_value = the_entity_source_pk_value,
            id_dataset = the_id_dataset,
            id_nomenclature_geo_object_nature = the_id_nomenclature_geo_object_nature,
            id_nomenclature_grp_typ = the_id_nomenclature_grp_typ,
            --   , id_nomenclature_obs_meth             = the_id_nomenclature_obs_meth
            id_nomenclature_obs_technique = the_id_nomenclature_obs_technique,
            id_nomenclature_bio_status = the_id_nomenclature_bio_status,
            id_nomenclature_bio_condition = the_id_nomenclature_bio_condition,
            id_nomenclature_naturalness = the_id_nomenclature_naturalness,
            id_nomenclature_exist_proof = the_id_nomenclature_exist_proof,
            id_nomenclature_valid_status = the_id_nomenclature_valid_status,
            id_nomenclature_diffusion_level = the_id_nomenclature_diffusion_level,
            id_nomenclature_life_stage = the_id_nomenclature_life_stage,
            id_nomenclature_sex = the_id_nomenclature_sex,
            id_nomenclature_obj_count = the_id_nomenclature_obj_count,
            id_nomenclature_type_count = the_id_nomenclature_type_count,
            id_nomenclature_sensitivity = the_id_nomenclature_sensitivity,
            id_nomenclature_observation_status = the_id_nomenclature_observation_status,
            id_nomenclature_blurring = the_id_nomenclature_blurring,
            id_nomenclature_source_status = the_id_nomenclature_source_status,
            id_nomenclature_info_geo_type = the_id_nomenclature_info_geo_type,
            count_min = the_count_min,
            count_max = the_count_max,
            cd_nom = the_cd_nom,
            nom_cite = the_nom_cite,
            meta_v_taxref = the_meta_v_taxref,
            sample_number_proof = the_sample_number_proof,
            digital_proof = the_digital_proof,
            non_digital_proof = the_non_digital_proof,
            altitude_min = the_altitude_min,
            altitude_max = the_altitude_max,
            the_geom_4326 = _the_geom_4326,
            the_geom_point = _the_geom_point,
            the_geom_local = _the_geom_local,
            date_min = the_date_min,
            date_max = the_date_max,
            validation_comment = the_validation_comment,
            observers = the_observers,
            id_digitiser = the_id_digitiser,
            id_nomenclature_determination_method = the_id_nomenclature_determination_method,
            comment_description = the_comments,
            meta_create_date = the_meta_create_date,
            meta_update_date = the_meta_update_date,
            last_action = 'U'
        WHERE
            unique_id_sinp = the_unique_id_sinp
        RETURNING
            id_synthese INTO the_id_synthese;
        IF NOT found THEN
            RAISE NOTICE 'Data % from site % not found, proceed INSERT to synthese', NEW.id, NEW.site;
            INSERT INTO gn_synthese.synthese (unique_id_sinp, unique_id_sinp_grp, id_source, entity_source_pk_value, id_dataset, id_nomenclature_geo_object_nature, id_nomenclature_grp_typ,
                -- , id_nomenclature_obs_meth
                id_nomenclature_obs_technique, id_nomenclature_bio_status, id_nomenclature_bio_condition, id_nomenclature_naturalness, id_nomenclature_exist_proof, id_nomenclature_valid_status, id_nomenclature_diffusion_level, id_nomenclature_life_stage, id_nomenclature_sex, id_nomenclature_obj_count, id_nomenclature_type_count, id_nomenclature_sensitivity, id_nomenclature_observation_status, id_nomenclature_blurring, id_nomenclature_source_status, id_nomenclature_info_geo_type, count_min, count_max, cd_nom, nom_cite, meta_v_taxref, sample_number_proof, digital_proof, non_digital_proof, altitude_min, altitude_max, the_geom_4326, the_geom_point, the_geom_local, date_min, date_max, validation_comment, observers, id_digitiser, id_nomenclature_determination_method, comment_description, meta_create_date, meta_update_date, last_action)
                VALUES (the_unique_id_sinp, the_unique_id_sinp_grp, the_id_source, the_entity_source_pk_value, the_id_dataset, the_id_nomenclature_geo_object_nature, the_id_nomenclature_grp_typ,
                    -- , the_id_nomenclature_obs_meth
                    the_id_nomenclature_obs_technique, the_id_nomenclature_bio_status, the_id_nomenclature_bio_condition, the_id_nomenclature_naturalness, the_id_nomenclature_exist_proof, the_id_nomenclature_valid_status, the_id_nomenclature_diffusion_level, the_id_nomenclature_life_stage, the_id_nomenclature_sex, the_id_nomenclature_obj_count, the_id_nomenclature_type_count, the_id_nomenclature_sensitivity, the_id_nomenclature_observation_status, the_id_nomenclature_blurring, the_id_nomenclature_source_status, the_id_nomenclature_info_geo_type, the_count_min, the_count_max, the_cd_nom, the_nom_cite, the_meta_v_taxref, the_sample_number_proof, the_digital_proof, the_non_digital_proof, the_altitude_min, the_altitude_max, _the_geom_4326, _the_geom_point, _the_geom_local, the_date_min, the_date_max, the_validation_comment, the_observers, the_id_digitiser, the_id_nomenclature_determination_method, the_comments, the_meta_create_date, the_meta_update_date, 'U')
            RETURNING
                id_synthese INTO the_id_synthese;
        END IF;
        -- Updating extended datas when raw data is updated
        UPDATE
            src_lpodatas.t_c_synthese_extended
        SET
            id_synthese = the_id_synthese,
            id_sp_source = the_id_sp_source,
            taxo_group = the_taxo_group,
            taxo_real = the_taxo_real,
            common_name = the_common_name,
            pseudo_observer_uid = the_pseudo_observer_uid,
            bird_breed_code = the_bird_breed_code,
            bird_breed_status = the_bird_breed_status,
            bat_breed_colo = the_bat_breed_colo,
            bat_is_gite = the_bat_is_gite,
            bat_period = the_bat_period,
            estimation_code = the_estimation_code,
            date_year = the_date_year,
            mortality = the_mortality,
            mortality_cause = the_mortality_cause,
            export_excluded = the_export_excluded,
            project_code = the_project_code,
            juridical_person = the_juridical_person,
            behaviour = the_behaviour,
            geo_accuracy = the_geo_accuracy,
            details = the_details,
            id_place = the_id_place,
            place = the_place,
            id_form = the_id_form,
            is_valid = the_is_valid,
            private_comment = the_private_comment,
            is_hidden = the_is_hidden
        WHERE
            id_synthese = the_id_synthese;
        IF NOT found THEN
            RAISE NOTICE 'Data % from site % not found, proceed INSERT to synthese_extended', NEW.id, NEW.site;
            INSERT INTO src_lpodatas.t_c_synthese_extended (id_synthese, id_sp_source, taxo_group, taxo_real, common_name, pseudo_observer_uid, bird_breed_code, bird_breed_status, bat_breed_colo, bat_is_gite, bat_period, estimation_code, date_year, mortality, mortality_cause, export_excluded, project_code, juridical_person, behaviour, geo_accuracy, details, id_place, place, id_form, is_valid, private_comment, is_hidden)
                VALUES (the_id_synthese, the_id_sp_source, the_taxo_group, the_taxo_real, the_common_name, the_pseudo_observer_uid, the_bird_breed_code, the_bird_breed_status, the_bat_breed_colo, the_bat_is_gite, the_bat_period, the_estimation_code, the_date_year, the_mortality, the_mortality_cause, the_export_excluded, the_project_code, the_juridical_person, the_behaviour, the_geo_accuracy, the_details, the_id_place, the_place, the_id_form, the_is_valid, the_private_comment, the_is_hidden);
        END IF;
        ELSEIF (tg_op = 'INSERT') THEN
        RAISE NOTICE 'Try insert data % from site %', NEW.id, NEW.site;
        INSERT INTO gn_synthese.synthese (unique_id_sinp, unique_id_sinp_grp, id_source, entity_source_pk_value, id_dataset, id_nomenclature_geo_object_nature, id_nomenclature_grp_typ,
            -- , id_nomenclature_obs_meth
            id_nomenclature_obs_technique, id_nomenclature_bio_status, id_nomenclature_bio_condition, id_nomenclature_naturalness, id_nomenclature_exist_proof, id_nomenclature_valid_status, id_nomenclature_diffusion_level, id_nomenclature_life_stage, id_nomenclature_sex, id_nomenclature_obj_count, id_nomenclature_type_count, id_nomenclature_sensitivity, id_nomenclature_observation_status, id_nomenclature_blurring, id_nomenclature_source_status, id_nomenclature_info_geo_type, count_min, count_max, cd_nom, nom_cite, meta_v_taxref, sample_number_proof, digital_proof, non_digital_proof, altitude_min, altitude_max, the_geom_4326, the_geom_point, the_geom_local, date_min, date_max, validation_comment, observers, id_digitiser, id_nomenclature_determination_method, comment_description, meta_create_date, meta_update_date, last_action)
            VALUES (the_unique_id_sinp, the_unique_id_sinp_grp, the_id_source, the_entity_source_pk_value, the_id_dataset, the_id_nomenclature_geo_object_nature, the_id_nomenclature_grp_typ,
                -- , the_id_nomenclature_obs_meth
                the_id_nomenclature_obs_technique, the_id_nomenclature_bio_status, the_id_nomenclature_bio_condition, the_id_nomenclature_naturalness, the_id_nomenclature_exist_proof, the_id_nomenclature_valid_status, the_id_nomenclature_diffusion_level, the_id_nomenclature_life_stage, the_id_nomenclature_sex, the_id_nomenclature_obj_count, the_id_nomenclature_type_count, the_id_nomenclature_sensitivity, the_id_nomenclature_observation_status, the_id_nomenclature_blurring, the_id_nomenclature_source_status, the_id_nomenclature_info_geo_type, the_count_min, the_count_max, the_cd_nom, the_nom_cite, the_meta_v_taxref, the_sample_number_proof, the_digital_proof, the_non_digital_proof, the_altitude_min, the_altitude_max, _the_geom_4326, _the_geom_point, _the_geom_local, the_date_min, the_date_max, the_validation_comment, the_observers, the_id_digitiser, the_id_nomenclature_determination_method, the_comments, the_meta_create_date, the_meta_update_date, 'U')
        ON CONFLICT (unique_id_sinp)
            DO UPDATE SET
                unique_id_sinp_grp = the_unique_id_sinp_grp, id_source = the_id_source, entity_source_pk_value = the_entity_source_pk_value, id_dataset = the_id_dataset, id_nomenclature_geo_object_nature = the_id_nomenclature_geo_object_nature, id_nomenclature_grp_typ = the_id_nomenclature_grp_typ,
                --   , id_nomenclature_obs_meth             = the_id_nomenclature_obs_meth
                id_nomenclature_obs_technique = the_id_nomenclature_obs_technique, id_nomenclature_bio_status = the_id_nomenclature_bio_status, id_nomenclature_bio_condition = the_id_nomenclature_bio_condition, id_nomenclature_naturalness = the_id_nomenclature_naturalness, id_nomenclature_exist_proof = the_id_nomenclature_exist_proof, id_nomenclature_valid_status = the_id_nomenclature_valid_status, id_nomenclature_diffusion_level = the_id_nomenclature_diffusion_level, id_nomenclature_life_stage = the_id_nomenclature_life_stage, id_nomenclature_sex = the_id_nomenclature_sex, id_nomenclature_obj_count = the_id_nomenclature_obj_count, id_nomenclature_type_count = the_id_nomenclature_type_count, id_nomenclature_sensitivity = the_id_nomenclature_sensitivity, id_nomenclature_observation_status = the_id_nomenclature_observation_status, id_nomenclature_blurring = the_id_nomenclature_blurring, id_nomenclature_source_status = the_id_nomenclature_source_status, id_nomenclature_info_geo_type = the_id_nomenclature_info_geo_type, count_min = the_count_min, count_max = the_count_max, cd_nom = the_cd_nom, nom_cite = the_nom_cite, meta_v_taxref = the_meta_v_taxref, sample_number_proof = the_sample_number_proof, digital_proof = the_digital_proof, non_digital_proof = the_non_digital_proof, altitude_min = the_altitude_min, altitude_max = the_altitude_max, the_geom_4326 = _the_geom_4326, the_geom_point = _the_geom_point, the_geom_local = _the_geom_local, date_min = the_date_min, date_max = the_date_max, validation_comment = the_validation_comment, observers = the_observers, id_digitiser = the_id_digitiser, id_nomenclature_determination_method = the_id_nomenclature_determination_method, comment_description = the_comments, meta_create_date = the_meta_create_date, meta_update_date = the_meta_update_date, last_action = 'U'
            RETURNING
                id_synthese INTO the_id_synthese;
        INSERT INTO src_lpodatas.t_c_synthese_extended (id_synthese, id_sp_source, taxo_group, taxo_real, common_name, pseudo_observer_uid, bird_breed_code, bird_breed_status, bat_breed_colo, bat_is_gite, bat_period, estimation_code, date_year, mortality, mortality_cause, export_excluded, project_code, juridical_person, behaviour, geo_accuracy, details, id_place, place, id_form, is_valid, private_comment, is_hidden)
            VALUES (the_id_synthese, the_id_sp_source, the_taxo_group, the_taxo_real, the_common_name, the_pseudo_observer_uid, the_bird_breed_code, the_bird_breed_status, the_bat_breed_colo, the_bat_is_gite, the_bat_period, the_estimation_code, the_date_year, the_mortality, the_mortality_cause, the_export_excluded, the_project_code, the_juridical_person, the_behaviour, the_geo_accuracy, the_details, the_id_place, the_place, the_id_form, the_is_valid, the_private_comment, the_is_hidden)
        ON CONFLICT (id_synthese)
            DO UPDATE SET
                id_synthese = the_id_synthese, id_sp_source = the_id_sp_source, taxo_group = the_taxo_group, taxo_real = the_taxo_real, common_name = the_common_name, pseudo_observer_uid = the_pseudo_observer_uid, bird_breed_code = the_bird_breed_code, bird_breed_status = the_bird_breed_status, bat_breed_colo = the_bat_breed_colo, bat_is_gite = the_bat_is_gite, bat_period = the_bat_period, estimation_code = the_estimation_code, date_year = the_date_year, mortality = the_mortality, mortality_cause = the_mortality_cause, export_excluded = the_export_excluded, project_code = the_project_code, juridical_person = the_juridical_person, behaviour = the_behaviour, geo_accuracy = the_geo_accuracy, details = the_details, id_place = the_id_place, place = the_place, id_form = the_id_form, is_valid = the_is_valid, private_comment = the_private_comment, is_hidden = the_is_hidden;
        RAISE NOTICE 'NEW upsert data %', the_id_synthese;
    END IF;
    RETURN new;
END;

$$
;

ALTER FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature () OWNER TO geonatadmin
;

COMMENT ON FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature () IS 'Trigger function to upsert datas from VisioNature to synthese and custom child table'
;

DROP TRIGGER IF EXISTS fct_tri_c_upsert_vn_observation_to_geonature ON src_vn_json.observations_json
;

CREATE TRIGGER fct_tri_c_upsert_vn_observation_to_geonature
    AFTER INSERT OR UPDATE
    ON src_vn_json.observations_json
    FOR EACH ROW
EXECUTE PROCEDURE src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature ()
;

-- TRUNCATE gn_synthese.synthese RESTART IDENTITY CASCADE;
DROP FUNCTION IF EXISTS src_lpodatas.fct_tri_c_delete_vn_observation_from_geonature () CASCADE
;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_c_delete_vn_observation_from_geonature ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    the_id_synthese int;
    the_unique_id_sinp uuid;
BEGIN
    SELECT
        src_lpodatas.fct_c_get_observation_uuid (OLD.site, OLD.id) INTO the_unique_id_sinp;
    SELECT
        id_synthese INTO the_id_synthese
    FROM
        gn_synthese.synthese
    WHERE
        unique_id_sinp = the_unique_id_sinp;
    RAISE NOTICE '<fct_tri_delete_observation_from_geonature> Delete data with uuid %', the_unique_id_sinp;
    DELETE FROM src_lpodatas.t_c_synthese_extended
    WHERE t_c_synthese_extended.id_synthese = the_id_synthese;
    DELETE FROM gn_synthese.synthese
    WHERE synthese.id_synthese = the_id_synthese;
    IF NOT found THEN
        RETURN NULL;
    END IF;
    RETURN old;
END;

$$
;

ALTER FUNCTION src_lpodatas.fct_tri_c_delete_vn_observation_from_geonature () OWNER TO gnadm
;

COMMENT ON FUNCTION src_lpodatas.fct_tri_c_delete_vn_observation_from_geonature () IS 'Trigger function to delete datas from gnadm synthese and extended table when DELETE on VisioNature source datas'
;

DROP TRIGGER IF EXISTS tri_c_delete_vn_observation_from_geonature ON src_vn_json.observations_json
;

CREATE TRIGGER tri_c_delete_vn_observation_from_geonature
    AFTER DELETE
    ON src_vn_json.observations_json
    FOR EACH ROW
EXECUTE PROCEDURE src_lpodatas.fct_tri_c_delete_vn_observation_from_geonature ()
;

