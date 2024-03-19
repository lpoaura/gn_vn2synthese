# VisionNature database to GeoNature database continuous integration

[![GeoNature](https://img.shields.io/badge/GeoNature-v2.7.5%20tested-brightgreen)](https://github.com/PnX-SI/GeoNature) [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-10+-blue)](https://www.postgresql.org/)

Continuous integration of Visionature data into a GeoNature database.

## Process

1. Transfer of Visionature JSON data to the GeoNature database with [Client_API_VN](https://framagit.org/lpo/Client_API_VN/)
2. Execute triggers on JSON data tables to populate GeoNature database with some default values when there is no correspondances (e.g. new species without any match with TaxRef repository):
  * roles
  * metadata such as acquisition frameworks, datasets and actors)
  * sources
  * observations

Triggers will populate to different tables in GeoNature database:
  * `gn_synthese.synthese`, main synthesis table
  * `gn_synthese.t_sources`
  * `src_lpodatas.t_c_synthese_extended`, child table with specific job data, linked by foreign key (`gn_synthese.synthese.id_synthese`)
  * `gn_meta.t_acquisition_framework`
  * `gn_meta.t_datasets`
  * `gn_meta.cor_dataset_actor`
  * `utilisateurs.t_roles`
  * `utilisateurs.bib_organismes`


![Logos](http://isere.lpo.fr/wp-content/uploads/2019/01/LPO_Agirpourlabio_Auvergne-Rhône-Alpes-transp.png)

## Team

Project developped by [LPO Auvergne-Rhône-Alpes](https//auvergne-rhone-alpes.lpo.fr/)

**Contributors are**:

* Frédéric CLOITRE (@lpofredc) : Development
* Elsa GUILLEY (@eguilley) : Development
* Julien GIRARD-CLAUDON (@lpojgc) : Project coordination
