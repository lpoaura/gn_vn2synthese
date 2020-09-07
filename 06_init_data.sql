ALTER TABLE gn_commons.t_parameters
    ADD CONSTRAINT unique_t_parameters_id_organism_parameter_name UNIQUE (id_organism, parameter_name);
CREATE UNIQUE INDEX i_unique_t_parameters_parameter_name_with_id_organism_null ON gn_commons.t_parameters (parameter_name) WHERE id_organism IS NULL;

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
    ref_nomenclatures.bib_nomenclatures_types ( mnemonique
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
    ( 'VN_ATLAS_CODE'
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


INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '0'
    , '0'
    , 'Absence de code'
    , 'Absence de code'
    , 'Absence de code'
    , 'Absence de code'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '1'
    , '1'
    , 'Code non valide'
    , 'Code non valide'
    , 'Code non valide'
    , 'Code non valide'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '2'
    , '2'
    , 'Nicheur possible'
    , 'Présence dans son habitat durant sa période de nidification'
    , 'Nicheur possible'
    , 'Présence dans son habitat durant sa période de nidification'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '3'
    , '3'
    , 'Nicheur possible'
    , 'Mâle chanteur présent en période de nidification'
    , 'Nicheur possible'
    , 'Mâle chanteur présent en période de nidification'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '4'
    , '4'
    , 'Nicheur probable'
    , 'Couple présent dans son habitat durant sa période de nidification'
    , 'Nicheur probable'
    , 'Couple présent dans son habitat durant sa période de nidification'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '5'
    , '5'
    , 'Nicheur probable'
    , 'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire'
    , 'Nicheur probable'
    , 'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '6'
    , '6'
    , 'Nicheur probable'
    , 'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes'
    , 'Nicheur probable'
    , 'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '7'
    , '7'
    , 'Nicheur probable'
    , 'Visite d''un site de nidification probable. Distinct d''un site de repos'
    , 'Nicheur probable'
    , 'Visite d''un site de nidification probable. Distinct d''un site de repos'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '8'
    , '8'
    , 'Nicheur probable'
    , 'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours'
    , 'Nicheur probable'
    , 'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '9'
    , '9'
    , 'Nicheur probable'
    , 'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main'
    , 'Nicheur probable'
    , 'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '10'
    , '10'
    , 'Nicheur probable'
    , 'Transport de matériel ou construction d''un nid; forage d''une cavité (pics)'
    , 'Nicheur probable'
    , 'Transport de matériel ou construction d''un nid; forage d''une cavité (pics)'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '11'
    , '11'
    , 'Nicheur certain'
    , 'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.'
    , 'Nicheur certain'
    , 'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '12'
    , '12'
    , 'Nicheur certain'
    , 'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.'
    , 'Nicheur certain'
    , 'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '13'
    , '13'
    , 'Nicheur certain'
    , 'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances'
    , 'Nicheur certain'
    , 'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '14'
    , '14'
    , 'Nicheur certain'
    , 'Adulte gagnant, occupant ou quittant le site d''un nid; comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)'
    , 'Nicheur certain'
    , 'Adulte gagnant, occupant ou quittant le site d''un nid; comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '15'
    , '15'
    , 'Nicheur certain'
    , 'Adulte transportant un sac fécal'
    , 'Nicheur certain'
    , 'Adulte transportant un sac fécal'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '16'
    , '16'
    , 'Nicheur certain'
    , 'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification'
    , 'Nicheur certain'
    , 'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '17'
    , '17'
    , 'Nicheur certain'
    , 'Coquilles d''œufs éclos'
    , 'Nicheur certain'
    , 'Coquilles d''œufs éclos'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '18'
    , '18'
    , 'Nicheur certain'
    , 'Nid vu avec un adulte couvant'
    , 'Nicheur certain'
    , 'Nid vu avec un adulte couvant'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '19'
    , '19'
    , 'Nicheur certain'
    , 'Nid contenant des œufs ou des jeunes (vus ou entendus)'
    , 'Nicheur certain'
    , 'Nid contenant des œufs ou des jeunes (vus ou entendus)'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '30'
    , '30'
    , 'Nicheur possible'
    , 'Nicheur possible'
    , 'Nicheur possible'
    , 'Nicheur possible'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '40'
    , '40'
    , 'Nicheur probable'
    , 'Nidification probable'
    , 'Nicheur probable'
    , 'Nidification probable'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '50'
    , '50'
    , 'Nicheur certain'
    , 'Nidification certaine'
    , 'Nicheur certain'
    , 'Nidification certaine'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '99'
    , '99'
    , 'Espèce absente'
    , 'Espèce absente malgré des recherches'
    , 'Espèce absente'
    , 'Espèce absente malgré des recherches'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);
INSERT INTO
    ref_nomenclatures.t_nomenclatures ( id_type
                                      , cd_nomenclature
                                      , mnemonique
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
                                      , id_broader
                                      , hierarchy
                                      , meta_create_date
                                      , meta_update_date
                                      , active)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE')
    , '100'
    , '100'
    , 'Espèce absente'
    , 'Espèce absente malgré des recherches'
    , 'Espèce absente'
    , 'Espèce absente malgré des recherches'
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
    , NULL
    , NULL
    , '2019-08-05 12:40:49.718706'
    , NULL
    , TRUE);

/* Synonymie des nomenclatures */
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 101
    , NULL
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , 318
    , '2020-07-27 14:11:15.790304'
    , '2020-07-27 14:11:15.790304'
    , 185
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chr}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 101
    , NULL
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , 318
    , '2020-07-27 14:12:23.801656'
    , '2020-07-27 14:12:23.801656'
    , 186
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chn}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 1
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 52
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'ADYOUNG'
    , 2
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 37
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'MATURE'
    , 3
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 47
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'AD'
    , 3
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 36
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGHAIRY'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 56
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGFLYING'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 55
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGDEP'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 54
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGBOLD'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 53
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'PULL'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 48
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'JUVENILE'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 45
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , 'IMM'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 44
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '5Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 35
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '4Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 34
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '3Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 33
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '2Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 32
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '1YP'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 31
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '1Y'
    , 5
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 30
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '5'
    , 'Sub-adulte'
    , 'Sub-adulte'
    , 'SUBAD'
    , 6
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 50
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '6'
    , 'Larve'
    , 'Larve'
    , 'LARVA'
    , 7
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 46
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '7'
    , 'Chenille'
    , 'Chenille'
    , 'CAT'
    , 8
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 38
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '8'
    , 'Têtard'
    , 'Têtard'
    , 'TETARD'
    , 9
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 51
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'SPAWN'
    , 10
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 49
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'EGG'
    , 10
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 40
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '11'
    , 'Exuvie'
    , 'Exuvie'
    , 'EXUVIE'
    , 12
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 42
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '12'
    , 'Chrysalide'
    , 'Chrysalide'
    , 'CHRY'
    , 13
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 39
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '15'
    , 'Imago'
    , 'Imago'
    , 'IMAGO'
    , 16
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 43
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENT'
    , 26
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 41
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 10
    , 'STADE_VIE'
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENCE'
    , 26
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 147
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '13'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 9
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '12'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 8
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '11'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 7
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '10'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 6
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '9'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 5
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '8'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 4
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '7'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 3
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '6'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 2
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '5'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 1
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '50'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 18
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '40'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 17
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '19'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 16
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '18'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 15
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '4'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 14
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '17'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 13
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '16'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 12
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '15'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 11
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '14'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 10
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 13
    , 'STATUT_BIO'
    , '10'
    , 'Passage en vol'
    , 'Passage en vol'
    , 'FLY'
    , 38
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 103
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'PHOTO'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 167
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'THERMAL'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 165
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'NIGHT_VISION'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 163
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TELESCOPE'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 160
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BINOCULARS'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 157
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'RESCUE'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 107
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'FLY'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 104
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LABO'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 102
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDACTIV'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 87
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'OUTSHELTER'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 78
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'HAND'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 77
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MAGNIFYING'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 72
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIDEO'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 169
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIEW'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 64
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAID'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 98
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDINACTIV'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 84
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'EYE'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 153
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TRAP'
    , 41
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 149
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BONESREMAINS'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 116
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'COLLECTED'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 115
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MUMMIE'
    , 41
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 114
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '1'
    , 'Entendu'
    , 'Entendu'
    , 'AUDIO'
    , 42
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 94
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '2'
    , 'Coquilles d''œuf'
    , 'Coquilles d''œuf'
    , '12'
    , 43
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 21
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '3'
    , 'Ultrasons'
    , 'Ultrasons'
    , 'DETECT'
    , 44
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 88
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'FRESHGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 111
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'DRYGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 73
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '19'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 24
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '18'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 23
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '14'
    , 49
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 22
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '10'
    , 'Restes dans pelote de réjection'
    , 'Restes dans pelote de réjection'
    , 'PEL'
    , 51
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 66
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OLFACTIF'
    , 61
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 110
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OTHER'
    , 61
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 97
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '21'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 62
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 70
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 14
    , 'METH_OBS'
    , '25'
    , 'Vu et entendu'
    , 'Vu et entendu'
    , 'EYE_IDENTIFIED'
    , 66
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 154
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 15
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'VIDEO'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 173
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 15
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'PHOTO'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 172
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 15
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'TRAP'
    , 82
    , '2019-12-16 10:43:47.532533'
    , '2020-07-27 13:13:57.411139'
    , 171
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 18
    , 'STATUT_OBS'
    , 'No'
    , 'No'
    , 'Non observé'
    , '100'
    , 87
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 20
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 18
    , 'STATUT_OBS'
    , 'No'
    , 'No'
    , 'Non observé'
    , '99'
    , 87
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 19
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 21
    , 'TYP_DENBR'
    , 'Co'
    , 'Co'
    , 'Compté'
    , 'EXACT_VALUE'
    , 92
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 187
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 21
    , 'TYP_DENBR'
    , 'Es'
    , 'Es'
    , 'Estimé'
    , 'MINIMUM'
    , 93
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 189
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 21
    , 'TYP_DENBR'
    , 'Es'
    , 'Es'
    , 'Estimé'
    , 'ESTIMATION'
    , 93
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 188
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 21
    , 'TYP_DENBR'
    , 'NSP'
    , 'NSP'
    , 'Ne sait pas'
    , 'NO_VALUE'
    , 94
    , '2020-07-29 10:44:07.094070'
    , '2020-07-29 10:44:07.094070'
    , 190
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'polygone_precise'
    , 126
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 192
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'precise'
    , 126
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 191
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'transect'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 197
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'subplace'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 196
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'polygone'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 195
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'garden'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 194
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 23
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'municipality'
    , 127
    , '2020-07-29 13:34:53.033751'
    , '2020-07-29 13:34:53.033751'
    , 193
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDINACTIV'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 86
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'OUTSHELTER'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 80
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'RESCUE'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 108
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'FLY'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 106
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAID'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 100
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'AUDIO'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 96
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'DETECT'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 93
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDACTIV'
    , 157
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 90
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'BONESREMAINS'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 83
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'PEL'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 69
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 7
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'MUMMIE'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 62
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 9
    , 'SEXE'
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , 165
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 28
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 9
    , 'SEXE'
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'FT'
    , 166
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 29
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 9
    , 'SEXE'
    , '2'
    , 'Femelle'
    , 'Femelle'
    , 'F'
    , 167
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 26
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    (9, 'SEXE', '3', 'Mâle', 'Mâle', 'M', 168, '2019-12-12 12:57:53.904659', '2020-07-27 13:13:57.411139', 25, NULL, 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 9
    , 'SEXE'
    , '5'
    , 'Mixte'
    , 'Mixte'
    , 'MF'
    , 170
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 27
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect_precise'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 183
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 182
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace_precise'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 181
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 180
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'square'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 179
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone_precise'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 178
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 177
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'place'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 176
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'municipality'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 175
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'garden'
    , 172
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 174
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 3
    , 'NAT_OBJ_GEO'
    , 'St'
    , 'Stationnel'
    , 'Stationnel'
    , 'precise'
    , 174
    , '2019-12-16 11:16:44.597905'
    , '2020-07-27 13:13:57.411139'
    , 184
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'DETECT'
    , 204
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 91
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'EYE_IDENTIFIED'
    , 204
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 155
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'TELESCOPE'
    , 228
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 161
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'BINOCULARS'
    , 228
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 158
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '48'
    , 'Observation de larves (recherche de larves)'
    , 'Observation de larves (recherche de larves)'
    , 'LARVA'
    , 231
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 57
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'PEL'
    , 232
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 68
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'MUMMIE'
    , 232
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 61
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'BONESREMAINS'
    , 232
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 82
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '51'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'SPAWN'
    , 234
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 58
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '56'
    , 'Observation d''exuvies'
    , 'Observation d''exuvies'
    , 'EXUVIE'
    , 239
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 59
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'FRESHGUANO'
    , 240
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 113
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'DRYGUANO'
    , 240
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 75
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 100
    , 'TECHNIQUE_OBS'
    , '67'
    , 'Observation par piège photographique'
    , 'Observation par piège photographique'
    , 'TRAP'
    , 250
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 151
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '4'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'GENETIC'
    , 345
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 148
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '9'
    , 'Examen auditif direct'
    , 'Examen auditif direct'
    , 'AUDIO'
    , 350
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 95
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'EYE_IDENTIFIED'
    , 351
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 156
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'DETECT'
    , 351
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 92
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '11'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'LABO'
    , 352
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 101
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '2'
    , 'Autre méthode de détermination'
    , 'Autre méthode de détermination'
    , 'OTHER'
    , 353
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 152
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 115
    , 'METHO_RECUEIL'
    , '1'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'OLFACTIF'
    , 404
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 109
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 115
    , 'METHO_RECUEIL'
    , '9'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'COLLECTED'
    , 412
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 63
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'THERMAL'
    , 462
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 166
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'NIGHT_VISION'
    , 462
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 164
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'TELESCOPE'
    , 462
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 162
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'BINOCULARS'
    , 462
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 159
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'FLY'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 105
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAID'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 99
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDACTIV'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 89
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'OUTSHELTER'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 79
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'VIEW'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 65
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDINACTIV'
    , 462
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 85
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '20'
    , 'Examen visuel sous loupe ou microscope'
    , 'Examen visuel sous loupe ou microscope'
    , 'MAGNIFYING'
    , 464
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 71
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'PEL'
    , 458
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 67
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'MUMMIE'
    , 458
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 60
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'BONESREMAINS'
    , 458
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 81
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'FRESHGUANO'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 112
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'DRYGUANO'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 74
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '21'
    , 'Examen visuel de l’individu en main'
    , 'Examen visuel de l’individu en main'
    , 'HAND'
    , 465
    , '2019-12-12 12:57:53.904659'
    , '2020-07-27 13:13:57.411139'
    , 76
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'VIDEO'
    , 466
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 170
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'PHOTO'
    , 466
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 168
    , NULL
    , 2);
INSERT INTO
    ref_nomenclatures.t_c_synonyms ( id_type
                                   , type_mnemonique
                                   , cd_nomenclature
                                   , mnemonique
                                   , label_default
                                   , initial_value
                                   , id_nomenclature
                                   , meta_create_date
                                   , meta_update_date
                                   , id_synonyme
                                   , addon_values
                                   , id_source)
    VALUES
    ( 106
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'TRAP'
    , 466
    , '2019-12-16 10:40:40.908147'
    , '2020-07-27 13:13:57.411139'
    , 150
    , NULL
    , 2);

UPDATE ref_nomenclatures.t_c_synonyms
SET
    id_type = bib_nomenclatures_types.id_type
    FROM
        ref_nomenclatures.bib_nomenclatures_types
    WHERE
          t_c_synonyms.type_mnemonique = bib_nomenclatures_types.mnemonique
      AND t_c_synonyms.type_mnemonique IS NOT NULL;

UPDATE ref_nomenclatures.t_c_synonyms
SET
    id_nomenclature =t_nomenclatures.id_nomenclature
    FROM
        ref_nomenclatures.t_nomenclatures
            JOIN
            ref_nomenclatures.bib_nomenclatures_types ON t_nomenclatures.id_type = bib_nomenclatures_types.id_type
    WHERE
          t_c_synonyms.type_mnemonique = bib_nomenclatures_types.mnemonique
      AND t_c_synonyms.mnemonique = t_nomenclatures.mnemonique;


WITH
    selection AS (SELECT site, id FROM import_vn.observations_json LIMIT 5)
UPDATE import_vn.observations_json
SET
    site=observations_json.site
    FROM
        selection
    WHERE
          observations_json.site = selection.site
      AND observations_json.id = selection.id