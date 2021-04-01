/*
 Manage VisioNature sources
 */
CREATE INDEX i_source_name ON gn_synthese.t_sources (name_source) DROP FUNCTION IF EXISTS src_lpodatas.fct_c_upsert_or_get_source_from_visionature (_source TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_upsert_or_get_source_from_visionature (_source text)
    RETURNS integer
    AS $$
DECLARE
    thenewid int;
BEGIN
    IF (
        SELECT
            EXISTS (
            SELECT
                1
            FROM
                gn_synthese.t_sources
            WHERE
                name_source LIKE _source)) THEN
        SELECT
            id_source INTO thenewid
        FROM
            gn_synthese.t_sources
        WHERE
            name_source LIKE _source;
        RAISE NOTICE 'Source named % already exists with id %', _source, thenewid;
    ELSE
        INSERT INTO gn_synthese.t_sources (name_source)
            VALUES (_source)
        RETURNING
            id_source INTO thenewid;
        RAISE NOTICE 'Source named % inserted with id %', _source, thenewid;
        RETURN thenewid;
    END IF;
    RETURN thenewid;
END
$$
LANGUAGE plpgsql;

ALTER FUNCTION src_lpodatas.fct_c_upsert_or_get_source_from_visionature (_source TEXT) OWNER TO gnadm;

COMMENT ON FUNCTION src_lpodatas.fct_c_upsert_or_get_source_from_visionature (_source TEXT) IS 'function to basically create new sources from VisioNature import';


/* TESTS */
SELECT
    src_lpodatas.fct_c_upsert_or_get_source_from_visionature ('test');

