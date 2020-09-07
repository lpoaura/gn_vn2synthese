/* Disable some triggers on import_vn.observations_json > src_lpodatas.observations */

ALTER TABLE import_vn.observations_json DISABLE TRIGGER obsfull_delete_from_vn_trigger;
ALTER TABLE import_vn.observations_json DISABLE TRIGGER obsfull_upsert_from_vn_trigger;
ALTER TABLE import_vn.observations_json DISABLE TRIGGER observations_trigger;


/* Disable some triggers on import_vn.forms_json */

ALTER TABLE import_vn.forms_json DISABLE TRIGGER stoc_releve_delete_from_vn_trigger;


/* Truncate observations and forms table */

TRUNCATE import_vn.observations_json ;
TRUNCATE import_vn.forms_json;



