# gn_vn2synthese

Transfert des données VisioNature reçues depuis l'API avec ClientApiVN vers la synthèse de GeoNature

## Processus

1. Transfer of Visionature JSON data to the GeoNature database with [Client_API_VN](https://framagit.org/lpo/Client_API_VN/)
2. Execute triggers on JSON data tables to populate GeoNature synthesis with some default values when there is no correspondances (e.g. new species without any match with TaxRef repository)

Triggers will populate to different tables:
* `gn_synthese.synthese`, main synthesis table
* `src_lpodatas.t_c_synthese_extended`, child table with specific job data, linked by foreign key (`gn_synthese.synthese.id_synthese`)


