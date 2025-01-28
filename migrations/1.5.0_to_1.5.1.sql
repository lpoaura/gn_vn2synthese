BEGIN;

    CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_update_user_observations(_observer_uid text) RETURNS void
        LANGUAGE plpgsql
    AS
    $$
    DECLARE
        row_count INT;
    BEGIN
        RAISE DEBUG '<fct_c_update_user_observations> Update observations for user %', _observer_uid;
        WITH "rows" AS (
            UPDATE src_vn_json.observations_json
                SET item = item
                WHERE observations_json.item #>> '{observers,0,@uid}' = _observer_uid
                RETURNING 1)
        SELECT count(*) into row_count
        FROM "rows";
        RAISE DEBUG '<fct_c_update_user_observations> % Update observations for user %', row_count, _observer_uid;
    END;
    $$;

COMMIT;
