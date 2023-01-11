/*
INIT DATA METADATA
------------------
Add main new data


*/
BEGIN
;

ALTER TABLE gn_commons.t_parameters
    ADD CONSTRAINT unique_t_parameters_id_organism_parameter_name UNIQUE (id_organism, parameter_name)
;

CREATE UNIQUE INDEX i_unique_t_parameters_parameter_name_with_id_organism_null ON gn_commons.t_parameters (parameter_name)
    WHERE
        id_organism IS NULL
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
        ( 0
        , 'visionature_default_dataset'
        , 'Jeu de données par défaut pour les données Visionature lorsque pas de code étude'
        , 'visionature_opportunistic'
        , NULL)
ON CONFLICT
    DO NOTHING
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
        ( 0
        , 'visionature_default_acquisition_framework'
        , 'Cadre d''acquisition par défaut pour les nouveaux jeux de données automatiquement créés'
        , '<unclassified>'
        , NULL)
ON CONFLICT
    DO NOTHING
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
        (0, 'visionature_default_metadata_actor', 'Acteur par défaut pour la gestion des métadonnées', '8', NULL)
ON CONFLICT
    DO NOTHING
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
        ( 0
        , 'visionature_default_cd_nom'
        , 'cd_nom par défaut lorsque aucune correspondance n''est trouvée'
        , (SELECT
               cd_nom
               FROM
                   taxonomie.taxref
               WHERE
                     cd_nom = cd_ref
                 AND lb_nom LIKE 'Animalia')
        , NULL)
ON CONFLICT
    DO NOTHING
;

--
-- INSERT INTO gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
--     VALUES (0, 'visionature_default_source', 'Source par défaut pour les donnnées VisioNature', 'VisioNature generic', NULL)
-- ON CONFLICT
--     DO NOTHING;
--
-- INSERT INTO gn_synthese.t_sources (name_source, desc_source, entity_source_pk_field, meta_create_date, meta_update_date)
-- SELECT
--     gn_commons.get_default_parameter ('visionature_default_source'),
--     'Source visionature générique',
--     'is_sp_source',
--     now(),
--     now();


-- SELECT
--     count(*)
--     FROM
--         gn_synthese.synthese
--     WHERE
--             id_dataset =
-- -- SELECT
--             src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id(
--                     gn_commons.get_default_parameter('visionature_default_acquisition_framework'),
--                     gn_commons.get_default_parameter('visionature_default_dataset'),
--                     src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework(
--                             gn_commons.get_default_parameter('visionature_default_acquisition_framework'),
--                             '[Ne pas toucher] Cadre d''acquisition par défaut pour tout nouveau code étude',
--                             '1900-01-01'))
-- ;

COMMIT
;