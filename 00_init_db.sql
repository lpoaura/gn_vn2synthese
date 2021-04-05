/*
 Child table with specific datas from:
 - VisioNature
 - dbChiroWeb
 */
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION geonatadmin;

DROP TABLE IF EXISTS src_lpodatas.t_c_synthese_extended;

CREATE TABLE IF NOT EXISTS src_lpodatas.t_c_synthese_extended (
  id_synthese integer PRIMARY KEY REFERENCES gn_synthese.synthese (id_synthese),
  id_sp_source integer,
  taxo_group varchar(50),
  taxo_real boolean,
  common_name varchar(250),
  pseudo_observer_uid varchar(200),
  bird_breed_code integer,
  bird_breed_status varchar(20),
  bat_breed_colo boolean,
  bat_is_gite boolean,
  bat_period varchar(20),
  estimation_code varchar(50),
  date_year integer,
  mortality boolean,
  mortality_cause varchar(250),
  export_excluded boolean,
  project_code varchar(250),
  juridical_person varchar(100),
  behaviour text[],
  geo_accuracy varchar(50),
  details jsonb,
  id_place int,
  place varchar(250),
  id_form varchar(20),
  is_valid boolean,
  private_comment text,
  is_hidden boolean DEFAULT FALSE
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

CREATE INDEX i_t_c_synthese_extended_id_sp_source ON src_lpodatas.t_c_synthese_extended (id_sp_source);

CREATE INDEX i_t_c_synthese_extended_taxo_group ON src_lpodatas.t_c_synthese_extended (taxo_group);

CREATE INDEX i_t_c_synthese_extended_common_name ON src_lpodatas.t_c_synthese_extended (common_name);

CREATE INDEX i_t_c_synthese_extended_id_place ON src_lpodatas.t_c_synthese_extended (id_place);

CREATE INDEX i_t_c_synthese_extended_is_valid ON src_lpodatas.t_c_synthese_extended (is_valid);

CREATE INDEX i_t_c_synthese_extended_is_hidden ON src_lpodatas.t_c_synthese_extended (is_hidden);

CREATE INDEX i_t_c_synthese_extended_bird_breed_code_txt ON src_lpodatas.t_c_synthese_extended (cast(bird_breed_code AS text));

CREATE INDEX i_t_c_synthese_extended_bird_breed_code ON src_lpodatas.t_c_synthese_extended (bird_breed_code);

CREATE INDEX i_t_c_synthese_extended_project_code ON src_lpodatas.t_c_synthese_extended (project_code);

