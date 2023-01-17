/*
INIT DB
-------
Generate extended data table to store specific datas not in GeoNature Synthese table.
Adapted to store data from VisioNature and dbChiroWeb
*/


BEGIN
;

CREATE SCHEMA IF NOT EXISTS src_lpodatas
;

DROP TABLE IF EXISTS src_lpodatas.t_c_synthese_extended
;

CREATE TABLE IF NOT EXISTS src_lpodatas.t_c_synthese_extended
(
    id_synthese         INTEGER PRIMARY KEY REFERENCES gn_synthese.synthese (id_synthese),
    id_sp_source        INTEGER,
    taxo_group          VARCHAR(50),
    taxo_real           BOOLEAN,
    common_name         VARCHAR(250),
    pseudo_observer_uid VARCHAR(200),
    observers           VARCHAR(200),
    bird_breed_code     INTEGER,
    bird_breed_status   VARCHAR(20),
    bat_breed_colo      BOOLEAN,
    bat_is_gite         BOOLEAN,
    bat_period          VARCHAR(20),
    estimation_code     VARCHAR(50),
    date_year           INTEGER,
    mortality           BOOLEAN,
    mortality_cause     VARCHAR(250),
    export_excluded     BOOLEAN,
    project_code        VARCHAR(250),
    juridical_person    VARCHAR(100),
    behaviour           TEXT[],
    geo_accuracy        VARCHAR(50),
    details             JSONB,
    id_place            INT,
    place               VARCHAR(250),
    id_form             VARCHAR(20),
    is_valid            BOOLEAN,
    private_comment     TEXT,
    is_hidden           BOOLEAN DEFAULT FALSE
)
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_sp_source IS 'Code espèce de la source (VisioNature/dbChiroWeb)'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.taxo_group IS 'Groupe taxonomique VisioNature'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.taxo_real IS 'True si Taxon Vrai'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.common_name IS 'Nom vernaculaire'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.pseudo_observer_uid IS 'Identifiant chiffré de l''Observateur pour anonymisation'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bird_breed_code IS 'Codes "Biolovision" de nidification https://wiki.biolovision.net/Correspondance_codes_atlas'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bird_breed_status IS 'Statut de nidification simplifié (Nicheur possible, probable, certain) d''après oiso_code_nidif'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_breed_colo IS 'Colonie de reproduction de chauves-souris'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_is_gite IS 'Gite à chauves-souris'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_period IS 'Période du cycle annuel des chauves-souris (hivernage, transit printanier ou automnal, estivage)'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.estimation_code IS 'Code caractérisant le type d''estimation du comptage'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.date_year IS 'Année de l''observation'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.mortality IS 'Est une donnée de mortalité'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.mortality_cause IS 'Cause identifiée de la mortalité'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.export_excluded IS 'A exclure des exports'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.project_code IS 'Code étude'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.juridical_person IS 'Personne morale'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.behaviour IS 'Liste (format ARRAY) des comportements observés'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.geo_accuracy IS 'Précision géographique de la donnée'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.details IS 'Détails de la donnée (format JSON)'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_place IS 'Identifiant du lieu-dit'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.place IS 'Nom du Lieu-dit'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_form IS 'identifiant du formulaire'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.is_valid IS 'Donnée validée'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.private_comment IS 'Commentaire privé'
;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.is_hidden IS 'Donnée cachée'
;

CREATE INDEX i_t_c_synthese_extended_id_sp_source ON src_lpodatas.t_c_synthese_extended (id_sp_source)
;

CREATE INDEX i_t_c_synthese_extended_taxo_group ON src_lpodatas.t_c_synthese_extended (taxo_group)
;

CREATE INDEX i_t_c_synthese_extended_common_name ON src_lpodatas.t_c_synthese_extended (common_name)
;

CREATE INDEX i_t_c_synthese_extended_id_place ON src_lpodatas.t_c_synthese_extended (id_place)
;

CREATE INDEX i_t_c_synthese_extended_is_valid ON src_lpodatas.t_c_synthese_extended (is_valid)
;

CREATE INDEX i_t_c_synthese_extended_is_hidden ON src_lpodatas.t_c_synthese_extended (is_hidden)
;

CREATE INDEX i_t_c_synthese_extended_bird_breed_code_txt ON src_lpodatas.t_c_synthese_extended (cast(bird_breed_code AS TEXT))
;

CREATE INDEX i_t_c_synthese_extended_bird_breed_code ON src_lpodatas.t_c_synthese_extended (bird_breed_code)
;

CREATE INDEX i_t_c_synthese_extended_project_code ON src_lpodatas.t_c_synthese_extended (project_code)
;

CREATE VIEW src_lpodatas.v_c_observations
            (id_synthese, uuid, source, source_id_data, source_id_sp, taxref_cdnom, groupe_taxo, group1_inpn,
             group2_inpn, taxon_vrai, nom_vern, nom_sci, observateur, pseudo_observer_uid, oiso_code_nidif,
             oiso_statut_nidif, cs_colo_repro, cs_is_gite, cs_periode, nombre_total, code_estimation, date, date_an,
             altitude, mortalite, mortalite_cause, geom, exp_excl, code_etude, commentaires, pers_morale, comportement,
             precision, details, place, id_formulaire, derniere_maj, is_valid, donnee_cachee, is_present)
AS
SELECT s.id_synthese
     , s.unique_id_sinp                                                                                                   AS uuid
     , ts.name_source                                                                                                     AS source
     , s.entity_source_pk_value                                                                                           AS source_id_data
     , se.id_sp_source                                                                                                    AS source_id_sp
     , s.cd_nom                                                                                                           AS taxref_cdnom
     , se.taxo_group                                                                                                      AS groupe_taxo
     , t.group1_inpn
     , t.group2_inpn
     , se.taxo_real                                                                                                       AS taxon_vrai
     , se.common_name                                                                                                     AS nom_vern
     , t.lb_nom                                                                                                           AS nom_sci
     , s.observers                                                                                                        AS observateur
     , se.pseudo_observer_uid
     , se.bird_breed_code                                                                                                 AS oiso_code_nidif
     , se.bird_breed_status                                                                                               AS oiso_statut_nidif
     , se.bat_breed_colo                                                                                                  AS cs_colo_repro
     , se.bat_is_gite                                                                                                     AS cs_is_gite
     , se.bat_period                                                                                                      AS cs_periode
     , s.count_max                                                                                                        AS nombre_total
     , se.estimation_code                                                                                                 AS code_estimation
     , s.date_max                                                                                                         AS date
     , se.date_year                                                                                                       AS date_an
     , s.altitude_max                                                                                                     AS altitude
     , se.mortality                                                                                                       AS mortalite
     , se.mortality_cause                                                                                                 AS mortalite_cause
     , s.the_geom_local                                                                                                   AS geom
     , se.export_excluded                                                                                                 AS exp_excl
     , se.project_code                                                                                                    AS code_etude
     , s.comment_description                                                                                              AS commentaires
     , se.juridical_person                                                                                                AS pers_morale
     , se.behaviour                                                                                                       AS comportement
     , se.geo_accuracy                                                                                                    AS precision
     , se.details
     , se.place
     , se.id_form                                                                                                         AS id_formulaire
     , s.meta_update_date                                                                                                 AS derniere_maj
     , (s.id_nomenclature_valid_status IN (SELECT t_nomenclatures.id_nomenclature
                                           FROM ref_nomenclatures.t_nomenclatures
                                           WHERE t_nomenclatures.id_type =
                                                 ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'::CHARACTER VARYING)
                                             AND (t_nomenclatures.cd_nomenclature::TEXT = ANY
                                                  (ARRAY ['1'::CHARACTER VARYING::TEXT, '2'::CHARACTER VARYING::TEXT])))) AS is_valid
     , se.is_hidden                                                                                                       AS donnee_cachee
     , s.id_nomenclature_observation_status = ref_nomenclatures.get_id_nomenclature('STATUT_OBS'::CHARACTER VARYING,
                                                                                    'Pr'::CHARACTER VARYING)              AS is_present
FROM gn_synthese.synthese s
         LEFT JOIN src_lpodatas.t_c_synthese_extended se ON s.id_synthese = se.id_synthese
         JOIN gn_synthese.t_sources ts ON s.id_source = ts.id_source
         JOIN taxonomie.taxref t ON s.cd_nom = t.cd_nom
;


CREATE TABLE src_lpodatas.t_c_rules_diffusion_level
(
    id_rule_diffusion_level         SERIAL PRIMARY KEY,
    cd_nom                          INT REFERENCES taxonomie.taxref,
    id_nomenclature_diffusion_level INTEGER
        CONSTRAINT fk_synthese_id_nomenclature_diffusion_level
            REFERENCES ref_nomenclatures.t_nomenclatures
            ON UPDATE CASCADE
        CONSTRAINT check_synthese_diffusion_level
            CHECK (ref_nomenclatures.check_nomenclature_type_by_mnemonique(id_nomenclature_diffusion_level,
                                                                           'NIV_PRECIS'::CHARACTER VARYING)),
    meta_create_date                TIMESTAMP DEFAULT now(),
    meta_update_date                TIMESTAMP DEFAULT now()
)
;

CREATE UNIQUE INDEX ON src_lpodatas.t_c_rules_diffusion_level (cd_nom, id_nomenclature_diffusion_level)
;

COMMENT ON TABLE src_lpodatas.t_c_rules_diffusion_level IS 'Table de règle de niveau de diffusion par taxon'
;


CREATE TRIGGER tri_meta_dates_change_synthese
    BEFORE INSERT OR UPDATE
    ON src_lpodatas.t_c_rules_diffusion_level
    FOR EACH ROW
EXECUTE PROCEDURE fct_trg_meta_dates_change()
;


INSERT INTO src_lpodatas.t_c_rules_diffusion_level(cd_nom, id_nomenclature_diffusion_level)
SELECT cd_nom
     , ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '4')
FROM taxonomie.taxref
WHERE lb_nom IN ('Canis lupus', 'Lynx lynx')
  AND cd_nom = cd_ref
;

CREATE UNIQUE INDEX ON src_lpodatas.t_c_rules_diffusion_level (cd_nom, id_nomenclature_diffusion_level)
;


ALTER TABLE src_vn_json.forms_json
    ADD COLUMN uuid UUID DEFAULT (public.uuid_generate_v4());

COMMIT
;

SELECT *
FROM gn_synthese.synthese
WHERE id_source = 2
  AND unique_id_sinp_grp IS NOT NULL;