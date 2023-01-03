ROLLBACK
;

BEGIN
;

-- SET client_min_messages TO 'debug'
-- ;

-- SET work_mem = '40GB'
-- ;


ALTER TABLE gn_synthese.synthese
    DISABLE TRIGGER tri_insert_cor_area_synthese
;

ALTER TABLE gn_synthese.synthese
    DISABLE TRIGGER tri_insert_calculate_sensitivity
;


INSERT INTO
    gn_synthese.synthese ( unique_id_sinp
                         , unique_id_sinp_grp
                         , id_source
                         , id_module
                         , entity_source_pk_value
                         , id_dataset
                         , id_nomenclature_geo_object_nature
                         , id_nomenclature_grp_typ
                         , grp_method
                         , id_nomenclature_obs_technique
                         , id_nomenclature_bio_status
                         , id_nomenclature_bio_condition
                         , id_nomenclature_naturalness
                         , id_nomenclature_exist_proof
                         , id_nomenclature_valid_status
                         , id_nomenclature_diffusion_level
                         , id_nomenclature_life_stage
                         , id_nomenclature_sex
                         , id_nomenclature_obj_count
                         , id_nomenclature_type_count
                         , id_nomenclature_sensitivity
                         , id_nomenclature_observation_status
                         , id_nomenclature_blurring
                         , id_nomenclature_source_status
                         , id_nomenclature_info_geo_type
                         , reference_biblio
                         , count_min
                         , count_max
                         , cd_nom
                         , cd_hab
                         , nom_cite
                         , meta_v_taxref
                         , sample_number_proof
                         , digital_proof
                         , non_digital_proof
                         , altitude_min
                         , altitude_max
                         , the_geom_4326
                         , the_geom_point
                         , the_geom_local
                         , date_min
                         , date_max
                         , validation_comment
                         , observers
                         , determiner
                         , id_digitiser
                         , id_nomenclature_determination_method
)
SELECT
    coalesce((new.item #>> '{observers,0,uuid}')::UUID,
             src_lpodatas.fct_c_get_observation_uuid(new.site, new.id))
  , NULL
  , src_lpodatas.fct_c_upsert_or_get_source_from_visionature(new.site)
  , NULL
  , new.id
  , CASE
        WHEN new.item #> '{observers,0}' ? 'project_code'
            THEN
            src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(new.item #>> '{observers,0,project_code}',
                                                                    'visionature_default_dataset',
                                                                    'visionature_default_acquisition_framework')
        ELSE
            coalesce(src_lpodatas.fct_c_get_dataset_from_observer_uid(new.item #>> '{observers,0,@uid}'),
                     src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(NULL,
                                                                             'visionature_default_dataset',
                                                                             'visionature_default_acquisition_framework'))
        END
  , ref_nomenclatures.fct_c_get_synonyms_nomenclature('NAT_OBJ_GEO', new.item #>> '{observers,0,precision}')
  , gn_synthese.get_default_nomenclature_value('TYP_GRP'::CHARACTER VARYING)
  , NULL
  , ref_nomenclatures.get_id_nomenclature('METH_OBS', '21')
  , coalesce(coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature('STATUT_BIO',
                                                                        new.item #>>
                                                                        '{observers,0,atlas_code}'),
                      ref_nomenclatures.fct_c_get_synonyms_nomenclature('STATUT_BIO', new.item #>>
                                                                                      '{observers,0,details,0,condition}')),
             ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '1'))
  , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '1')
  , ref_nomenclatures.get_id_nomenclature('NATURALITE', '0')
  , CASE
        WHEN new.item #> '{observers,0}' ? 'medias' THEN
            ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
        ELSE
            ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '2')
        END
  , CASE
        WHEN src_lpodatas.fct_c_get_committees_validation_is_accepted(new.item #> '{observers,0,committees_validation}')
            THEN
            ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1')
        WHEN cast(new.item #>> '{observers,0,admin_hidden}' AS BOOLEAN) OR
             NOT src_lpodatas.fct_c_get_committees_validation_is_accepted(new.item #> '{observers,0,committees_validation}')
            THEN
            ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '3')
        ELSE
            ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '2')
        END
  , CASE
        -- Taxons sensibles, règle dans la table src_lpodatas.t_c_rules_diffusion_level
        WHEN cast(coalesce(src_lpodatas.fct_c_get_taxref_values_from_vn('cd_nom'::TEXT,
                                                                        cast(new.item #>> '{species,@id}' AS INTEGER)),
                           gn_commons.get_default_parameter('visionature_default_cd_nom')) AS INTEGER) IN
             (SELECT cd_nom FROM src_lpodatas.t_c_rules_diffusion_level)
            THEN src_lpodatas.fct_c_get_taxon_diffusion_level(cast(coalesce(
                src_lpodatas.fct_c_get_taxref_values_from_vn('cd_nom'::TEXT,
                                                             cast(new.item #>> '{species,@id}' AS INTEGER)),
                gn_commons.get_default_parameter('visionature_default_cd_nom')) AS INTEGER))
        -- Observation "cachée"
        WHEN cast(new.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL) THEN
            ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '2')
        -- Observation "invalide" (> refused) ou en ffquestionnement (> question)
        WHEN new.item #>> '{observers,0,admin_hidden_type}' IN ('refused', 'question') THEN
            ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '5')
        END
  , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '0')
  , ref_nomenclatures.get_id_nomenclature('SEXE', '0')
  , ref_nomenclatures.get_id_nomenclature('OBJ_DENBR', 'IND')
  , ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'ind')
  , CASE
        WHEN cast(new.item #>> '{observers,0,hidden}' AS BOOLEAN) THEN
            ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '0')
        END
  , CASE
        WHEN ((new.item #>> '{observers,0,count}' = '0'
            AND new.item #>> '{observers,0,estimation_code}' LIKE 'EXACT_VALUE') OR
              (new.item #>> '{observers,0,atlas_code}' = '99')) THEN
            ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
        ELSE
            ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'Pr')
        END
  , ref_nomenclatures.get_id_nomenclature('DEE_FLOU', 'NON')
  , ref_nomenclatures.get_id_nomenclature('STATUT_SOURCE', 'Te')
  , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1')
  , src_lpodatas.fct_c_get_source_url(src_lpodatas.fct_c_upsert_or_get_source_from_visionature(new.site), new.id::TEXT)
  , cast(new.item #>> '{observers,0,count}' AS INTEGER)
  , cast(new.item #>> '{observers,0,count}' AS INTEGER)
  , cast(coalesce(src_lpodatas.fct_c_get_taxref_values_from_vn('cd_nom'::TEXT,
                                                               cast(new.item #>> '{species,@id}' AS INTEGER)),
                  gn_commons.get_default_parameter('visionature_default_cd_nom')) AS INTEGER)
  , NULL
  , src_lpodatas.fct_c_get_species_values_from_vn('latin_name'::TEXT, cast(new.item #>> '{species,@id}' AS INTEGER))
  , gn_commons.get_default_parameter('taxref_version', NULL)
  , NULL
  , src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array(new.item #> '{observers,0,medias}')
  , NULL
  , cast(new.item #>> '{observers,0,altitude}' AS INTEGER)
  , cast(new.item #>> '{observers,0,altitude}' AS INTEGER)
  , public.st_setsrid(public.st_makepoint(cast(((new.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
                                          cast(((new.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
                      4326)
  , public.st_setsrid(public.st_makepoint(cast(((new.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
                                          cast(((new.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
                      4326)
  , public.st_setsrid(public.st_makepoint(cast(((new.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
                                          cast(((new.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
                      4326)
  , to_timestamp(cast(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))
  , to_timestamp(cast(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))
  , NULL
  , CASE
        WHEN (new.item #> '{observers,0}') ? 'second_hand' AND (new.item #>> '{observers,0,second_hand}') = '1'
            THEN NULL
        ELSE src_lpodatas.fct_c_get_role_name_from_visionature_uid(new.item #>> '{observers,0,@uid}', TRUE) END
  , CASE
        WHEN (new.item #> '{observers,0}') ? 'second_hand' AND (new.item #>> '{observers,0,second_hand}') = '1'
            THEN NULL
        ELSE src_lpodatas.fct_c_get_role_name_from_visionature_uid(new.item #>> '{observers,0,@uid}', TRUE) END
  , src_lpodatas.fct_c_get_id_role_from_visionature_uid(new.item #>> '{observers,0,@uid}', TRUE)
  , gn_synthese.get_default_nomenclature_value('METH_DETERMIN')

    FROM
        src_vn_json.observations_json AS new
;

INSERT INTO
    src_lpodatas.t_c_synthese_extended( id_synthese
                                      , id_sp_source
                                      , taxo_group
                                      , taxo_real
                                      , common_name
                                      , pseudo_observer_uid
                                      , bird_breed_code
                                      , bird_breed_status
                                      , bat_breed_colo
                                      , bat_is_gite
                                      , bat_period
                                      , estimation_code
                                      , date_year
                                      , mortality
                                      , mortality_cause
                                      , export_excluded
                                      , project_code
                                      , juridical_person
                                      , behaviour
                                      , geo_accuracy
                                      , details
                                      , id_place
                                      , place
                                      , id_form
                                      , is_valid
                                      , private_comment
                                      , is_hidden)
SELECT
    sy.id_synthese
  , (new.item #>> '{species,@id}')::INT
  , src_lpodatas.fct_c_get_taxo_group_values_from_vn('name', new.site, (new.item #>> '{species,taxonomy}')::INT)
  , src_lpodatas.fct_c_get_taxref_values_from_vn('id_rang'::TEXT, (new.item #>> '{species,@id}')::INT) IN ('ES', 'SSES')
  , CASE
        WHEN src_lpodatas.fct_c_get_taxref_values_from_vn('nom_vern'::TEXT,
                                                          (new.item #>> '{species,@id}')::INT) IS NOT NULL THEN
            split_part(
                    src_lpodatas.fct_c_get_taxref_values_from_vn('nom_vern'::TEXT, (new.item #>> '{species,@id}')::INT),
                    ',', 1)
        ELSE
            src_lpodatas.fct_c_get_species_values_from_vn('french_name'::TEXT, (new.item #>> '{species,@id}')::INT)
        END
  , encode(hmac(cast((new.item #>> '{observers,0,@uid}') AS TEXT), 'congi#ewie7eiX_u', 'sha1'), 'hex')
  , cast(new.item #>> '{observers,0,atlas_code}' AS INTEGER)
  , CASE
        WHEN (new.item #> '{observers,0}') ? 'atlas_code' THEN
            ref_nomenclatures.get_nomenclature_label_by_cdnom_mnemonique('VN_ATLAS_CODE',
                                                                         new.item #>>
                                                                         '{observers,0,atlas_code}')
        END
  , NULL
  , NULL
  , NULL
  , new.item #>> '{observers,0,estimation_code}'
  , cast(extract(YEAR FROM to_timestamp(cast(new.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))) AS INTEGER)
  , cast(((new.item #>> '{observers,0,extended_info,mortality}'::TEXT[]) IS NOT NULL) AS BOOLEAN)
  , new.item #>> '{observers,0,extended_info, mortality, death_cause2}'
  , FALSE
  , new.item #>> '{observers,0,project_code}'
  , src_lpodatas.fct_c_get_entity_from_observer_site_uid(cast((new.item #>> '{observers,0,@uid}') AS INTEGER),
                                                         new.site)
  , src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array(new.item #> '{observers,0,behaviours}')
  , new.item #>> '{observers,0,precision}'
  , new.item #> '{observers,0,details}'
  , cast(new.item #>> '{place,@id}' AS INTEGER)
  , new.item #>> '{place,name}'
  , new.id_form_universal
  , coalesce(NOT cast(new.item #>> '{observers,0,admin_hidden}' AS BOOLEAN), TRUE)
  , new.item #>> '{observers,0,hidden_comment}'
  , cast(new.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL)
    FROM
        gn_synthese.synthese sy
            JOIN gn_synthese.t_sources so ON sy.id_source = so.id_source
            JOIN src_vn_json.observations_json new ON (name_source, entity_source_pk_value::INT) = (new.site, new.id)
ON CONFLICT(id_synthese) DO NOTHING
;

INSERT INTO
    gn_synthese.cor_area_synthese (id_synthese, id_area)
SELECT
    id_synthese
  , id_area
    FROM
        gn_synthese.synthese
      , ref_geo.l_areas
    WHERE
        st_intersects(synthese.the_geom_local, l_areas.geom)
ON CONFLICT DO NOTHING
;

ALTER TABLE gn_synthese.synthese
    ENABLE TRIGGER tri_insert_cor_area_synthese
;

ALTER TABLE gn_synthese.synthese
    ENABLE TRIGGER tri_insert_calculate_sensitivity
;

COMMIT
;
