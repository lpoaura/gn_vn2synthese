INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    ( 0
    , 'visionature_default_dataset'
    , 'Jeu de données par défaut pour les données Visionature lorsque pas de code étude'
    , 'visionature_opportunistic'
    , NULL)
ON CONFLICT DO NOTHING;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    ( 0
    , 'visionature_default_acquisition_framework'
    , 'Cadre d''acquisition par défaut pour les nouveaux jeux de données automatiquement créés'
    , '<unclassified>'
    , NULL)
ON CONFLICT DO NOTHING;

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
    DO NOTHING;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    (0, 'visionature_default_source', 'Source par défaut pour les donnnées VisioNature', 'VisioNature generic', NULL)
ON CONFLICT
    DO NOTHING;

INSERT INTO
    gn_synthese.t_sources (name_source, desc_source, entity_source_pk_field, meta_create_date, meta_update_date)
SELECT

    gn_commons.get_default_parameter('visionature_default_source')
  , 'Source visionature générique'
  , 'is_sp_source'
  , now()
  , now();
SELECT
    src_lpodatas.fct_get_or_insert_basic_acquisition_framework(
            gn_commons.get_default_parameter('visionature_default_acquisition_framework'),
            '[Ne pas toucher] Cadre d''acquisition par défaut pour tout nouveau code étude',
            '1900-01-01');


-- SELECT
--     src_lpodatas.fct_get_or_insert_dataset_from_shortname(
--             gn_commons.get_default_parameter('visionature_default_acquisition_framework'),
--             gn_commons.get_default_parameter('visionature_default_dataset'));

/* Nomenclatures des codes atlas */

INSERT INTO
    ref_nomenclatures.bib_nomenclatures_types (  mnemonique
                                              , label_default
                                              , definition_default
                                              , label_fr
                                              , definition_fr
                                              , label_en
                                              , definition_en
                                              , label_es
                                              , definition_es
                                              , label_de
                                              , definition_de
                                              , label_it
                                              , definition_it
                                              , source
                                              , statut
                                              , meta_create_date
                                              , meta_update_date)
    VALUES
    (  'VN_ATLAS_CODE'
    , 'Biolovision VisioNature atlas code'
    , 'Biolovision VisioNature atlas code (sites faune-xxx.org)'
    , 'Code Atlas VisioNature '
    , 'Code Atlas VisioNature  (sites faune-xxx.org)'
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , 'VisioNature'
    , NULL
    , now()
    , NULL);


INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '0', '0', 'Absence de code', 'Absence de code', 'Absence de code', 'Absence de code', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '1', '1', 'Code non valide', 'Code non valide', 'Code non valide', 'Code non valide', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '2', '2', 'Nicheur possible', 'Présence dans son habitat durant sa période de nidification', 'Nicheur possible', 'Présence dans son habitat durant sa période de nidification', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '3', '3', 'Nicheur possible', 'Mâle chanteur présent en période de nidification', 'Nicheur possible', 'Mâle chanteur présent en période de nidification', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '4', '4', 'Nicheur probable', 'Couple présent dans son habitat durant sa période de nidification', 'Nicheur probable', 'Couple présent dans son habitat durant sa période de nidification', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '5', '5', 'Nicheur probable', 'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire', 'Nicheur probable', 'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '6', '6', 'Nicheur probable', 'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes', 'Nicheur probable', 'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '7', '7', 'Nicheur probable', 'Visite d''un site de nidification probable. Distinct d''un site de repos', 'Nicheur probable', 'Visite d''un site de nidification probable. Distinct d''un site de repos', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '8', '8', 'Nicheur probable', 'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours', 'Nicheur probable', 'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '9', '9', 'Nicheur probable', 'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main', 'Nicheur probable', 'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '10', '10', 'Nicheur probable', 'Transport de matériel ou construction d''un nid; forage d''une cavité (pics)', 'Nicheur probable', 'Transport de matériel ou construction d''un nid; forage d''une cavité (pics)', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '11', '11', 'Nicheur certain', 'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.', 'Nicheur certain', 'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '12', '12', 'Nicheur certain', 'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.', 'Nicheur certain', 'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '13', '13', 'Nicheur certain', 'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances', 'Nicheur certain', 'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '14', '14', 'Nicheur certain', 'Adulte gagnant, occupant ou quittant le site d''un nid; comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)', 'Nicheur certain', 'Adulte gagnant, occupant ou quittant le site d''un nid; comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '15', '15', 'Nicheur certain', 'Adulte transportant un sac fécal', 'Nicheur certain', 'Adulte transportant un sac fécal', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '16', '16', 'Nicheur certain', 'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification', 'Nicheur certain', 'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '17', '17', 'Nicheur certain', 'Coquilles d''œufs éclos', 'Nicheur certain', 'Coquilles d''œufs éclos', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '18', '18', 'Nicheur certain', 'Nid vu avec un adulte couvant', 'Nicheur certain', 'Nid vu avec un adulte couvant', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '19', '19', 'Nicheur certain', 'Nid contenant des œufs ou des jeunes (vus ou entendus)', 'Nicheur certain', 'Nid contenant des œufs ou des jeunes (vus ou entendus)', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '30', '30', 'Nicheur possible', 'Nicheur possible', 'Nicheur possible', 'Nicheur possible', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '40', '40', 'Nicheur probable', 'Nidification probable', 'Nicheur probable', 'Nidification probable', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '50', '50', 'Nicheur certain', 'Nidification certaine', 'Nicheur certain', 'Nidification certaine', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '99', '99', 'Espèce absente', 'Espèce absente malgré des recherches', 'Espèce absente', 'Espèce absente malgré des recherches', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);
INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, label_en, definition_en, label_es, definition_es, label_de, definition_de, label_it, definition_it, source, statut, id_broader, hierarchy, meta_create_date, meta_update_date, active) VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '100', '100', 'Espèce absente', 'Espèce absente malgré des recherches', 'Espèce absente', 'Espèce absente malgré des recherches', null, null, null, null, null, null, null, null, 'VisioNature', null, null, null, '2019-08-05 12:40:49.718706', null, true);

/* Synonymie des nomenclatures */


INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '14'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 10
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '15'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 11
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '16'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 12
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '17'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 13
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '4'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 14
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '18'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 15
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '19'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 16
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '40'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 17
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '50'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 18
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '10'
    , 'Passage en vol'
    , 'Passage en vol'
    , 'FLY'
    , 38
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 103
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'MUMMIE'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 62
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'PEL'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 69
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDACTIV'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 90
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'DETECT'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 93
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'AUDIO'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 96
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAID'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 100
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'FLY'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 106
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'RESCUE'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 108
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MUMMIE'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 114
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'COLLECTED'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 115
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BONESREMAINS'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 116
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENCE'
    , 26
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 147
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '4'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'GENETIC'
    , 344
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 148
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TRAP'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 149
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'TRAP'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 150
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '67'
    , 'Observation par piège photographique'
    , 'Observation par piège photographique'
    , 'TRAP'
    , 251
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 151
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '2'
    , 'Autre méthode de détermination'
    , 'Autre méthode de détermination'
    , 'OTHER'
    , 352
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 152
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'EYE'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 153
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '25'
    , 'Vu et entendu'
    , 'Vu et entendu'
    , 'EYE_IDENTIFIED'
    , 66
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 154
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'EYE_IDENTIFIED'
    , 205
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 155
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 101
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , 318
    , '2020-07-27 14:11:15.790304'
    , '2020-07-27 14:11:15.790304'
    , 185
    , 2
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chr}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 101
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , 318
    , '2020-07-27 14:12:23.801656'
    , '2020-07-27 14:12:23.801656'
    , 186
    , 2
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chn}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 21
    , 'Co'
    , 'Co'
    , 'Compté'
    , 'EXACT_VALUE'
    , 93
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 187
    , NULL
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , 'TYP_DENBR');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 21
    , 'Es'
    , 'Es'
    , 'Estimé'
    , 'ESTIMATION'
    , 94
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 188
    , NULL
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , 'TYP_DENBR');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    (   21
    ,   'Es'
    ,   'Es'
    ,   'Estimé'
    ,   'MINIMUM'
    ,   94
    ,   '2020-07-29 10:44:07.094070'
    ,   '2020-07-29 10:44:07.094070'
    ,   189
    ,   NULL
    ,   '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    ,   'TYP_DENBR');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 21
    , 'NSP'
    , 'NSP'
    , 'Ne sait pas'
    , 'NO_VALUE'
    , 95
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 190
    , NULL
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , 'TYP_DENBR');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'precise'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 191
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'polygone_precise'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 192
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '2'
    , '2'
    , 'Rattachement'
    , 'municipality'
    , 128
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 193
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'OUTSHELTER'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 80
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'BONESREMAINS'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 83
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDINACTIV'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 86
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'ETA_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'BONESREMAINS'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 81
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'BONESREMAINS'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 82
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDINACTIV'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 84
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDINACTIV'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 85
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAID'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 98
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '5'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 1
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '6'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 2
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '7'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 3
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '8'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 4
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '9'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 5
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '10'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 6
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '11'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 7
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '12'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 8
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '13'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 9
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 'STATUT_BIO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 18
    , 'No'
    , 'No'
    , 'Non observé'
    , '99'
    , 87
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 19
    , 2
    , NULL
    , 'STATUT_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 18
    , 'No'
    , 'No'
    , 'Non observé'
    , '100'
    , 87
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 20
    , 2
    , NULL
    , 'STATUT_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '2'
    , 'Coquilles d''œuf'
    , 'Coquilles d''œuf'
    , '12'
    , 43
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 21
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '14'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 22
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '18'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 23
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '19'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 24
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 9
    , '2'
    , 'Femelle'
    , 'Femelle'
    , 'F'
    , 168
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 26
    , 2
    , NULL
    , 'SEXE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 9
    , '5'
    , 'Mixte'
    , 'Mixte'
    , 'MF'
    , 171
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 27
    , 2
    , NULL
    , 'SEXE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 9
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 166
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 28
    , 2
    , NULL
    , 'SEXE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 9
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'FT'
    , 167
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 29
    , 2
    , NULL
    , 'SEXE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '1Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 30
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '2'
    , '2'
    , 'Rattachement'
    , 'garden'
    , 128
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 194
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '1YP'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 31
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '2Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 32
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '3Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 33
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '4Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 34
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , '5Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 35
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'AD'
    , 3
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 36
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'ADYOUNG'
    , 2
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 37
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '7'
    , 'Chenille'
    , 'Chenille'
    , 'CAT'
    , 8
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 38
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '2'
    , '2'
    , 'Rattachement'
    , 'polygone'
    , 128
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 195
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '12'
    , 'Chrysalide'
    , 'Chrysalide'
    , 'CHRY'
    , 13
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 39
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'EGG'
    , 10
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 40
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENT'
    , 26
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 41
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '11'
    , 'Exuvie'
    , 'Exuvie'
    , 'EXUVIE'
    , 12
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 42
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '15'
    , 'Imago'
    , 'Imago'
    , 'IMAGO'
    , 16
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 43
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '4'
    , 'Immature'
    , 'Immature'
    , 'IMM'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 44
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'JUVENILE'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 45
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '6'
    , 'Larve'
    , 'Larve'
    , 'LARVA'
    , 7
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 46
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'MATURE'
    , 3
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 47
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'PULL'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 48
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'SPAWN'
    , 10
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 49
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '5'
    , 'Sub-adulte'
    , 'Sub-adulte'
    , 'SUBAD'
    , 6
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 50
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '8'
    , 'Têtard'
    , 'Têtard'
    , 'TETARD'
    , 9
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 51
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 1
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 52
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '2'
    , '2'
    , 'Rattachement'
    , 'subplace'
    , 128
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 196
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 23
    , '2'
    , '2'
    , 'Rattachement'
    , 'transect'
    , 128
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 197
    , NULL
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , 'TYP_INF_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    (9, '3', 'Mâle', 'Mâle', 'M', 169, '2019-12-12 12:57:53.904659', '2020-07-27 13:13:57.411139', 25, 2, NULL, 'SEXE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGBOLD'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 53
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGDEP'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 54
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGFLYING'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 55
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGHAIRY'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 56
    , 2
    , NULL
    , 'STADE_VIE');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '48'
    , 'Observation de larves (recherche de larves)'
    , 'Observation de larves (recherche de larves)'
    , 'LARVA'
    , 232
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 57
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '51'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'SPAWN'
    , 235
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 58
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '56'
    , 'Observation d''exuvies'
    , 'Observation d''exuvies'
    , 'EXUVIE'
    , 240
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 59
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'MUMMIE'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 60
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'MUMMIE'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 61
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 115
    , '9'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'COLLECTED'
    , 411
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 63
    , 2
    , NULL
    , 'METHO_RECUEIL');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIEW'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 64
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'VIEW'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 65
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '10'
    , 'Restes dans pelote de réjection'
    , 'Restes dans pelote de réjection'
    , 'PEL'
    , 51
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 66
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIDEO'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 169
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'PEL'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 67
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'PEL'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 68
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '21'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 62
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 70
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '20'
    , 'Examen visuel sous loupe ou microscope'
    , 'Examen visuel sous loupe ou microscope'
    , 'MAGNIFYING'
    , 463
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 71
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MAGNIFYING'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 72
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'DRYGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 73
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'DRYGUANO'
    , 460
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 74
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'DRYGUANO'
    , 241
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 75
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '21'
    , 'Examen visuel de l’individu en main'
    , 'Examen visuel de l’individu en main'
    , 'HAND'
    , 464
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 76
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'HAND'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 77
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'OUTSHELTER'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 78
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'OUTSHELTER'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 79
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDACTIV'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 87
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '3'
    , 'Ultrasons'
    , 'Ultrasons'
    , 'DETECT'
    , 44
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 88
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDACTIV'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 89
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'DETECT'
    , 205
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 91
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'DETECT'
    , 350
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 92
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '1'
    , 'Entendu'
    , 'Entendu'
    , 'AUDIO'
    , 42
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 94
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '9'
    , 'Examen auditif direct'
    , 'Examen auditif direct'
    , 'AUDIO'
    , 349
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 95
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OTHER'
    , 61
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 97
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAID'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 99
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '11'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'LABO'
    , 351
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 101
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LABO'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 102
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'FLY'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 104
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'FLY'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 105
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'RESCUE'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 107
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 115
    , '1'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'OLFACTIF'
    , 403
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 109
    , 2
    , NULL
    , 'METHO_RECUEIL');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OLFACTIF'
    , 61
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 110
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'FRESHGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 111
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'FRESHGUANO'
    , 460
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 112
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'FRESHGUANO'
    , 241
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 113
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'EYE_IDENTIFIED'
    , 350
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 156
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BINOCULARS'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 157
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'BINOCULARS'
    , 229
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 158
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'BINOCULARS'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 159
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TELESCOPE'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 160
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 100
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'TELESCOPE'
    , 229
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 161
    , 2
    , NULL
    , 'TECHNIQUE_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'TELESCOPE'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 162
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'NIGHT_VISION'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 163
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'NIGHT_VISION'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 164
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'THERMAL'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 165
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'THERMAL'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 166
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 14
    , '0'
    , 'Vu'
    , 'Vu'
    , 'PHOTO'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 167
    , 2
    , NULL
    , 'METH_OBS');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'PHOTO'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 168
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'VIDEO'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 170
    , 2
    , NULL
    , 'METH_DETERMIN');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 15
    , '1'
    , 'Oui'
    , 'Oui'
    , 'TRAP'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 171
    , 2
    , NULL
    , 'PREUVE_EXIST');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 15
    , '1'
    , 'Oui'
    , 'Oui'
    , 'PHOTO'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 172
    , 2
    , NULL
    , 'PREUVE_EXIST');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 15
    , '1'
    , 'Oui'
    , 'Oui'
    , 'VIDEO'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 173
    , 2
    , NULL
    , 'PREUVE_EXIST');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'garden'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 174
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'municipality'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 175
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'place'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 176
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 177
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 178
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'square'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 179
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 180
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 181
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 182
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 183
    , 2
    , NULL
    , 'NAT_OBJ_GEO');
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values
                                  , type_mnemonique)
    VALUES
    ( 3
    , 'St'
    , 'Stationnel'
    , 'Stationnel'
    , 'precise'
    , 175
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 184
    , 2
    , NULL
    , 'NAT_OBJ_GEO');

