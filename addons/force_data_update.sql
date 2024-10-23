ALTER TABLE gn_meta.t_acquisition_frameworks
    ADD additional_data jsonb DEFAULT '{}'::jsonb;
ALTER TABLE gn_meta.t_datasets
    ADD additional_data jsonb DEFAULT '{}'::jsonb;

UPDATE src_vn_json.entities_json
SET item = item;
UPDATE src_vn_json.observers_json
SET item = item;
ALTER TABLE src_vn_json.observations_json
    ENABLE TRIGGER fct_tri_c_upsert_vn_observation_to_geonature;
ALTER TABLE src_vn_json.observations_json
    ENABLE TRIGGER tri_c_delete_vn_observation_from_geonature;
UPDATE src_vn_json.observations_json
SET item = item;
