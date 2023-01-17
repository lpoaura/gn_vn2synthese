* [x] Replace taxref_id > cd_nom
* [x] Groupings générer des UUID et les intégrer dans la synthese
* [x] `id_nomenclature_bio_condition` > `ETA_BIO` (vivant vs mort)
* [x] `TYP_INF_GEO` à peupler

| value             | count    | TYPE INFO GEO | Done |
|:------------------|:---------|:--------------|------|
| place             | 10878289 | rattachement  |      |
| polygone          | 13018    | rattachement  | x    |
| subplace\_precise | 26       | rattachement  |      |
| subplace          | 443699   | rattachement  | x    |
| municipality      | 90716    | rattachement  | x    |
| polygone\_precise | 22381    | rattachement  | x    |
| transect          | 87510    | rattachement  | x    |
| square            | 51       | rattachement  |      |
| garden            | 1024999  | rattachement  | x    |
| transect\_precise | 2154     | rattachement  |      |
| precise           | 13366436 | georef        | x    |

* [ ] Faire la MaJ sans déclenchement de trigger:
    * TYPE_INFO_GEO
    * ETA_BIO
    * UUID Group

On transmettra à Donovan et JP **un fichier de MaJ avec les UUID** et les données associées.

