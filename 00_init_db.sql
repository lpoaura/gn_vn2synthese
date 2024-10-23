/*
INIT DB
-------
Generate extended data table to store specific datas not in GeoNature Synthese table.
Adapted to store data from VisioNature and dbChiroWeb
*/

BEGIN;

ALTER TABLE src_vn_json.forms_json
ADD COLUMN IF NOT EXISTS uuid UUID DEFAULT (public.uuid_generate_v4());

CREATE SCHEMA IF NOT EXISTS src_lpodatas;

DROP TABLE IF EXISTS src_lpodatas.t_c_synthese_extended;

CREATE TABLE IF NOT EXISTS src_lpodatas.t_c_synthese_extended
(
    id_synthese INTEGER PRIMARY KEY REFERENCES gn_synthese.synthese (
        id_synthese
    ) ON DELETE CASCADE ON UPDATE NO ACTION,
    id_sp_source INTEGER,
    taxo_group VARCHAR(50),
    taxo_real BOOLEAN,
    common_name VARCHAR(250),
    pseudo_observer_uid VARCHAR(200),
    observers VARCHAR(200),
    bird_breed_code INTEGER,
    breed_status VARCHAR(20),
    bat_breed_colo BOOLEAN,
    bat_is_gite BOOLEAN,
    bat_period VARCHAR(20),
    estimation_code VARCHAR(50),
    date_year INTEGER,
    mortality BOOLEAN,
    mortality_cause VARCHAR(250),
    export_excluded BOOLEAN,
    project_code VARCHAR(250),
    juridical_person VARCHAR(100),
    behaviour TEXT [],
    geo_accuracy VARCHAR(50),
    details JSONB,
    id_place INT,
    place VARCHAR(250),
    id_form VARCHAR(20),
    is_valid BOOLEAN,
    private_comment TEXT,
    is_hidden BOOLEAN DEFAULT FALSE
);

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_sp_source IS 'Code espèce de la source (VisioNature/dbChiroWeb)';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.taxo_group IS 'Groupe taxonomique VisioNature';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.taxo_real IS 'True si Taxon Vrai';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.common_name IS 'Nom vernaculaire';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.pseudo_observer_uid IS 'Identifiant chiffré de l''Observateur pour anonymisation';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bird_breed_code IS 'Codes "Biolovision" de nidification https://wiki.biolovision.net/Correspondance_codes_atlas';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bird_breed_status IS 'Statut de nidification simplifié (Nicheur possible, probable, certain) d''après oiso_code_nidif';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_breed_colo IS 'Colonie de reproduction de chauves-souris';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_is_gite IS 'Gite à chauves-souris';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.bat_period IS 'Période du cycle annuel des chauves-souris (hivernage, transit printanier ou automnal, estivage)';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.estimation_code IS 'Code caractérisant le type d''estimation du comptage';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.date_year IS 'Année de l''observation';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.mortality IS 'Est une donnée de mortalité';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.mortality_cause IS 'Cause identifiée de la mortalité';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.export_excluded IS 'A exclure des exports';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.project_code IS 'Code étude';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.juridical_person IS 'Personne morale';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.behaviour IS 'Liste (format ARRAY) des comportements observés';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.geo_accuracy IS 'Précision géographique de la donnée';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.details IS 'Détails de la donnée (format JSON)';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_place IS 'Identifiant du lieu-dit';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.place IS 'Nom du Lieu-dit';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.id_form IS 'identifiant du formulaire';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.is_valid IS 'Donnée validée';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.private_comment IS 'Commentaire privé';

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.is_hidden IS 'Donnée cachée';

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_id_sp_source ON src_lpodatas.t_c_synthese_extended (
    id_sp_source
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_taxo_group ON src_lpodatas.t_c_synthese_extended (
    taxo_group
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_common_name ON src_lpodatas.t_c_synthese_extended (
    common_name
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_id_place ON src_lpodatas.t_c_synthese_extended (
    id_place
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_is_valid ON src_lpodatas.t_c_synthese_extended (
    is_valid
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_is_hidden ON src_lpodatas.t_c_synthese_extended (
    is_hidden
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_bird_breed_code_txt ON src_lpodatas.t_c_synthese_extended (
    cast(bird_breed_code AS TEXT)
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_bird_breed_code ON src_lpodatas.t_c_synthese_extended (
    bird_breed_code
);

CREATE INDEX IF NOT EXISTS i_t_c_synthese_extended_project_code ON src_lpodatas.t_c_synthese_extended (
    project_code
);


CREATE TABLE src_lpodatas.t_c_rules_diffusion_level
(
    id_rule_diffusion_level SERIAL PRIMARY KEY,
    cd_nom INT REFERENCES taxonomie.taxref,
    id_nomenclature_diffusion_level INTEGER
    CONSTRAINT fk_synthese_id_nomenclature_diffusion_level
    REFERENCES ref_nomenclatures.t_nomenclatures
    ON UPDATE CASCADE
    CONSTRAINT check_synthese_diffusion_level
    CHECK (ref_nomenclatures.check_nomenclature_type_by_mnemonique(
        id_nomenclature_diffusion_level,
        cast('NIV_PRECIS' AS CHARACTER VARYING)
    )),
    meta_create_date TIMESTAMP DEFAULT now(),
    meta_update_date TIMESTAMP DEFAULT now()
);

CREATE UNIQUE INDEX ON src_lpodatas.t_c_rules_diffusion_level (
    cd_nom, id_nomenclature_diffusion_level
);

COMMENT ON TABLE src_lpodatas.t_c_rules_diffusion_level IS 'Table de règle de niveau de diffusion par taxon';


CREATE TRIGGER tri_meta_dates_change_synthese
BEFORE INSERT OR UPDATE
ON src_lpodatas.t_c_rules_diffusion_level
FOR EACH ROW
EXECUTE PROCEDURE fct_trg_meta_dates_change();


INSERT INTO src_lpodatas.t_c_rules_diffusion_level (
    cd_nom, id_nomenclature_diffusion_level
)
SELECT
    cd_nom,
    ref_nomenclatures.get_id_nomenclature('NIV_PRECIS', '4')
FROM taxonomie.taxref
WHERE
    lb_nom IN ('Canis lupus', 'Lynx lynx')
    AND cd_nom = cd_ref;

CREATE UNIQUE INDEX ON src_lpodatas.t_c_rules_diffusion_level (
    cd_nom, id_nomenclature_diffusion_level
);


COMMIT;
