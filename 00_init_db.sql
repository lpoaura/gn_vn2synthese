/*
  Child table with specific datas from:
    - VisioNature
    - dbChiroWeb

*/


CREATE TABLE IF NOT EXISTS src_lpodatas.synthese_extended
(
    id_sp_source        INTEGER,
    groupe_taxo         VARCHAR(50),
    taxon_vrai          BOOLEAN,
    nom_vern            VARCHAR(250),
    nom_sci             VARCHAR(250),
    pseudo_observer_uid VARCHAR(200),
    oiso_code_nidif     INTEGER,
    oiso_statut_nidif   VARCHAR(20),
    cs_colo_repro       BOOLEAN,
    cs_is_gite          BOOLEAN,
    cs_periode          VARCHAR(20),
    code_estimation     VARCHAR(50),
    date_an             INTEGER,
    mortalite           BOOLEAN,
    mortalite_cause     VARCHAR(250),
    exp_excl            BOOLEAN,
    code_etude          VARCHAR(250),
    pers_morale         VARCHAR(100),
    comportement        TEXT[],
    precision           VARCHAR(50),
    details             JSONB,
    id_place            INT,
    place               VARCHAR(250),
    formulaire          VARCHAR(50),
    id_formulaire       VARCHAR(20),
    is_valid            BOOLEAN,
    donnee_cachee       BOOLEAN DEFAULT FALSE
) INHERITS (gn_synthese.synthese);

COMMENT ON COLUMN src_lpodatas.synthese_extended.id_sp_source IS 'Code espèce de la source (VisioNature/dbChiroWeb)';
COMMENT ON COLUMN src_lpodatas.synthese_extended.groupe_taxo IS 'Groupe taxonomique VisioNature';
COMMENT ON COLUMN src_lpodatas.synthese_extended.taxon_vrai IS 'True si Taxon Vrai';
COMMENT ON COLUMN src_lpodatas.synthese_extended.nom_vern IS 'Nom vernaculaire';
COMMENT ON COLUMN src_lpodatas.synthese_extended.nom_sci IS 'Nom scientifique';
COMMENT ON COLUMN src_lpodatas.synthese_extended.pseudo_observer_uid IS 'Identifiant chiffré de l''Observateur pour anonymisation';
COMMENT ON COLUMN src_lpodatas.synthese_extended.oiso_code_nidif IS 'Codes "Biolovision" de nidification https://wiki.biolovision.net/Correspondance_codes_atlas';
COMMENT ON COLUMN src_lpodatas.synthese_extended.oiso_statut_nidif IS 'Statut de nidification simplifié (Nicheur possible, probable, certain) d''après oiso_code_nidif';
COMMENT ON COLUMN src_lpodatas.synthese_extended.cs_colo_repro IS 'Colonie de reproduction de chauves-souris';
COMMENT ON COLUMN src_lpodatas.synthese_extended.cs_is_gite IS 'Gite à chauves-souris';
COMMENT ON COLUMN src_lpodatas.synthese_extended.cs_periode IS 'Période du cycle annuel des chauves-souris (hivernage, transit printanier ou automnal, estivage)';
COMMENT ON COLUMN src_lpodatas.synthese_extended.code_estimation IS 'Code caractérisant le type d''estimation du comptage';
COMMENT ON COLUMN src_lpodatas.synthese_extended.date_an IS 'Année de l''observation';
COMMENT ON COLUMN src_lpodatas.synthese_extended.mortalite IS 'Est une donnée de mortalité';
COMMENT ON COLUMN src_lpodatas.synthese_extended.mortalite_cause IS 'Cause identifiée de la mortalité';
COMMENT ON COLUMN src_lpodatas.synthese_extended.exp_excl IS 'A exclure des exports';
COMMENT ON COLUMN src_lpodatas.synthese_extended.code_etude IS 'Code étude';
COMMENT ON COLUMN src_lpodatas.synthese_extended.pers_morale IS 'Personne morale';
COMMENT ON COLUMN src_lpodatas.synthese_extended.comportement IS 'Liste (format ARRAY) des comportements observés';
COMMENT ON COLUMN src_lpodatas.synthese_extended.precision IS 'Précision géographique de la donnée';
COMMENT ON COLUMN src_lpodatas.synthese_extended.details IS 'Détails de la donnée (format JSON)';
COMMENT ON COLUMN src_lpodatas.synthese_extended.id_place IS 'identifiant du Lieu-dit';
COMMENT ON COLUMN src_lpodatas.synthese_extended.place IS 'Nom du Lieu-dit';
COMMENT ON COLUMN src_lpodatas.synthese_extended.formulaire IS 'Type de formulaire';
COMMENT ON COLUMN src_lpodatas.synthese_extended.id_formulaire IS 'identifiant du formulaire';
COMMENT ON COLUMN src_lpodatas.synthese_extended.is_valid IS 'Donnée validée';
COMMENT ON COLUMN src_lpodatas.synthese_extended.donnee_cachee IS 'Donnée cachée';






