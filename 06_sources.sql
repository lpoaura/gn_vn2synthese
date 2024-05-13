/*
SOURCES
-------
Create sources from sites, each VisioNature site become a source.
*/

BEGIN;

CREATE INDEX IF NOT EXISTS i_source_name ON gn_synthese.t_sources (name_source);

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_upsert_or_get_source_from_visionature (
    _source TEXT
);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_upsert_or_get_source_from_visionature(
    _source TEXT
)
RETURNS INTEGER
AS
$$
DECLARE
    thenewid INT;
BEGIN
    IF (
        SELECT
            exists(
                    SELECT
                        1
                        FROM
                            gn_synthese.t_sources
                        WHERE
                            name_source LIKE _source)) THEN
        SELECT
            id_source
            INTO thenewid
            FROM
                gn_synthese.t_sources
            WHERE
                name_source LIKE _source;
        RAISE DEBUG 'Source named % already exists with id %', _source, thenewid;
    ELSE
        INSERT INTO gn_synthese.t_sources (name_source)
            VALUES (_source)
            RETURNING id_source INTO thenewid;
        RAISE DEBUG 'Source named % inserted with id %', _source, thenewid;
        RETURN thenewid;
    END IF;
    RETURN thenewid;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_upsert_or_get_source_from_visionature(
    _source TEXT
) IS 'function to basically create new sources from VisioNature import';

DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_source_url (
    _id_source INT, _id_data TEXT
);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_source_url(
    _id_source INT, _id_data TEXT DEFAULT NULL
)
RETURNS TEXT
AS
$$
DECLARE
    the_url TEXT;
BEGIN
    SELECT
        CASE WHEN _id_data IS NOT NULL THEN concat(url_source, _id_data) ELSE the_url END
        INTO the_url
        FROM
            gn_synthese.t_sources
        WHERE
            id_source = _id_source;
    RETURN the_url;
END ;
$$
LANGUAGE plpgsql;

COMMIT;
