/*
INIT DATA METADATA
------------------
Add main new data


*/

BEGIN
;

INSERT INTO gn_commons.t_parameters (id_organism, parameter_name, parameter_desc, parameter_value,
                                     parameter_extra_value)
VALUES (0, 'gn_local_srid', 'SRID Local par défaut', '2154', NULL)
ON CONFLICT
    DO NOTHING;

COMMIT
;