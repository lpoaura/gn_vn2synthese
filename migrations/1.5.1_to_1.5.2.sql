BEGIN;
UPDATE src_vn_json.observations_json
SET item = item
WHERE ((item #>> '{observers,0,count}' = '0'
    AND item #>> '{observers,0,estimation_code}' LIKE 'EXACT_VALUE')
    OR (item #>> '{observers,0,atlas_code}' = '99'));
COMMIT;
