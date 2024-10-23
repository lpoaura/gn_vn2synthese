/*
INIT DATA METADATA
------------------
Add main new data


*/

BEGIN;

ALTER TABLE gn_commons.t_parameters
ADD CONSTRAINT unique_t_parameters_id_organism_parameter_name UNIQUE (
    id_organism, parameter_name
);

CREATE UNIQUE INDEX i_unique_t_parameters_parameter_name_with_id_organism_null ON gn_commons.t_parameters (
    parameter_name
)
WHERE
id_organism IS NULL;

INSERT INTO
gn_commons.t_parameters (
    id_organism,
    parameter_name,
    parameter_desc,
    parameter_value,
    parameter_extra_value
)
VALUES
(
    NULL,
    'visionature_default_dataset',
    'Jeu de données par défaut pour les données Visionature lorsque pas de code étude',
    'visionature_opportunistic',
    NULL
)
ON CONFLICT
DO NOTHING;

INSERT INTO
gn_commons.t_parameters (
    id_organism,
    parameter_name,
    parameter_desc,
    parameter_value,
    parameter_extra_value
)
VALUES
(
    NULL,
    'visionature_default_acquisition_framework',
    'Cadre d''acquisition par défaut pour les nouveaux jeux de données automatiquement créés',
    '<unclassified>',
    NULL
)
ON CONFLICT
DO NOTHING;

INSERT INTO
gn_commons.t_parameters (
    id_organism,
    parameter_name,
    parameter_desc,
    parameter_value,
    parameter_extra_value
)
VALUES
(
    NULL,
    'visionature_default_metadata_actor',
    'Acteur par défaut pour la gestion des métadonnées',
    '8',
    NULL
)
ON CONFLICT
DO NOTHING;

INSERT INTO
gn_commons.t_parameters (
    id_organism,
    parameter_name,
    parameter_desc,
    parameter_value,
    parameter_extra_value
)
VALUES
(
    NULL,
    'visionature_default_cd_nom',
    'cd_nom par défaut lorsque aucune correspondance n''est trouvée',
    (
        SELECT cd_nom
        FROM
            taxonomie.taxref
        WHERE
            cd_nom = cd_ref
            AND lb_nom LIKE 'Animalia'
    ),
    NULL
)
ON CONFLICT
DO NOTHING;


COMMIT;
