/*
V_C_OBSERVATIONS views
----------------------
Custom views to consult lpo datas
*/


BEGIN;

CREATE MATERIALIZED VIEW taxonomie.mv_c_cor_vn_taxref AS
WITH prep_vn AS (
    SELECT DISTINCT
        sp.id AS vn_id,
        tg.item ->> 'name'::TEXT AS groupe_taxo_fr,
        tg.item ->> 'latin_name'::TEXT AS groupe_taxo_sci,
        sp.item ->> 'french_name'::TEXT AS french_name,
        sp.item ->> 'latin_name'::TEXT AS latin_name
    FROM src_vn_json.species_json AS sp
    LEFT JOIN src_vn_json.taxo_groups_json AS tg
        ON
            ((sp.item ->> 'id_taxo_group'::TEXT)::INTEGER) = tg.id
            AND sp.site::TEXT = tg.site::TEXT
    GROUP BY
        sp.id, (tg.item ->> 'name'::TEXT), (tg.item ->> 'latin_name'::TEXT),
        (sp.item ->> 'french_name'::TEXT), (sp.item ->> 'latin_name'::TEXT)
)

SELECT
    prep_vn.vn_id,
    prep_vn.groupe_taxo_fr,
    prep_vn.groupe_taxo_sci,
    tx.cd_nom,
    tx.cd_ref,
    tx.group1_inpn AS tx_group1_inpn,
    tx.group2_inpn AS tx_group2_inpn,
    tx.id_rang AS tx_id_rang,
    tx.ordre AS tx_ordre,
    tx.classe AS tx_classe,
    tx.famille AS tx_famille,
    tx.nom_vern AS tx_nom_fr,
    tx.lb_nom AS tx_nom_sci,
    coalesce(prep_vn.french_name, tx.nom_vern::TEXT) AS vn_nom_fr,
    coalesce(prep_vn.latin_name, tx.lb_nom::TEXT) AS vn_nom_sci
FROM taxonomie.taxref AS tx
LEFT JOIN taxonomie.cor_c_vn_taxref AS corr ON tx.cd_nom = corr.cd_nom
LEFT JOIN prep_vn ON corr.vn_id = prep_vn.vn_id
WHERE tx.cd_nom = tx.cd_ref;

ALTER MATERIALIZED VIEW taxonomie.mv_c_cor_vn_taxref OWNER TO dbadmin;

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_cd_nom_idx3
ON taxonomie.mv_c_cor_vn_taxref (cd_nom);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_cd_ref_idx1
ON taxonomie.mv_c_cor_vn_taxref (cd_ref);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_groupe_taxo_fr_idx3
ON taxonomie.mv_c_cor_vn_taxref (groupe_taxo_fr);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_tx_group2_inpn_idx3
ON taxonomie.mv_c_cor_vn_taxref (tx_group2_inpn);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_tx_id_rang_idx1
ON taxonomie.mv_c_cor_vn_taxref (tx_id_rang);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_tx_nom_fr_idx3
ON taxonomie.mv_c_cor_vn_taxref (tx_nom_fr);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_tx_nom_sci_idx3
ON taxonomie.mv_c_cor_vn_taxref (tx_nom_sci);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_tx_ordre_idx1
ON taxonomie.mv_c_cor_vn_taxref (tx_ordre);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_vn_nom_fr_idx3
ON taxonomie.mv_c_cor_vn_taxref (vn_nom_fr);

CREATE INDEX taxonomie.mv_c_cor_vn_taxref_vn_nom_sci_idx3
ON taxonomie.mv_c_cor_vn_taxref (vn_nom_sci);

CREATE OR REPLACE VIEW src_lpodatas.v_c_observations
(
    id_synthese,
    uuid,
    source,
    desc_source,
    source_id_data,
    source_id_sp,
    taxref_cdnom,
    cd_nom,
    cd_ref,
    groupe_taxo,
    group1_inpn,
    group2_inpn,
    id_rang,
    taxon_vrai,
    nom_vern,
    nom_sci,
    observateur,
    pseudo_observer_uid,
    oiso_code_nidif,
    statut_repro,
    oiso_statut_nidif,
    cs_colo_repro,
    cs_is_gite,
    cs_periode,
    nombre_total,
    code_estimation,
    date,
    date_jour,
    heure,
    date_an,
    altitude,
    mortalite,
    mortalite_cause,
    type_geom,
    geom,
    exp_excl,
    code_etude,
    comment,
    comment_priv,
    pers_morale,
    comportement,
    precision,
    details,
    place,
    id_formulaire,
    derniere_maj,
    is_valid,
    donnee_cachee,
    is_present,
    reference_biblio, geom_ekt
)
AS
SELECT
    s.id_synthese,
    s.unique_id_sinp AS uuid,
    ts.name_source AS source,
    ts.desc_source,
    s.entity_source_pk_value AS source_id_data,
    se.id_sp_source AS source_id_sp,
    s.cd_nom AS taxref_cdnom,
    s.cd_nom,
    cor.cd_ref,
    cor.groupe_taxo_fr::CHARACTER VARYING(50) AS groupe_taxo,
    cor.tx_group1_inpn AS group1_inpn,
    cor.tx_group2_inpn AS group2_inpn,
    cor.tx_id_rang AS id_rang,
    se.taxo_real AS taxon_vrai,
    s.observers AS observateur,
    se.pseudo_observer_uid,
    se.bird_breed_code AS oiso_code_nidif,
    se.breed_status AS statut_repro,
    se.breed_status AS oiso_statut_nidif,
    se.bat_breed_colo AS cs_colo_repro,
    se.bat_is_gite AS cs_is_gite,
    se.bat_period AS cs_periode,
    s.count_max AS nombre_total,
    se.estimation_code AS code_estimation,
    s.date_min AS date,
    s.date_min::DATE AS date_jour,
    s.date_min::TIME WITHOUT TIME ZONE AS heure,
    extract(YEAR FROM s.date_min)::INTEGER AS date_an,
    s.altitude_max AS altitude,
    se.mortality AS mortalite,
    se.mortality_cause AS mortalite_cause,
    s.the_geom_local AS geom,
    se.export_excluded AS exp_excl,
    se.project_code AS code_etude,
    s.comment_description AS comment,
    se.private_comment AS comment_priv,
    se.juridical_person AS pers_morale,
    se.behaviour::TEXT AS comportement,
    se.geo_accuracy AS precision,
    se.details::TEXT AS details,
    se.place,
    se.id_form AS id_formulaire,
    s.meta_update_date AS derniere_maj,
    se.is_hidden AS donnee_cachee,
    s.reference_biblio,
    coalesce(cor.vn_nom_fr, cor.tx_nom_fr::TEXT) AS nom_vern,
    coalesce(cor.vn_nom_sci, cor.tx_nom_sci::TEXT) AS nom_sci,
    st_geometrytype(s.the_geom_local) AS type_geom,
    s.id_nomenclature_valid_status
    = any(ARRAY[ref_nomenclatures.get_id_nomenclature(
        'STATUT_VALID'::CHARACTER VARYING,
        '2'::CHARACTER VARYING), ref_nomenclatures.get_id_nomenclature(
        'STATUT_VALID'::CHARACTER VARYING, '1'::CHARACTER VARYING
    )]) AS is_valid,
    s.id_nomenclature_observation_status
    = ref_nomenclatures.get_id_nomenclature(
        'STATUT_OBS'::CHARACTER VARYING, 'Pr'::CHARACTER VARYING
    ) AS is_present,
    st_asewkt(s.the_geom_local) AS geom_ekt
FROM gn_synthese.synthese AS s
LEFT JOIN
    src_lpodatas.t_c_synthese_extended AS se
    ON s.id_synthese = se.id_synthese
INNER JOIN gn_synthese.t_sources AS ts ON s.id_source = ts.id_source
LEFT JOIN
    taxonomie.mv_c_cor_vn_taxref AS cor
    ON s.cd_nom = cor.cd_nom AND cor.cd_nom IS NOT NULL;


CREATE VIEW src_lpodatas.v_c_observations_light
(
    id_synthese,
    uuid,
    source,
    desc_source,
    source_id_data,
    source_id_sp,
    taxref_cdnom,
    cd_nom,
    cd_ref,
    groupe_taxo,
    group1_inpn,
    group2_inpn,
    id_rang,
    taxon_vrai,
    nom_vern,
    nom_sci,
    observateur,
    pseudo_observer_uid,
    oiso_code_nidif,
    statut_repro,
    oiso_statut_nidif,
    cs_colo_repro,
    cs_is_gite,
    cs_periode,
    nombre_total,
    code_estimation,
    date,
    date_jour,
    heure,
    date_an,
    altitude,
    mortalite,
    mortalite_cause,
    type_geom,
    geom,
    exp_excl,
    code_etude,
    comment,
    comment_priv,
    pers_morale,
    comportement,
    precision,
    details,
    place,
    id_formulaire,
    derniere_maj,
    is_valid,
    donnee_cachee,
    is_present,
    reference_biblio, geom_ekt
)
AS
SELECT
    s.id_synthese,
    s.unique_id_sinp AS uuid,
    ts.name_source AS source,
    ts.desc_source,
    s.entity_source_pk_value AS source_id_data,
    se.id_sp_source AS source_id_sp,
    s.cd_nom AS taxref_cdnom,
    s.cd_nom,
    cor.cd_ref,
    cor.groupe_taxo_fr::CHARACTER VARYING(50) AS groupe_taxo,
    cor.tx_group1_inpn AS group1_inpn,
    cor.tx_group2_inpn AS group2_inpn,
    cor.tx_id_rang AS id_rang,
    se.taxo_real AS taxon_vrai,
    s.observers AS observateur,
    se.pseudo_observer_uid,
    se.bird_breed_code AS oiso_code_nidif,
    se.breed_status AS statut_repro,
    se.breed_status AS oiso_statut_nidif,
    se.bat_breed_colo AS cs_colo_repro,
    se.bat_is_gite AS cs_is_gite,
    se.bat_period AS cs_periode,
    s.count_max AS nombre_total,
    se.estimation_code AS code_estimation,
    s.date_min AS date,
    s.date_min::DATE AS date_jour,
    s.date_min::TIME WITHOUT TIME ZONE AS heure,
    extract(YEAR FROM s.date_min)::INTEGER AS date_an,
    s.altitude_max AS altitude,
    se.mortality AS mortalite,
    se.mortality_cause AS mortalite_cause,
    s.the_geom_local AS geom,
    se.export_excluded AS exp_excl,
    se.project_code AS code_etude,
    s.comment_description AS comment,
    se.private_comment AS comment_priv,
    se.juridical_person AS pers_morale,
    se.behaviour::TEXT AS comportement,
    se.geo_accuracy AS precision,
    se.details::TEXT AS details,
    se.place,
    se.id_form AS id_formulaire,
    s.meta_update_date AS derniere_maj,
    se.is_hidden AS donnee_cachee,
    s.reference_biblio,
    coalesce(cor.vn_nom_fr, cor.tx_nom_fr::TEXT) AS nom_vern,
    coalesce(cor.vn_nom_sci, cor.tx_nom_sci::TEXT) AS nom_sci,
    st_geometrytype(s.the_geom_local) AS type_geom,
    s.id_nomenclature_valid_status
    = any(ARRAY[ref_nomenclatures.get_id_nomenclature(
        'STATUT_VALID'::CHARACTER VARYING,
        '2'::CHARACTER VARYING), ref_nomenclatures.get_id_nomenclature(
        'STATUT_VALID'::CHARACTER VARYING, '1'::CHARACTER VARYING
    )]) AS is_valid,
    s.id_nomenclature_observation_status
    = ref_nomenclatures.get_id_nomenclature(
        'STATUT_OBS'::CHARACTER VARYING, 'Pr'::CHARACTER VARYING
    ) AS is_present,
    st_asewkt(s.the_geom_local) AS geom_ekt
FROM gn_synthese.synthese AS s
LEFT JOIN
    src_lpodatas.t_c_synthese_extended AS se
    ON s.id_synthese = se.id_synthese
INNER JOIN gn_synthese.t_sources AS ts ON s.id_source = ts.id_source
LEFT JOIN
    taxonomie.mv_c_cor_vn_taxref AS cor
    ON s.cd_nom = cor.cd_nom AND cor.cd_nom IS NOT NULL;

COMMIT;
