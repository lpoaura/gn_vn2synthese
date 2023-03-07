/*
INIT DATA NOMENCLATURES
-----------------------
Add main nomenclatures data
*/


/* Nomenclatures des codes atlas */
INSERT INTO ref_nomenclatures.bib_nomenclatures_types (mnemonique, label_default, definition_default, label_fr,
                                                       definition_fr, label_en, definition_en, label_es, definition_es,
                                                       label_de, definition_de, label_it, definition_it, source, statut,
                                                       meta_create_date, meta_update_date)
VALUES ('VN_ATLAS_CODE', 'Biolovision VisioNature atlas code',
        'Biolovision VisioNature atlas code (sites faune-xxx.org)', 'Code Atlas VisioNature ',
        'Code Atlas VisioNature  (sites faune-xxx.org)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature',
        NULL, now(), NULL);

INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default,
                                               label_fr, definition_fr, label_en, definition_en, label_es,
                                               definition_es, label_de, definition_de, label_it, definition_it, source,
                                               statut, id_broader, hierarchy, meta_create_date, meta_update_date,
                                               active)
VALUES (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '0', '0', 'Absence de code', 'Absence de code',
        'Absence de code', 'Absence de code', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL,
        NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '1', '1', 'Code non valide', 'Code non valide',
        'Code non valide', 'Code non valide', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL,
        NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '2', '2', 'Nicheur possible',
        'Présence dans son habitat durant sa période de nidification', 'Nicheur possible',
        'Présence dans son habitat durant sa période de nidification', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '3', '3', 'Nicheur possible',
        'Mâle chanteur présent en période de nidification', 'Nicheur possible',
        'Mâle chanteur présent en période de nidification', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '4', '4', 'Nicheur probable',
        'Couple présent dans son habitat durant sa période de nidification', 'Nicheur probable',
        'Couple présent dans son habitat durant sa période de nidification', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '5', '5', 'Nicheur probable',
        'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire',
        'Nicheur probable',
        'Comportement territorial (chant,querelles avec des voisins, etc.) observé sur un même territoire', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '6', '6', 'Nicheur probable',
        'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes', 'Nicheur probable',
        'Comportement nuptial: parades,copulation ou échange de nourriture entre adultes', NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '7', '7', 'Nicheur probable',
        'Visite d''un site de nidification probable. Distinct d''un site de repos', 'Nicheur probable',
        'Visite d''un site de nidification probable. Distinct d''un site de repos', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '8', '8', 'Nicheur probable',
        'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours',
        'Nicheur probable',
        'Cri d''alarme ou tout autre comportement agité indiquant la présence d''un nid ou de jeunes aux alentours',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '9', '9', 'Nicheur probable',
        'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main',
        'Nicheur probable',
        'Preuve physiologique: plaque incubatrice très vascularisée ou œuf présent dans l''oviducte. Observation sur un oiseau en main',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '10', '10', 'Nicheur probable',
        'Transport de matériel ou construction d''un nid forage d''une cavité (pics)', 'Nicheur probable',
        'Transport de matériel ou construction d''un nid forage d''une cavité (pics)', NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '11', '11', 'Nicheur certain',
        'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.',
        'Nicheur certain',
        'Oiseau simulant une blessure ou détournant l''attention, tels les canards, gallinacés, oiseaux de rivage,etc.',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '12', '12', 'Nicheur certain',
        'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.', 'Nicheur certain',
        'Nid vide ayant été utilisé ou coquilles d''œufs de la présente saison.', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '13', '13', 'Nicheur certain',
        'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances',
        'Nicheur certain',
        'Jeunes en duvet ou jeunes venant de quitter le nid et incapables de soutenir le vol sur de longues distances',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '14', '14', 'Nicheur certain',
        'Adulte gagnant, occupant ou quittant le site d''un nid comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)',
        'Nicheur certain',
        'Adulte gagnant, occupant ou quittant le site d''un nid comportement révélateur d''un nid occupé dont le contenu ne peut être vérifié (trop haut ou dans une cavité)',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '16', '16', 'Nicheur certain',
        'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification', 'Nicheur certain',
        'Adulte transportant de la nourriture pour les jeunes durant sa période de nidification', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '17', '17', 'Nicheur certain',
        'Coquilles d''œufs éclos', 'Nicheur certain', 'Coquilles d''œufs éclos', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '18', '18', 'Nicheur certain',
        'Nid vu avec un adulte couvant', 'Nicheur certain', 'Nid vu avec un adulte couvant', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '19', '19', 'Nicheur certain',
        'Nid contenant des œufs ou des jeunes (vus ou entendus)', 'Nicheur certain',
        'Nid contenant des œufs ou des jeunes (vus ou entendus)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '30', '30', 'Nicheur possible', 'Nicheur possible',
        'Nicheur possible', 'Nicheur possible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL,
        NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '40', '40', 'Nicheur probable',
        'Nidification probable', 'Nicheur probable', 'Nidification probable', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '50', '50', 'Nicheur certain',
        'Nidification certaine', 'Nicheur certain', 'Nidification certaine', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '99', '99', 'Espèce absente',
        'Espèce absente malgré des recherches', 'Espèce absente', 'Espèce absente malgré des recherches', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE)
     , (ref_nomenclatures.get_id_nomenclature_type('VN_ATLAS_CODE'), '100', '100', 'Espèce absente',
        'Espèce absente malgré des recherches', 'Espèce absente', 'Espèce absente malgré des recherches', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, 'VisioNature', NULL, NULL, NULL, now(), NULL, TRUE);


/* Synonymie des nomenclatures */

-- TRUNCATE ref_nomenclatures.t_c_synonyms RESTART IDENTITY;

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', '1', 'Certain - très probable',
        'Certain - très probable', 'ACCEPTED', ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1'), now(), now(),
        '{
          "visionature_json_path": "{observers,0,committees_validation,chr}"
        }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', '1', 'Certain - très probable',
        'Certain - très probable', 'ACCEPTED', ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1'), now(), now(),
        '{
          "visionature_json_path": "{observers,0,committees_validation,chn}"
        }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '0', 'Inconnu', 'Inconnu', 'U',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '1', 'Indéterminé', 'Indéterminé',
        'ADYOUNG', ref_nomenclatures.get_id_nomenclature('STADE_VIE', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '2', 'Adulte', 'Adulte', 'MATURE',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '2'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '2', 'Adulte', 'Adulte', 'AD',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '2'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile', 'YOUNGHAIRY',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile',
        'YOUNGFLYING', ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile', 'YOUNGDEP',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile', 'YOUNGBOLD',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile', 'PULL',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '3', 'Juvénile', 'Juvénile', 'JUVENILE',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', 'IMM',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '5Y',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '4Y',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '3Y',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '2Y',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '1YP',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '4', 'Immature', 'Immature', '1Y',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '5', 'Sub-adulte', 'Sub-adulte', 'SUBAD',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '5'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '6', 'Larve', 'Larve', 'LARVA',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '6'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '7', 'Chenille', 'Chenille', 'CAT',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '7'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '8', 'Têtard', 'Têtard', 'TETARD',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '8'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '9', 'Œuf', 'Œuf', 'SPAWN',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '9'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '9', 'Œuf', 'Œuf', 'EGG',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '9'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '11', 'Exuvie', 'Exuvie', 'EXUVIE',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '11'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '12', 'Chrysalide', 'Chrysalide', 'CHRY',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '12'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '15', 'Imago', 'Imago', 'IMAGO',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '15'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '25', 'Emergent', 'Emergent', 'EMERGENT',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '25'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', '25', 'Emergent', 'Emergent', 'EMERGENCE',
        ref_nomenclatures.get_id_nomenclature('STADE_VIE', '25'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '13', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '12', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '11', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '10', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '9', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '8', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '7', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '6', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '5', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '50', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '40', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '19', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '18', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '4', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '17', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '16', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '15', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '3', 'Reproduction', 'Reproduction',
        '14', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', '10', 'Passage en vol',
        'Passage en vol', 'FLY', ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '10'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'PHOTO',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'THERMAL',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'NIGHT_VISION',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'TELESCOPE',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'BINOCULARS',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'RESCUE',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'FLY',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'LABO',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'LAIDACTIV',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'OUTSHELTER',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'HAND',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'MAGNIFYING',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'VIDEO',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'VIEW',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'LAID',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'LAIDINACTIV',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'EYE',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'TRAP',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'BONESREMAINS',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'COLLECTED',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '0', 'Vu', 'Vu', 'MUMMIE',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '1', 'Entendu', 'Entendu', 'AUDIO',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '2', 'Coquilles d''œuf', 'Coquilles d''œuf',
        '12', ref_nomenclatures.get_id_nomenclature('METH_OBS', '2'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '3', 'Ultrasons', 'Ultrasons', 'DETECT',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '6', 'Fèces/Guano/Epreintes',
        'Fèces/Guano/Epreintes', 'FRESHGUANO', ref_nomenclatures.get_id_nomenclature('METH_OBS', '6'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '6', 'Fèces/Guano/Epreintes',
        'Fèces/Guano/Epreintes', 'DRYGUANO', ref_nomenclatures.get_id_nomenclature('METH_OBS', '6'), now(), now(), NULL,
        NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '8', 'Nid/Gîte', 'Nid/Gîte', '19',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '8'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '8', 'Nid/Gîte', 'Nid/Gîte', '18',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '8'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '8', 'Nid/Gîte', 'Nid/Gîte', '14',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '8'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '10', 'Restes dans pelote de réjection',
        'Restes dans pelote de réjection', 'PEL', ref_nomenclatures.get_id_nomenclature('METH_OBS', '10'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '20', 'Autre', 'Autre', 'OLFACTIF',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '20'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '20', 'Autre', 'Autre', 'OTHER',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '20'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '21', 'Inconnu', 'Inconnu', 'U',
        ref_nomenclatures.get_id_nomenclature('METH_OBS', '21'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', '25', 'Vu et entendu', 'Vu et entendu',
        'EYE_IDENTIFIED', ref_nomenclatures.get_id_nomenclature('METH_OBS', '25'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST'), 'PREUVE_EXIST', '1', 'Oui', 'Oui', 'VIDEO',
        ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST'), 'PREUVE_EXIST', '1', 'Oui', 'Oui', 'PHOTO',
        ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('PREUVE_EXIST'), 'PREUVE_EXIST', '1', 'Oui', 'Oui', 'TRAP',
        ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_OBS'), 'STATUT_OBS', 'No', 'No', 'Non observé', '100',
        ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('STATUT_OBS'), 'STATUT_OBS', 'No', 'No', 'Non observé', '99',
        ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR'), 'TYP_DENBR', 'Co', 'Co', 'Compté', 'EXACT_VALUE',
        ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Co'), now(), now(), '{
    "visionature_json_path": "{observers,0,estimation_code}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR'), 'TYP_DENBR', 'Es', 'Es', 'Estimé', 'MINIMUM',
        ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Es'), now(), now(), '{
    "visionature_json_path": "{observers,0,estimation_code}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR'), 'TYP_DENBR', 'Es', 'Es', 'Estimé', 'ESTIMATION',
        ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'Es'), now(), now(), '{
    "visionature_json_path": "{observers,0,estimation_code}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_DENBR'), 'TYP_DENBR', 'NSP', 'NSP', 'Ne sait pas', 'NO_VALUE',
        ref_nomenclatures.get_id_nomenclature('TYP_DENBR', 'NSP'), now(), now(), '{
    "visionature_json_path": "{observers,0,estimation_code}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '1', '1', 'Géoréférencement',
        'polygone_precise', ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '1', '1', 'Géoréférencement',
        'precise', ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '2', '2', 'Rattachement', 'transect',
        ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '2', '2', 'Rattachement', 'subplace',
        ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '2', '2', 'Rattachement', 'polygone',
        ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '2', '2', 'Rattachement', 'garden',
        ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYP_INF_GEO'), 'TYP_INF_GEO', '2', '2', 'Rattachement',
        'municipality', ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,precision}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'LAIDINACTIV', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'OUTSHELTER', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'RESCUE', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'FLY', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'LAID', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'AUDIO', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'DETECT', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '2', 'Observé vivant', 'Observé vivant',
        'LAIDACTIV', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '3', 'Trouvé mort', 'Trouvé mort',
        'BONESREMAINS', ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '3', 'Trouvé mort', 'Trouvé mort', 'PEL',
        ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', '3', 'Trouvé mort', 'Trouvé mort', 'MUMMIE',
        ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3'), now(), now(), '{
    "visionature_json_path": "{observers,0,details,0,condition}"
  }', NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('SEXE'), 'SEXE', '0', 'Inconnu', 'Inconnu', 'U',
        ref_nomenclatures.get_id_nomenclature('SEXE', '0'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('SEXE'), 'SEXE', '1', 'Indéterminé', 'Indéterminé', 'FT',
        ref_nomenclatures.get_id_nomenclature('SEXE', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('SEXE'), 'SEXE', '2', 'Femelle', 'Femelle', 'F',
        ref_nomenclatures.get_id_nomenclature('SEXE', '2'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('SEXE'), 'SEXE', '3', 'Mâle', 'Mâle', 'M',
        ref_nomenclatures.get_id_nomenclature('SEXE', '3'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('SEXE'), 'SEXE', '5', 'Mixte', 'Mixte', 'MF',
        ref_nomenclatures.get_id_nomenclature('SEXE', '5'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'transect_precise', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'transect', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'subplace_precise', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'subplace', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'square', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'polygone_precise', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'polygone', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'place', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'municipality', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'In', 'Inventoriel', 'Inventoriel',
        'garden', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'In'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('NAT_OBJ_GEO'), 'NAT_OBJ_GEO', 'St', 'Stationnel', 'Stationnel',
        'precise', ref_nomenclatures.get_id_nomenclature('NAT_OBJ_GEO', 'St'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '21',
        'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)',
        'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)', 'DETECT',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '21'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '21',
        'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)',
        'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)', 'EYE_IDENTIFIED',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '21'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '45',
        'Observation aux jumelles (observation à la longue-vue)',
        'Observation aux jumelles (observation à la longue-vue)', 'TELESCOPE',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '45'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '45',
        'Observation aux jumelles (observation à la longue-vue)',
        'Observation aux jumelles (observation à la longue-vue)', 'BINOCULARS',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '45'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '48',
        'Observation de larves (recherche de larves)', 'Observation de larves (recherche de larves)', 'LARVA',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '48'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '49',
        'Observation de macro-restes (cadavres, élytres…)', 'Observation de macro-restes (cadavres, élytres…)', 'PEL',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '49',
        'Observation de macro-restes (cadavres, élytres…)', 'Observation de macro-restes (cadavres, élytres…)',
        'MUMMIE', ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '49',
        'Observation de macro-restes (cadavres, élytres…)', 'Observation de macro-restes (cadavres, élytres…)',
        'BONESREMAINS', ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '49'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '51',
        'Observation de pontes (observation des œufs, recherche des pontes)',
        'Observation de pontes (observation des œufs, recherche des pontes)', 'SPAWN',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '51'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '56', 'Observation d''exuvies',
        'Observation d''exuvies', 'EXUVIE', ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '56'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '57',
        'Observation d''indices de présence', 'Observation d''indices de présence', 'FRESHGUANO',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '57'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '57',
        'Observation d''indices de présence', 'Observation d''indices de présence', 'DRYGUANO',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '57'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('TECHNIQUE_OBS'), 'TECHNIQUE_OBS', '67',
        'Observation par piège photographique', 'Observation par piège photographique', 'TRAP',
        ref_nomenclatures.get_id_nomenclature('TECHNIQUE_OBS', '67'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '4',
        'Analyse ADN de l''individu ou de ses restes', 'Analyse ADN de l''individu ou de ses restes', 'GENETIC',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '4'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '9', 'Examen auditif direct',
        'Examen auditif direct', 'AUDIO', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '9'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '10',
        'Examen auditif avec transformation électronique', 'Examen auditif avec transformation électronique',
        'EYE_IDENTIFIED', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '10'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '10',
        'Examen auditif avec transformation électronique', 'Examen auditif avec transformation électronique', 'DETECT',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '10'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '11',
        'Examen des organes reproducteurs ou critères spécifiques en laboratoire',
        'Examen des organes reproducteurs ou critères spécifiques en laboratoire', 'LABO',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '11'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '2',
        'Autre méthode de détermination', 'Autre méthode de détermination', 'OTHER',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '2'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METHO_RECUEIL'), 'METHO_RECUEIL', '1',
        'Observation directe : Vue, écoute, olfactive, tactile',
        'Observation directe : Vue, écoute, olfactive, tactile', 'OLFACTIF',
        ref_nomenclatures.get_id_nomenclature('METHO_RECUEIL', '1'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METHO_RECUEIL'), 'METHO_RECUEIL', '9',
        'Prélèvement (capture avec collecte d''échantillon) : capture-conservation',
        'Prélèvement (capture avec collecte d''échantillon) : capture-conservation', 'COLLECTED',
        ref_nomenclatures.get_id_nomenclature('METHO_RECUEIL', '9'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'THERMAL', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'NIGHT_VISION', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'TELESCOPE', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'BINOCULARS', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'FLY', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'LAID', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'LAIDACTIV', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'OUTSHELTER', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'VIEW', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(), now(),
        NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '18', 'Examen visuel à distance',
        'Examen visuel à distance', 'LAIDINACTIV', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '18'), now(),
        now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '20',
        'Examen visuel sous loupe ou microscope', 'Examen visuel sous loupe ou microscope', 'MAGNIFYING',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '20'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '14',
        'Examen visuel des restes de l’individu', 'Examen visuel des restes de l’individu', 'PEL',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '14',
        'Examen visuel des restes de l’individu', 'Examen visuel des restes de l’individu', 'MUMMIE',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '14',
        'Examen visuel des restes de l’individu', 'Examen visuel des restes de l’individu', 'BONESREMAINS',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '14'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '17',
        'Examen direct des traces ou indices de présence', 'Examen direct des traces ou indices de présence',
        'FRESHGUANO', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '17'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '17',
        'Examen direct des traces ou indices de présence', 'Examen direct des traces ou indices de présence',
        'DRYGUANO', ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '17'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '21',
        'Examen visuel de l’individu en main', 'Examen visuel de l’individu en main', 'HAND',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '21'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '22',
        'Examen visuel sur photo ou vidéo', 'Examen visuel sur photo ou vidéo', 'VIDEO',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '22',
        'Examen visuel sur photo ou vidéo', 'Examen visuel sur photo ou vidéo', 'PHOTO',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22'), now(), now(), NULL, NULL);

INSERT INTO ref_nomenclatures.t_c_synonyms (id_type, type_mnemonique, cd_nomenclature, mnemonique, label_default,
                                            initial_value, id_nomenclature, meta_create_date, meta_update_date,
                                            addon_values, id_source)
VALUES (ref_nomenclatures.get_id_nomenclature_type('METH_DETERMIN'), 'METH_DETERMIN', '22',
        'Examen visuel sur photo ou vidéo', 'Examen visuel sur photo ou vidéo', 'TRAP',
        ref_nomenclatures.get_id_nomenclature('METH_DETERMIN', '22'), now(), now(), NULL, NULL);


/* Reproduction status matching values */
INSERT INTO ref_nomenclatures.t_c_vn_repro_matching_values (groupe_taxo_text, group_taxo_id, data_type, label,
                                                            value, repro_status, json_path, priority)
VALUES ('Amphibiens', 7, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Mammifères', 3, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Odonates', 8, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Orthoptères', 11, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Papillons de jour', 9, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Reptiles', 6, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Chauves-souris', 2, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Mammifères', 3, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Odonates', 8, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Orthoptères', 11, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Papillons de jour', 9, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Reptiles', 6, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Reptiles', 6, 'sex', 'mâle et femelle', 'MF', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Reptiles', 6, 'sex', 'femelle gestante', 'FG', 'Certain', '$."observers"[*]."details"[*]."sex"', 1),
       ('Amphibiens', 7, 'sex', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Amphibiens', 7, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Mammifères', 3, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Odonates', 8, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Orthoptères', 11, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Papillons de jour', 9, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Reptiles', 6, 'behaviour', 'Prédaté', '134_15', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Amphibiens', 7, 'behaviour', 'Prend le soleil', '134_20', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Reptiles', 6, 'behaviour', 'Prend le soleil', '134_20', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Mammifères', 3, 'behaviour', 'Marquage de territoire', '134_21', 'Possible',
        '$."observers"[*]."behaviours"[*]."@id"', 3),
       ('Chauves-souris', 2, 'age', 'jeune velu non volant', 'YOUNGHAIRY', 'Certain',
        '$."observers"[*]."details"[*]."age"', 1),
       ('Chauves-souris', 2, 'age', 'jeune non velu', NULL, 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Chauves-souris', 2, 'age', 'adulte et jeune', 'ADYOUNG', 'Probable', '$."observers"[*]."details"[*]."age"', 2),
       ('Chauves-souris', 2, 'age', 'jeune volant', 'YOUNGFLYING', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Chauves-souris', 2, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Mammifères', 3, 'age', 'immature', 'IMM', 'Possible', '$."observers"[*]."details"[*]."age"', 3),
       ('Mammifères', 3, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Mammifères', 3, 'age', 'jeune dépendant', 'YOUNGDEP', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Odonates', 8, 'age', 'individu mature', 'MATURE', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Odonates', 8, 'age', 'larve', 'LARVA', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Odonates', 8, 'age', 'immature', 'IMM', 'Possible', '$."observers"[*]."details"[*]."age"', 3),
       ('Odonates', 8, 'age', 'individu émergent', 'EMERGENT', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Odonates', 8, 'age', 'exuvie', 'EXUVIE', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Orthoptères', 11, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Orthoptères', 11, 'age', 'juvénile', 'JUVENILE', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Papillons de jour', 9, 'age', 'imago', 'IMAGO', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Papillons de jour', 9, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Papillons de jour', 9, 'age', 'oeuf', 'EGG', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Papillons de jour', 9, 'age', 'chrysalide', 'CHRY', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Papillons de jour', 9, 'age', 'chenille', 'CAT', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Reptiles', 6, 'age', 'oeuf', 'EGG', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Reptiles', 6, 'age', 'subadulte', 'SUBAD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Reptiles', 6, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Reptiles', 6, 'age', 'ponte', 'EGG', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Reptiles', 6, 'age', 'juvénile', 'JUVENILE', 'Probable', '$."observers"[*]."details"[*]."age"', 2),
       ('Chauves-souris', 2, 'age', 'inconnu', 'U', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Chauves-souris', 2, 'sex', 'femelle gestante', 'FG', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Chauves-souris', 2, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Chauves-souris', 2, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Chauves-souris', 2, 'sex', 'mâle et femelle', 'MF', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Mammifères', 3, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Mammifères', 3, 'sex', 'femelle gestante', 'FG', 'Certain', '$."observers"[*]."details"[*]."sex"', 1),
       ('Mammifères', 3, 'sex', 'mâle et femelle', 'MF', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Mammifères', 3, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Odonates', 8, 'sex', 'femelle gestante', 'FG', 'Probable', '$."observers"[*]."details"[*]."sex"', 2),
       ('Odonates', 8, 'sex', 'mâle et femelle', 'MF', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Odonates', 8, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Odonates', 8, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Orthoptères', 11, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Orthoptères', 11, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Orthoptères', 11, 'sex', 'femelle gestante', 'FG', 'Probable', '$."observers"[*]."details"[*]."sex"', 2),
       ('Orthoptères', 11, 'sex', 'mâle et femelle', 'MF', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Amphibiens', 7, 'age', 'adulte', 'AD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Amphibiens', 7, 'age', 'juvénile', 'JUVENILE', 'Probable', '$."observers"[*]."details"[*]."age"', 2),
       ('Amphibiens', 7, 'age', 'ponte', 'EGG', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Amphibiens', 7, 'age', 'larve/tétard', 'TETARD', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Amphibiens', 7, 'age', 'oeuf', 'EGG', 'Certain', '$."observers"[*]."details"[*]."age"', 1),
       ('Amphibiens', 7, 'age', 'subadulte', 'SUBAD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Amphibiens', 7, 'sex', 'femelle gestante', 'FG', 'Certain', '$."observers"[*]."details"[*]."sex"', 1),
       ('Amphibiens', 7, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Amphibiens', 7, 'sex', 'mâle et femelle', 'MF', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Amphibiens', 7, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Mammifères', 3, 'behaviour', 'Rut, parade', '134_22', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Amphibiens', 7, 'behaviour', 'Sous une plaque', '134_23', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Mammifères', 3, 'behaviour', 'Sous une plaque', '134_23', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Reptiles', 6, 'behaviour', 'Sous une plaque', '134_23', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Odonates', 8, 'behaviour', 'Territorial', '134_1', 'Possible', '$."observers"[*]."behaviours"[*]."@id"', 3),
       ('Papillons de jour', 9, 'behaviour', 'Territorial', '134_1', 'Possible',
        '$."observers"[*]."behaviours"[*]."@id"', 3),
       ('Odonates', 8, 'behaviour', 'Tandem', '134_2', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Amphibiens', 7, 'behaviour', 'Accouplement', '134_3', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Mammifères', 3, 'behaviour', 'Accouplement', '134_3', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Odonates', 8, 'behaviour', 'Accouplement', '134_3', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Orthoptères', 11, 'behaviour', 'Accouplement', '134_3', 'Probable', '$."observers"[*]."behaviours"[*]."@id"',
        2),
       ('Papillons de jour', 9, 'behaviour', 'Accouplement', '134_3', 'Probable',
        '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Reptiles', 6, 'behaviour', 'Accouplement', '134_3', 'Probable', '$."observers"[*]."behaviours"[*]."@id"', 2),
       ('Amphibiens', 7, 'behaviour', 'Pond', '134_4', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Odonates', 8, 'behaviour', 'Pond', '134_4', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Orthoptères', 11, 'behaviour', 'Pond', '134_4', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Papillons de jour', 9, 'behaviour', 'Pond', '134_4', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Reptiles', 6, 'behaviour', 'Pond', '134_4', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Mammifères', 3, 'behaviour', 'Se déplace', '134_5', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Odonates', 8, 'behaviour', 'Emergence', '134_6', 'Certain', '$."observers"[*]."behaviours"[*]."@id"', 1),
       ('Odonates', 8, 'behaviour', 'Migration', '134_9', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Papillons de jour', 9, 'behaviour', 'Migration', '134_9', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"',
        4),
       ('Mammifères', 3, 'behaviour', 'Se nourrit', '134_10', 'Inconnu', '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Papillons de jour', 9, 'behaviour', 'Se nourrit', '134_10', 'Inconnu',
        '$."observers"[*]."behaviours"[*]."@id"', 4),
       ('Chauves-souris', 2, 'age', 'subadulte', 'SUBAD', 'Inconnu', '$."observers"[*]."details"[*]."age"', 4),
       ('Papillons de jour', 9, 'sex', 'mâle et femelle', 'MF', 'Possible', '$."observers"[*]."details"[*]."sex"', 3),
       ('Papillons de jour', 9, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Papillons de jour', 9, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Papillons de jour', 9, 'sex', 'femelle gestante', 'FG', 'Probable', '$."observers"[*]."details"[*]."sex"', 2),
       ('Reptiles', 6, 'sex', 'mâle', 'M', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4),
       ('Reptiles', 6, 'sex', 'femelle', 'F', 'Inconnu', '$."observers"[*]."details"[*]."sex"', 4);