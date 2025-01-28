# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

<!-- ## Unreleased [{version_tag}](https://github.com/opengisch/qgis-plugin-ci/releases/tag/{version_tag}) - YYYY-MM-DD -->

## 1.5.1 - 2025-01-28

### Changes

- Add missing `src_lpodatas.fct_c_update_user_observations(_observer_uid text)` function, required on user anonymous status changes.

### TODO

1. Execute script `migrations/1.5.0_to_1.5.1.sql`

## 1.5.0 - 2025-01-22

### Changes

- Fix missing `COMMIT;` on `09d_init_data_taxonomie.sql`
- New `taxonomie.t_c_taxref_ajout` to manage custom taxa on taxref. cd_ref and cd_nom are negative to avoid conflicts on official values. Insert/Update/Delete on this table will reflect changes on `taxonomie.taxref` table. `09d_init_data_taxonomie.sql` now contains also those new taxa, expected to populate data from faune-france.

### TODO

1. Execute script folowing query `migrations/1.4.1_to_1.5.0.sql`
2. Execute script `09d_init_data_taxonomie.sql`

## 1.4.1 - 2024-11-04

### Changes

- Fix empty `the_geom_local` caused by a change on `gn_commons.get_default_parameters` function (fix #23).
- Fix missing string word (`Jeu de données compléter` -> `Jeu de données à compléter`) (fix #11)

### TODO on update

1. Apply scripts in order:
    1. `02_metadata.sql`
    2. `08_upsert_observations.sql`
    

## 1.4.0 - 2024-10-23

### Changes

- Rename field `src_lpodatas.t_c_synthese_extended.bird_breed_status` to `breed_status`, no used for all taxa groups and populated from interpretation of various data (behaviour, life stage)
- Add `IF EXISTS / IF NOT EXISTS` to secure scripts application.
- View `src_lpodatas.v_c_observations` and `taxonomie.mv_c_cor_vn_taxref` are now part of [lpoaura/PluginQGIS-LPOData](https://github.com/lpoaura/PluginQGis-LPOData/tree/master/config) project
- Adapt insert of parameters in `gn_commons.t_parameters` due to new constraint on organisms foreign key.
- Better management for specific LPO-Sympetrum data (specific AuRA case) are now conditionned to existing view.
- Add sample code to generate portal area coverage to exclude data out of coverage.

### TODO on update

1. Apply script `migrations/1.3.1_to_1.4.0.sql`
2. Apply scripts in order:
    1. `02_metadata.sql`
    2. `07_functions.sql`
    3. `08_upsert_observations.sql`
    



## 1.3.1 - 2024-05-13

### Changed

* Optional management of hidden data based on visionature's national sensitivity rules (definition of a precise distribution level, whereas data hidden a priori by observers have a grid distribution level).
Depends on python app https://github.com/lpoaura/faune-france-global-sensitivity-rules-parser.
