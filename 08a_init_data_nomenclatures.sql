ALTER TABLE gn_commons.t_parameters
    ADD CONSTRAINT unique_t_parameters_id_organism_parameter_name UNIQUE (id_organism, parameter_name)
;

CREATE UNIQUE INDEX i_unique_t_parameters_parameter_name_with_id_organism_null ON gn_commons.t_parameters (parameter_name) WHERE id_organism IS NULL
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    ( 0
    , 'visionature_default_dataset'
    , 'Jeu de données par défaut pour les données Visionature lorsque pas de code étude'
    , 'visionature_opportunistic'
    , NULL)
ON CONFLICT DO NOTHING
;

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    ( 0
    , 'visionature_default_acquisition_framework'
    , 'Cadre d''acquisition par défaut pour les nouveaux jeux de données automatiquement créés'
    , '<unclassified>'
    , NULL)
ON CONFLICT DO NOTHING
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

INSERT INTO
    gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
    VALUES
    (0, 'visionature_default_source', 'Source par défaut pour les donnnées VisioNature', 'VisioNature generic', NULL)
ON CONFLICT
    DO NOTHING
;

INSERT INTO
    gn_synthese.t_sources (name_source, desc_source, entity_source_pk_field, meta_create_date, meta_update_date)
SELECT

    gn_commons.get_default_parameter('visionature_default_source')
  , 'Source visionature générique'
  , 'is_sp_source'
  , now()
  , now()
;

SELECT
    src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework(
            gn_commons.get_default_parameter('visionature_default_acquisition_framework'),
            '[Ne pas toucher] Cadre d''acquisition par défaut pour tout nouveau code étude',
            '1900-01-01')
;


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
    , NULL)
;


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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

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
    , now()
    , NULL
    , TRUE)
;

/* Synonymie des nomenclatures */
TRUNCATE ref_nomenclatures.t_c_synonyms restart identity ;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID')
    , 'STATUT_VALID'
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chr}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID')
    , 'STATUT_VALID'
    , '1'
    , 'Certain - très probable'
    , 'Certain - très probable'
    , 'ACCEPTED'
    , ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,committees_validation,chn}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'ADYOUNG'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'MATURE'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '2')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '2'
    , 'Adulte'
    , 'Adulte'
    , 'AD'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '2')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGHAIRY'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGFLYING'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGDEP'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGBOLD'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'PULL'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'JUVENILE'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , 'IMM'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '5Y'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '4Y'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '3Y'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '2Y'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '1YP'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '4'
    , 'Immature'
    , 'Immature'
    , '1Y'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '5'
    , 'Sub-adulte'
    , 'Sub-adulte'
    , 'SUBAD'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '5')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '6'
    , 'Larve'
    , 'Larve'
    , 'LARVA'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '6')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '7'
    , 'Chenille'
    , 'Chenille'
    , 'CAT'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '7')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '8'
    , 'Têtard'
    , 'Têtard'
    , 'TETARD'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '8')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'SPAWN'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '9')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '9'
    , 'Œuf'
    , 'Œuf'
    , 'EGG'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '9')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '11'
    , 'Exuvie'
    , 'Exuvie'
    , 'EXUVIE'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '11')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '12'
    , 'Chrysalide'
    , 'Chrysalide'
    , 'CHRY'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '12')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '15'
    , 'Imago'
    , 'Imago'
    , 'IMAGO'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '15')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENT'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '25')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STADE_VIE')
    , 'STADE_VIE'
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENCE'
    , ref_nomenclatures.get_id_nomenclature('STADE_VIE', '25')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '13'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '12'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '11'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '10'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '9'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '8'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '7'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '6'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '5'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '50'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '40'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '19'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '18'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '4'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '17'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '16'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '15'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '14'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
    , 'STATUT_BIO'
    , '10'
    , 'Passage en vol'
    , 'Passage en vol'
    , 'FLY'
    , ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '10')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'PHOTO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'THERMAL'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'NIGHT_VISION'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TELESCOPE'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BINOCULARS'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'RESCUE'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'FLY'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LABO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDACTIV'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'OUTSHELTER'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'HAND'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MAGNIFYING'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIDEO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'VIEW'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAID'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'LAIDINACTIV'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'EYE'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'TRAP'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'BONESREMAINS'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'COLLECTED'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '0'
    , 'Vu'
    , 'Vu'
    , 'MUMMIE'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '1'
    , 'Entendu'
    , 'Entendu'
    , 'AUDIO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '2'
    , 'Coquilles d''œuf'
    , 'Coquilles d''œuf'
    , '12'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '2')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '3'
    , 'Ultrasons'
    , 'Ultrasons'
    , 'DETECT'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'FRESHGUANO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '6')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'DRYGUANO'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '6')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '19'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '8')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '18'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '8')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '8'
    , 'Nid/Gîte'
    , 'Nid/Gîte'
    , '14'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '8')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '10'
    , 'Restes dans pelote de réjection'
    , 'Restes dans pelote de réjection'
    , 'PEL'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '10')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OLFACTIF'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '20')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '20'
    , 'Autre'
    , 'Autre'
    , 'OTHER'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '20')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '21'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '21')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
    , 'METH_OBS'
    , '25'
    , 'Vu et entendu'
    , 'Vu et entendu'
    , 'EYE_IDENTIFIED'
    , ref_nomenclatures.get_id_nomenclature('METH_OBS', '25')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST')
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'VIDEO'
    , ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST')
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'PHOTO'
    , ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST')
    , 'PREUVE_EXIST'
    , '1'
    , 'Oui'
    , 'Oui'
    , 'TRAP'
    , ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_OBS')
    , 'STATUT_OBS'
    , 'No'
    , 'No'
    , 'Non observé'
    , '100'
    , ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('STATUT_OBS')
    , 'STATUT_OBS'
    , 'No'
    , 'No'
    , 'Non observé'
    , '99'
    , ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR')
    , 'TYP_DENBR'
    , 'Co'
    , 'Co'
    , 'Compté'
    , 'EXACT_VALUE'
    , ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Co')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR')
    , 'TYP_DENBR'
    , 'Es'
    , 'Es'
    , 'Estimé'
    , 'MINIMUM'
    , ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Es')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR')
    , 'TYP_DENBR'
    , 'Es'
    , 'Es'
    , 'Estimé'
    , 'ESTIMATION'
    , ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Es')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR')
    , 'TYP_DENBR'
    , 'NSP'
    , 'NSP'
    , 'Ne sait pas'
    , 'NO_VALUE'
    , ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'NSP')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,estimation_code}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'polygone_precise'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '1'
    , '1'
    , 'Géoréférencement'
    , 'precise'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'transect'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'subplace'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'polygone'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'garden'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO')
    , 'TYP_INF_GEO'
    , '2'
    , '2'
    , 'Rattachement'
    , 'municipality'
    , ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,precision}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDINACTIV'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'OUTSHELTER'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'RESCUE'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'FLY'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAID'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'AUDIO'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'DETECT'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDACTIV'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'BONESREMAINS'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'PEL'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('ETA_BIO')
    , 'ETA_BIO'
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'MUMMIE'
    , ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3')
    , now()
    , now()
    , '{
      "visionature_json_path": "{observers,0,details,0,condition}"
    }'
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('SEXE')
    , 'SEXE'
    , '0'
    , 'Inconnu'
    , 'Inconnu'
    , 'U'
    , ref_nomenclatures.get_id_nomenclature('SEXE', '0')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('SEXE')
    , 'SEXE'
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'FT'
    , ref_nomenclatures.get_id_nomenclature('SEXE', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('SEXE')
    , 'SEXE'
    , '2'
    , 'Femelle'
    , 'Femelle'
    , 'F'
    , ref_nomenclatures.get_id_nomenclature('SEXE', '2')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('SEXE')
    , 'SEXE'
    , '3'
    , 'Mâle'
    , 'Mâle'
    , 'M'
    , ref_nomenclatures.get_id_nomenclature('SEXE', '3')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('SEXE')
    , 'SEXE'
    , '5'
    , 'Mixte'
    , 'Mixte'
    , 'MF'
    , ref_nomenclatures.get_id_nomenclature('SEXE', '5')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect_precise'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace_precise'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'square'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone_precise'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'place'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'municipality'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'garden'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO')
    , 'NAT_OBJ_GEO'
    , 'St'
    , 'Stationnel'
    , 'Stationnel'
    , 'precise'
    , ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'St')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'DETECT'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '21')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'EYE_IDENTIFIED'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '21')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'TELESCOPE'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '45')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'BINOCULARS'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '45')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '48'
    , 'Observation de larves (recherche de larves)'
    , 'Observation de larves (recherche de larves)'
    , 'LARVA'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '48')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'PEL'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'MUMMIE'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'BONESREMAINS'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '51'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'SPAWN'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '51')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '56'
    , 'Observation d''exuvies'
    , 'Observation d''exuvies'
    , 'EXUVIE'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '56')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'FRESHGUANO'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '57')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'DRYGUANO'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '57')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS')
    , 'TECHNIQUE_OBS'
    , '67'
    , 'Observation par piège photographique'
    , 'Observation par piège photographique'
    , 'TRAP'
    , ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '67')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '4'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'GENETIC'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '4')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '9'
    , 'Examen auditif direct'
    , 'Examen auditif direct'
    , 'AUDIO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '9')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'EYE_IDENTIFIED'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '10')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'DETECT'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '10')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '11'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'LABO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '11')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '2'
    , 'Autre méthode de détermination'
    , 'Autre méthode de détermination'
    , 'OTHER'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '2')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METHO_RECUEIL')
    , 'METHO_RECUEIL'
    , '1'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'OLFACTIF'
    , ref_nomenclatures.get_id_nomenclature('METHO_RECUEIL', '1')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METHO_RECUEIL')
    , 'METHO_RECUEIL'
    , '9'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'COLLECTED'
    , ref_nomenclatures.get_id_nomenclature('METHO_RECUEIL', '9')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'THERMAL'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'NIGHT_VISION'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'TELESCOPE'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'BINOCULARS'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'FLY'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAID'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDACTIV'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'OUTSHELTER'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'VIEW'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDINACTIV'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '20'
    , 'Examen visuel sous loupe ou microscope'
    , 'Examen visuel sous loupe ou microscope'
    , 'MAGNIFYING'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '20')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'PEL'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'MUMMIE'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'BONESREMAINS'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'FRESHGUANO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '17')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'DRYGUANO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '17')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '21'
    , 'Examen visuel de l’individu en main'
    , 'Examen visuel de l’individu en main'
    , 'HAND'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '21')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'VIDEO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'PHOTO'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22')
    , now()
    , now()
    , NULL
    , NULL)
;

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
                                   , addon_values
                                   , id_source)
    VALUES
    ( ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN')
    , 'METH_DETERMIN'
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'TRAP'
    , ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22')
    , now()
    , now()
    , NULL
    , NULL)
;

--
-- UPDATE ref_nomenclatures.t_c_synonyms
-- SET
--     id_type = bib_nomenclatures_types.id_type
--     FROM
--         ref_nomenclatures.bib_nomenclatures_types
--     WHERE
--           t_c_synonyms.type_mnemonique = bib_nomenclatures_types.mnemonique
--       AND t_c_synonyms.type_mnemonique IS NOT NULL
-- ;
--
-- UPDATE ref_nomenclatures.t_c_synonyms
-- SET
--     id_nomenclature =t_nomenclatures.id_nomenclature
--     FROM
--         ref_nomenclatures.t_nomenclatures
--             JOIN
--             ref_nomenclatures.bib_nomenclatures_types ON t_nomenclatures.id_type = bib_nomenclatures_types.id_type
--     WHERE
--           t_c_synonyms.type_mnemonique = bib_nomenclatures_types.mnemonique
--       AND t_c_synonyms.mnemonique = t_nomenclatures.mnemonique
-- ;
--

WITH
    selection AS (SELECT site, id FROM src_vn_json.observations_json LIMIT 5)
UPDATE src_vn_json.observations_json
SET
    site=observations_json.site
    FROM
        selection
    WHERE
          observations_json.site = selection.site
      AND observations_json.id = selection.id