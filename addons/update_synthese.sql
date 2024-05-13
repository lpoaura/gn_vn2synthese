UPDATE gn_synthese.synthese
SET
    unique_id_sinp = coalesce(
        cast(obs.item #>> '{observers,0,uuid}' AS UUID),
        src_lpodatas.fct_c_get_observation_uuid(obs.site, obs.id)
    ),
    unique_id_sinp_grp = NULL,
    id_source = src_lpodatas.fct_c_upsert_or_get_source_from_visionature(obs.site),
    entity_source_pk_value = cast(obs.id AS TEXT),
    id_dataset = CASE
        WHEN (obs.item #> '{observers,0}' ? 'project_code')
            THEN
                src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(
                    obs.item #>> '{observers,0,project_code}',
                    'visionature_default_dataset',
                    'visionature_default_acquisition_framework'
                )

        WHEN (
            obs.site IN
            (
                'vn01', 'vn07', 'vn26', 'vn38', 'vn42', 'vn74', 'vn73',
                'vn69'
            )
            AND obs.item #>> '{species,taxonomy}' = '8'
        )
            THEN
                src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id(
                    'LPO_SYMPETRUM',
                    NULL,
                    src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework(
                        'LPO_SYMPETRUM',
                        'CA LPO-SYMPETRUM',
                        cast(now() AS DATE)
                    )
                )
        ELSE
            coalesce(
                src_lpodatas.fct_c_get_dataset_from_observer_uid(
                    obs.item #>> '{observers,0,@uid}'
                ),
                src_lpodatas.fct_c_get_or_insert_dataset_from_shortname(
                    NULL,
                    'visionature_default_dataset',
                    'visionature_default_acquisition_framework'
                )
            )
    END,
    id_nomenclature_geo_object_nature
    = ref_nomenclatures.fct_c_get_synonyms_nomenclature('NAT_OBJ_GEO', obs.item #>> '{observers,0,precision}'),
    id_nomenclature_grp_typ = gn_synthese.get_default_nomenclature_value(cast('TYP_GRP' AS CHARACTER VARYING)),
    id_nomenclature_obs_technique = ref_nomenclatures.get_id_nomenclature('METH_OBS', '21'),
    id_nomenclature_bio_status = coalesce(
        coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature(
            'STATUT_BIO',
            obs.item
            #>> '{observers,0,atlas_code}'
        ),
        ref_nomenclatures.fct_c_get_synonyms_nomenclature(
            'STATUT_BIO', obs.item
            #>> '{observers,0,details,0,condition}'
        )),
        ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '1')
    ),
    id_nomenclature_bio_condition = ref_nomenclatures.get_id_nomenclature('ETA_BIO', '1'),
    id_nomenclature_naturalness = ref_nomenclatures.get_id_nomenclature('NATURALITE', '0'),


    id_nomenclature_exist_proof
    = CASE
        WHEN obs.item #> '{observers,0}' ? 'medias'
            THEN
                ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
        ELSE
            ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '2')
    END,
    id_nomenclature_valid_status
    -- When chr or chn accepted then certain, when admin_hidden then is douteux else probable.
    = CASE
        WHEN
            obs.item #>> '{observers,0,committees_validation,chr}' LIKE 'ACCEPTED'
            OR obs.item #>> '{observers,0,committees_validation,chn}' LIKE 'ACCEPTED'
            THEN
                ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1')
        WHEN cast(obs.item #>> '{observers,0,admin_hidden}' AS BOOLEAN)
            THEN
                ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '3')
        ELSE
            ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '2')
    END,
    id_nomenclature_diffusion_level = CASE
    -- Taxons sensibles, règle dans la table src_lpodatas.t_c_rules_diffusion_level
        WHEN
            cast(
                coalesce(
                    src_lpodatas.fct_c_get_taxref_values_from_vn(
                        cast('cd_nom' AS TEXT),
                        cast(
                            obs.item
                            #>> '{species,@id}' AS INTEGER
                        )
                    ),
                    gn_commons.get_default_parameter('visionature_default_cd_nom')
                ) AS INTEGER
            ) IN
            (SELECT cd_nom FROM src_lpodatas.t_c_rules_diffusion_level)
            THEN src_lpodatas.fct_c_get_taxon_diffusion_level(
                cast(
                    coalesce(
                        src_lpodatas.fct_c_get_taxref_values_from_vn(
                            cast('cd_nom' AS TEXT),
                            cast(
                                obs.item
                                #>> '{species,@id}' AS INTEGER
                            )
                        ),
                        gn_commons.get_default_parameter('visionature_default_cd_nom')
                    ) AS INTEGER
                )
            )
        -- Observation "cachée"
        WHEN cast(obs.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL)
            THEN
                ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '2')
        -- Observation "invalide" (> refused) ou en ffquestionnement (> question)
        WHEN
            obs.item #>> '{observers,0,admin_hidden_type}' IN
            ('refused', 'question')
            THEN
                ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '5')
    END,
    id_nomenclature_life_stage = ref_nomenclatures.get_id_nomenclature('STADE_VIE', '0'),
    id_nomenclature_sex = ref_nomenclatures.get_id_nomenclature('SEXE', '0'),
    id_nomenclature_obj_count = ref_nomenclatures.get_id_nomenclature('OBJ_DENBR', 'IND'),
    id_nomenclature_type_count = ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'ind'),
    id_nomenclature_sensitivity = CASE
        WHEN cast(obs.item #>> '{observers,0,hidden}' AS BOOLEAN)
            THEN
                ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '4')
        ELSE
            ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '0')
    END,
    id_nomenclature_observation_status = CASE
        WHEN ((
            obs.item #>> '{observers,0,count}' = '0'
            AND obs.item #>> '{observers,0,estimation_code}' LIKE
            'EXACT_VALUE'
        )
        OR (obs.item #>> '{observers,0,atlas_code}' = '99'))
            THEN
                ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
        ELSE
            ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'Pr')
    END,
    id_nomenclature_blurring = ref_nomenclatures.get_id_nomenclature('DEE_FLOU', 'NON'),
    id_nomenclature_source_status = ref_nomenclatures.get_id_nomenclature('STATUT_SOURCE', 'Te'),

    id_nomenclature_info_geo_type = ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1'),
    count_min = cast(obs.item #>> '{observers,0,count}' AS INTEGER),
    count_max = cast(obs.item #>> '{observers,0,count}' AS INTEGER),
    cd_nom = cast(
        coalesce(
            src_lpodatas.fct_c_get_taxref_values_from_vn(
                cast('cd_nom' AS TEXT),
                cast(
                    obs.item
                    #>> '{species,@id}' AS INTEGER
                )
            ),
            gn_commons.get_default_parameter('visionature_default_cd_nom')
        ) AS INTEGER
    ),
    nom_cite = src_lpodatas.fct_c_get_species_values_from_vn(
        cast('latin_name' AS TEXT),
        cast(
            obs.item
            #>> '{species,@id}' AS INTEGER
        )
    ),
    meta_v_taxref = gn_commons.get_default_parameter('taxref_version', NULL),
    sample_number_proof = NULL,
    digital_proof = src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array(obs.item #> '{observers,0,medias}'),
    non_digital_proof = NULL,
    altitude_min = cast(obs.item #>> '{observers,0,altitude}' AS INTEGER),
    altitude_max = cast(obs.item #>> '{observers,0,altitude}' AS INTEGER),
    --   , the_geom_4326                        = public.st_setsrid(
    --         public.st_makepoint(cast(((obs.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
    --                             cast(((obs.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
    --         4326)
    --   , the_geom_point                       = public.st_setsrid(
    --         public.st_makepoint(cast(((obs.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
    --                             cast(((obs.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
    --         4326)
    --   , the_geom_local                       = public.st_transform(
    --         public.st_setsrid(public.st_makepoint(cast(((obs.item -> 'observers') -> 0) ->> 'coord_lon' AS FLOAT),
    --                                               cast(((obs.item -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)),
    --                           4326), 2154)
    date_min = to_timestamp(cast(obs.item #>> '{date,@timestamp}' AS DOUBLE PRECISION)),
    date_max = to_timestamp(cast(obs.item #>> '{date,@timestamp}' AS DOUBLE PRECISION)),
    validation_comment = NULL,
    observers = CASE
        WHEN
            (obs.item #> '{observers,0}') ? 'second_hand'
            AND (obs.item #>> '{observers,0,second_hand}') = '1'
            THEN NULL
        ELSE src_lpodatas.fct_c_get_role_name_from_visionature_uid(
            obs.item #>> '{observers,0,@uid}', TRUE
        )
    END,
    determiner = CASE
        WHEN
            (obs.item #> '{observers,0}') ? 'second_hand'
            AND (obs.item #>> '{observers,0,second_hand}') = '1'
            THEN NULL
        ELSE src_lpodatas.fct_c_get_role_name_from_visionature_uid(
            obs.item #>> '{observers,0,@uid}', TRUE
        )
    END,
    id_digitiser = src_lpodatas.fct_c_get_id_role_from_visionature_uid(
        obs.item #>> '{observers,0,@uid}', TRUE
    ),
    id_nomenclature_determination_method = gn_synthese.get_default_nomenclature_value('METH_DETERMIN'),
    comment_description = obs.item #>> '{observers,0,comment}',
    reference_biblio = src_lpodatas.fct_c_get_source_url(
        src_lpodatas.fct_c_upsert_or_get_source_from_visionature(obs.site), cast(obs.id AS TEXT)
    )
FROM
    src_vn_json.observations_json AS obs
WHERE
    (synthese.id_source, synthese.entity_source_pk_value::INT)
    = (src_lpodatas.fct_c_upsert_or_get_source_from_visionature(obs.site), obs.id)
    AND site NOT IN ('vnauv', 'vn38');

UPDATE src_lpodatas.t_c_synthese_extended
SET

    /* Partie .t_c_synthese_extended */
    id_sp_source = cast(obs.item #>> '{species,@id}' AS INTEGER),
    taxo_group
    = src_lpodatas.fct_c_get_taxo_group_values_from_vn(
        'name', obs.site,
        cast(obs.item #>> '{species,taxonomy}' AS INT)
    ),
    taxo_real = src_lpodatas.fct_c_get_taxref_values_from_vn(
        cast('id_rang' AS TEXT),
        cast(obs.item #>> '{species,@id}' AS INTEGER)
    ) IN
    ('ES', 'SSES'),
    common_name
    = CASE
        WHEN
            src_lpodatas.fct_c_get_taxref_values_from_vn(
                cast('nom_vern' AS TEXT),
                cast(obs.item #>> '{species,@id}' AS INTEGER)
            ) IS NOT NULL
            THEN
                split_part(src_lpodatas.fct_c_get_taxref_values_from_vn(
                    cast('nom_vern' AS TEXT),
                    cast(obs.item #>> '{species,@id}' AS INTEGER)
                ),
                ',', 1)
        ELSE
            src_lpodatas.fct_c_get_species_values_from_vn(
                cast('french_name' AS TEXT),
                cast(obs.item #>> '{species,@id}' AS INTEGER)
            )
    END,
    pseudo_observer_uid = encode(hmac(cast((obs.item #>> '{observers,0,@uid}') AS TEXT), 'cyifoE!A5r', 'sha1'), 'hex'),
    bird_breed_code = cast(obs.item #>> '{observers,0,atlas_code}' AS INTEGER),
    bird_breed_status = CASE
        WHEN (obs.item #> '{observers,0}') ? 'atlas_code' THEN
            ref_nomenclatures.get_nomenclature_label_by_cdnom_mnemonique(
                'VN_ATLAS_CODE',
                obs.item
                #>> '{observers,0,atlas_code}'
            )
    END,
    bat_breed_colo = NULL,
    bat_is_gite = NULL,
    bat_period = NULL,
    estimation_code = obs.item #>> '{observers,0,estimation_code}',
    date_year = cast(
        extract(
            YEAR FROM
            to_timestamp(cast(obs.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))
        ) AS INTEGER
    ),
    mortality = cast(((obs.item #>> cast('{observers,0,extended_info,mortality}' AS TEXT [])) IS NOT NULL) AS BOOLEAN),
    mortality_cause = obs.item #>> '{observers,0,extended_info, mortality, death_cause2}',
    export_excluded = FALSE,
    project_code = obs.item #>> '{observers,0,project_code}',
    juridical_person = src_lpodatas.fct_c_get_entity_from_observer_site_uid(
        cast((obs.item #>> '{observers,0,@uid}') AS INTEGER),
        obs.site
    ),
    behaviour = src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array(obs.item #> '{observers,0,behaviours}'),
    geo_accuracy = obs.item #>> '{observers,0,precision}',
    details = obs.item #> '{observers,0,details}',
    id_place = cast(obs.item #>> '{place,@id}' AS INTEGER),
    place = obs.item #>> '{place,name}',
    id_form = obs.id_form_universal,
    is_valid = coalesce(NOT cast(obs.item #>> '{observers,0,admin_hidden}' AS BOOLEAN), TRUE),
    private_comment = obs.item #>> '{observers,0,hidden_comment}',
    is_hidden = cast(obs.item #>> '{observers,0,hidden}' IS NOT NULL AS BOOL),
    observers = CASE
        WHEN
            (obs.item #> '{observers,0}') ? 'second_hand'
            AND (obs.item #>> '{observers,0,second_hand}') = '1'
            THEN NULL
        ELSE src_lpodatas.fct_c_get_role_name_from_visionature_uid(
            obs.item #>> '{observers,0,@uid}', FALSE
        )
    END
FROM
    gn_synthese.synthese
INNER JOIN src_vn_json.observations_json AS obs
    ON
        (synthese.id_source, synthese.entity_source_pk_value)
        = (src_lpodatas.fct_c_upsert_or_get_source_from_visionature(obs.site), obs.id::TEXT)
WHERE
    synthese.id_synthese = t_c_synthese_extended.id_synthese
    AND obs.site NOT IN ('vnauv', 'vn38');

SELECT
    site,
    id,
    jsonb_pretty(item)
FROM
    src_vn_json.observations_json
WHERE
    cast(item AS TEXT) LIKE '%Serena-SGGA-27616%'
LIMIT 1;

SELECT *
FROM
    taxonomie.taxref
WHERE
    cd_nom LIKE 'Serena%';

SELECT *
FROM
    gn_synthese.synthese
WHERE
    entity_source_pk_value = 'Serena-SGGA-27616';
