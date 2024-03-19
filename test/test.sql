DO
$$
    BEGIN


        select fct_c_get_or_insert_basic_acquisition_framework(_name text, _desc text, _startdate date)

        RAISE NOTICE 'TEST DELETE';

        DELETE
            FROM
                src_vn_json.observations_json
            WHERE
                    (site, id) IN (SELECT site, id FROM src_vn_json.observations_json LIMIT 100);

        RAISE NOTICE 'TEST UPDATE';

        UPDATE
            src_vn_json.observations_json
        SET
            item = item
            WHERE
                    (site, id) IN (SELECT site, id FROM src_vn_json.observations_json LIMIT 100);

        RAISE NOTICE 'TEST INSERT';

        INSERT INTO
            src_vn_json.observations_json (id, site, item, update_ts, id_form_universal)
        SELECT
            id
          , 'test'
          , item
          , update_ts
          , id_form_universal
            FROM
                src_vn_json.observations_json
            LIMIT 100;

        ROLLBACK;
    END
$$;


ALTER TABLE gn_meta.t_acquisition_frameworks
ADD COLUMN IF NOT EXISTS additional_data JSONB
DEFAULT '{}'::JSONB;
