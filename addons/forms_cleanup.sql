/* Suppression des formulaires orphelins */
ROLLBACK;
BEGIN;
CREATE TABLE src_vn_json.forms_json_orphans_deleted AS
SELECT forms_json.*
--, CAST(obs.item #>> '{observers,0,id_form}' AS INTEGER) as obs_id_form, obs.id
FROM src_vn_json.forms_json
         LEFT JOIN (SELECT DISTINCT CAST(observations_json.item #>> '{observers,0,id_form}' AS INTEGER) AS id_form
                    FROM src_vn_json.observations_json) obs
                   ON obs.id_form = forms_json.id
WHERE obs.id_form IS NULL;
SELECT COUNT(*)
FROM src_vn_json.forms_json_orphans_deleted;
DELETE
FROM src_vn_json.forms_json
WHERE id IN (SELECT forms_json.id
             FROM src_vn_json.forms_json
                      LEFT JOIN src_vn_json.observations_json
                                ON CAST(observations_json.item #>> '{observers,0,id_form}' AS INTEGER) = forms_json.id
             WHERE observations_json.id IS NULL);

COMMIT;

/* Fix id_form_universal = '0' */
BEGIN;
ALTER TABLE src_vn_json.forms_json
    DROP COLUMN IF EXISTS id_form_universal;
ALTER TABLE src_vn_json.forms_json
    ADD COLUMN id_form_universal VARCHAR GENERATED ALWAYS AS (
        CASE
            WHEN ((((item ->> 'id_form_universal'::TEXT))::CHARACTER VARYING IS NOT NULL) AND
                  ((((item ->> 'id_form_universal'::TEXT))::CHARACTER VARYING)::TEXT <> '0'::TEXT))
                THEN ((item ->> 'id_form_universal'::TEXT))::CHARACTER VARYING
            ELSE NULL::CHARACTER VARYING
            END) STORED;
CREATE UNIQUE INDEX forms_json_id_form_universal_idx ON src_vn_json.forms_json (id_form_universal);
UPDATE src_lpodatas.t_c_synthese_extended
SET id_form = NULL
WHERE id_form = '0';
COMMIT;


DROP VIEW IF EXISTS src_lpodatas.v_c_observations;
create view src_lpodatas.v_c_observations
            (id_synthese, uuid, source, desc_source, jdd, jdd_uuid, source_id_data, source_id_sp, cd_nom, cd_ref,
             groupe_taxo, group1_inpn, group2_inpn, id_rang, taxon_vrai, nom_vern, nom_sci, statut_validation,
             observateur, pseudo_observer_uid, oiso_code_nidif, statut_repro, cs_colo_repro, cs_is_gite, cs_periode,
             nombre_total, code_estimation, date, date_jour, heure, date_an, altitude, mortalite, mortalite_cause,
             type_geom, geom, exp_excl, code_etude, comment, comment_priv, pers_morale, comportement, precision,
             details, place, id_formulaire, comment_form, derniere_maj, is_valid, donnee_cachee, is_present,
             reference_biblio, geom_ekt)
as
SELECT sd.id_synthese
     , sd.unique_id_sinp                                                                               AS uuid
     , s.name_source                                                                                   AS source
     , s.desc_source
     , ds.dataset_name                                                                                 AS jdd
     , ds.unique_dataset_id                                                                            AS jdd_uuid
     , sd.entity_source_pk_value                                                                       AS source_id_data
     , se.id_sp_source                                                                                 AS source_id_sp
     , t.cd_ref                                                                                        AS cd_nom
     , t.cd_ref
     , t.groupe_taxo_fr::CHARACTER VARYING(50)                                                         AS groupe_taxo
     , t.tx_group1_inpn::CHARACTER VARYING(255)                                                        AS group1_inpn
     , t.tx_group2_inpn::CHARACTER VARYING(255)                                                        AS group2_inpn
     , t.tx_id_rang::CHARACTER VARYING(10)                                                             AS id_rang
     , se.taxo_real                                                                                    AS taxon_vrai
     , COALESCE(t.vn_nom_fr, t.tx_nom_fr)                                                              AS nom_vern
     , COALESCE(t.vn_nom_sci, t.tx_nom_sci)                                                            AS nom_sci
     , nom_valid.label_default                                                                         AS statut_validation
     , sd.observers                                                                                    AS observateur
     , se.pseudo_observer_uid
     , se.bird_breed_code                                                                              AS oiso_code_nidif
     , se.breed_status                                                                                 AS statut_repro
     , se.bat_breed_colo                                                                               AS cs_colo_repro
     , se.bat_is_gite                                                                                  AS cs_is_gite
     , se.bat_period                                                                                   AS cs_periode
     , sd.count_max                                                                                    AS nombre_total
     , se.estimation_code                                                                              AS code_estimation
     , sd.date_min                                                                                     AS date
     , sd.date_min::DATE                                                                               AS date_jour
     , sd.date_min::TIME WITHOUT TIME ZONE                                                             AS heure
     , EXTRACT(YEAR FROM sd.date_min)::INTEGER                                                         AS date_an
     , sd.altitude_max                                                                                 AS altitude
     , se.mortality                                                                                    AS mortalite
     , se.mortality_cause                                                                              AS mortalite_cause
     , st_geometrytype(sd.the_geom_4326)                                                               AS type_geom
     , sd.the_geom_local                                                                               AS geom
     , se.export_excluded                                                                              AS exp_excl
     , se.project_code                                                                                 AS code_etude
     , sd.comment_description                                                                          AS comment
     , se.private_comment                                                                              AS comment_priv
     , se.juridical_person                                                                             AS pers_morale
     , se.behaviour::TEXT                                                                              AS comportement
     , se.geo_accuracy                                                                                 AS "precision"
     , se.details::TEXT                                                                                AS details
     , se.place
     , se.id_form                                                                                      AS id_formulaire
     , forms.item ->> 'comment'::TEXT                                                                  AS comment_form
     , sd.meta_update_date                                                                             AS derniere_maj
     , sd.id_nomenclature_valid_status = ANY
       (ARRAY [ref_nomenclatures.get_id_nomenclature('STATUT_VALID'::CHARACTER VARYING,
                                                     '2'::CHARACTER VARYING), ref_nomenclatures.get_id_nomenclature(
               'STATUT_VALID'::CHARACTER VARYING, '1'::CHARACTER VARYING)])                            AS is_valid
     , se.is_hidden                                                                                    AS donnee_cachee
     , sd.id_nomenclature_observation_status =
       ref_nomenclatures.get_id_nomenclature('STATUT_OBS'::CHARACTER VARYING, 'Pr'::CHARACTER VARYING) AS is_present
     , sd.reference_biblio
     , st_asewkt(sd.the_geom_local)                                                                    AS geom_ekt
FROM gn_synthese.synthese sd
         JOIN taxonomie.mv_c_cor_vn_taxref t ON t.cd_nom = sd.cd_nom
         JOIN gn_synthese.t_sources s ON sd.id_source = s.id_source
         LEFT JOIN src_lpodatas.t_c_synthese_extended se ON sd.id_synthese = se.id_synthese
         LEFT JOIN src_vn_json.forms_json forms ON se.id_form::TEXT = forms.id_form_universal::TEXT
         LEFT JOIN gn_meta.t_datasets ds ON sd.id_dataset = ds.id_dataset
         LEFT JOIN ref_nomenclatures.t_nomenclatures nom_valid
                   ON nom_valid.id_nomenclature = sd.id_nomenclature_valid_status AND
                      nom_valid.id_type = ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'::CHARACTER VARYING);

alter table src_lpodatas.v_c_observations
    owner to dbadmin;

grant select on src_lpodatas.v_c_observations to readonly;
