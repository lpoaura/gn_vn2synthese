/* Disable some triggers on src_vn_json.observations_json > src_lpodatas.observations */
ALTER TABLE src_vn_json.observations_json DISABLE TRIGGER obsfull_delete_from_vn_trigger;

ALTER TABLE src_vn_json.observations_json DISABLE TRIGGER obsfull_upsert_from_vn_trigger;

ALTER TABLE src_vn_json.observations_json DISABLE TRIGGER observations_trigger;


/* Disable some triggers on src_vn_json.forms_json */
ALTER TABLE src_vn_json.forms_json DISABLE TRIGGER stoc_releve_delete_from_vn_trigger;


/* Truncate observations and forms table */
TRUNCATE src_vn_json.observations_json;

TRUNCATE src_vn_json.forms_json;
