# gn_vn2synthese

[![GeoNature](https://img.shields.io/badge/GeoNature-v2.5.5%20tested-brightgreen)](https://github.com/PnX-SI/GeoNature) [![Python](https://img.shields.io/badge/Python-3.7+-blueviolet)](https://www.python.org/) [![Poetry](https://img.shields.io/badge/packaging%20tool-poetry-important)](https://python-poetry.org/) [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-10+-blue)](https://www.postgresql.org/)

Transfer of Visionature JSON data to the GeoNature database
## Process

1. Transfer of Visionature JSON data to the GeoNature database with [Client_API_VN](https://framagit.org/lpo/Client_API_VN/)
2. Execute triggers on JSON data tables to populate GeoNature synthesis with some default values when there is no correspondances (e.g. new species without any match with TaxRef repository)

Triggers will populate to different tables:
* `gn_synthese.synthese`, main synthesis table
* `src_lpodatas.t_c_synthese_extended`, child table with specific job data, linked by foreign key (`gn_synthese.synthese.id_synthese`)


![Logos](http://isere.lpo.fr/wp-content/uploads/2019/01/LPO_Agirpourlabio_Auvergne-Rhône-Alpes-transp.png)


## Team


Project developped by [LPO Auvergne-Rhône-Alpes](https//auvergne-rhone-alpes.lpo.fr/) 


Contributors are:

* Frédéric CLOITRE (@lpofredc) : Développement
* Elsa GUILLEY (@eguilley) : Développement
* Julien GIRARD-CLAUDON (@lpojgc) : Coordination du projet
