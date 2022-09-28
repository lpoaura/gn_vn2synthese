BEGIN;
CREATE OR REPLACE VIEW src_lpodatas.v_c_observations (id_synthese, uuid, source, source_id_data, source_id_sp, taxref_cdnom, groupe_taxo, group1_inpn, group2_inpn, taxon_vrai, nom_vern, nom_sci, observateur, pseudo_observer_uid, oiso_code_nidif, oiso_statut_nidif, cs_colo_repro, cs_is_gite, cs_periode, nombre_total, code_estimation, date, date_an, altitude, mortalite, mortalite_cause, geom, exp_excl, code_etude, commentaires, pers_morale, comportement, precision, details, place, id_formulaire, derniere_maj, is_valid, donnee_cachee, is_present) AS
SELECT
    s.id_synthese,
    s.unique_id_sinp AS uuid,
    ts.name_source AS source,
    s.entity_source_pk_value AS source_id_data,
    se.id_sp_source AS source_id_sp,
    s.cd_nom AS taxref_cdnom,
    se.taxo_group AS groupe_taxo,
    t.group1_inpn,
    t.group2_inpn,
    se.taxo_real AS taxon_vrai,
    coalesce(se.common_name, split_part(t.nom_vern, ',', 1))::varchar(250) AS nom_vern,
    t.lb_nom AS nom_sci,
    s.observers AS observateur,
    se.pseudo_observer_uid,
    se.bird_breed_code AS oiso_code_nidif,
    se.bird_breed_status AS oiso_statut_nidif,
    se.bat_breed_colo AS cs_colo_repro,
    se.bat_is_gite AS cs_is_gite,
    se.bat_period AS cs_periode,
    s.count_max AS nombre_total,
    se.estimation_code AS code_estimation,
    s.date_max AS date,
    se.date_year AS date_an,
    s.altitude_max AS altitude,
    se.mortality AS mortalite,
    se.mortality_cause AS mortalite_cause,
    s.the_geom_local AS geom,
    se.export_excluded AS exp_excl,
    se.project_code AS code_etude,
    s.comment_description AS commentaires,
    se.juridical_person AS pers_morale,
    se.behaviour AS comportement,
    se.geo_accuracy AS precision,
    se.details,
    se.place,
    se.id_form AS id_formulaire,
    s.meta_update_date AS derniere_maj,
    (s.id_nomenclature_valid_status IN (
            SELECT
                t_nomenclatures.id_nomenclature
            FROM
                ref_nomenclatures.t_nomenclatures
            WHERE
                t_nomenclatures.id_type = ref_nomenclatures.get_id_nomenclature_type ('STATUT_VALID'::character VARYING)
                AND (t_nomenclatures.cd_nomenclature::text = ANY (ARRAY['1'::character VARYING::text, '2'::character VARYING::text])))) AS is_valid,
    se.is_hidden AS donnee_cachee,
    s.id_nomenclature_observation_status = ref_nomenclatures.get_id_nomenclature ('STATUT_OBS'::character VARYING, 'Pr'::character VARYING) AS is_present
FROM
    gn_synthese.synthese s
    LEFT JOIN src_lpodatas.t_c_synthese_extended se ON s.id_synthese = se.id_synthese
    JOIN gn_synthese.t_sources ts ON s.id_source = ts.id_source
    JOIN taxonomie.taxref t ON s.cd_nom = t.cd_nom;
COMMIT;

