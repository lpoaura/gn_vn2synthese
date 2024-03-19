/*
NOMENCLATURES
-------------
Nomenclatures synonyms management.
*/

BEGIN;

CREATE TABLE IF NOT EXISTS ref_nomenclatures.t_c_synonyms
(
    id_type          INTEGER
        CONSTRAINT fk_t_c_synonymes_id_type REFERENCES ref_nomenclatures.bib_nomenclatures_types,
    type_mnemonique  VARCHAR(255),
    cd_nomenclature  VARCHAR(255),
    mnemonique       VARCHAR(255),
    label_default    VARCHAR(255),
    initial_value    VARCHAR(255),
    id_nomenclature  INTEGER
        CONSTRAINT fk_t_c_synonymes_id_nomenclature REFERENCES ref_nomenclatures.t_nomenclatures,
    meta_create_date TIMESTAMP DEFAULT now(),
    meta_update_date TIMESTAMP DEFAULT now(),
    id_synonyme      SERIAL NOT NULL
        CONSTRAINT pk_t_synonymes PRIMARY KEY,
    addon_values     JSONB,
    id_source        INTEGER
        CONSTRAINT fk_t_synonymes_id_source REFERENCES gn_synthese.t_sources
);

ALTER TABLE ref_nomenclatures.t_c_synonyms
    OWNER TO geonatadmin;

COMMENT ON TABLE ref_nomenclatures.t_c_synonyms IS 'Table de correspondances des nomenclatures avec une source tierce';

CREATE INDEX i_t_synonymes_initial_value ON ref_nomenclatures.t_c_synonyms (initial_value);

CREATE INDEX i_t_synonymes_id_type ON ref_nomenclatures.t_c_synonyms (id_type);

CREATE INDEX i_t_synonymes_id_nomenclature ON ref_nomenclatures.t_c_synonyms (id_nomenclature);

CREATE INDEX i_t_synonymes_type_mnemonique ON ref_nomenclatures.t_c_synonyms (type_mnemonique);


/* Vue avec types et nomenclatures */
DROP VIEW IF EXISTS ref_nomenclatures.v_c_synonyms;

CREATE OR REPLACE VIEW ref_nomenclatures.v_c_synonyms AS
SELECT DISTINCT bib_nomenclatures_types.id_type       AS types_id_type,
                bib_nomenclatures_types.mnemonique    AS types_mnemonique,
                bib_nomenclatures_types.label_default AS types_label_default,
                t_nomenclatures.id_nomenclature       AS nomenclatures_id_nomenclature,
                t_nomenclatures.cd_nomenclature       AS nomenclatures_cd_nomenclature,
                t_nomenclatures.mnemonique            AS nomenclatures_mnemonique,
                t_nomenclatures.label_default         AS nomenclatures_label_default,
                t_c_synonyms.initial_value            AS synonyms_initial_value,
                t_c_synonyms.meta_create_date         AS synonyms_meta_create_date,
                t_c_synonyms.meta_update_date         AS synonyms_meta_update_date,
                t_c_synonyms.id_source                AS synonyms_id_source,
                t_c_synonyms.addon_values             AS synonyms_addon_values,
                t_sources.name_source                 AS source_name
FROM ref_nomenclatures.t_c_synonyms
         JOIN ref_nomenclatures.bib_nomenclatures_types ON t_c_synonyms.id_type = bib_nomenclatures_types.id_type
         JOIN ref_nomenclatures.t_nomenclatures ON t_c_synonyms.id_nomenclature = t_nomenclatures.id_nomenclature
         JOIN gn_synthese.t_sources ON t_c_synonyms.id_source = t_sources.id_source;


/* Function permettant de retrouver l'id_nomenclature à partir des données VisioNature */
DROP FUNCTION IF EXISTS ref_nomenclatures.fct_c_get_synonyms_nomenclature (_type CHARACTER VARYING, _value CHARACTER VARYING);

CREATE OR REPLACE FUNCTION ref_nomenclatures.fct_c_get_synonyms_nomenclature(_type CHARACTER VARYING, _value CHARACTER VARYING)
    RETURNS INTEGER
    IMMUTABLE
    LANGUAGE plpgsql
AS
$$
DECLARE
    thecodenomenclature INT;
BEGIN
    SELECT INTO thecodenomenclature id_nomenclature
    FROM ref_nomenclatures.t_c_synonyms n
    WHERE n.id_type = ref_nomenclatures.get_id_nomenclature_type(_type)
      AND unaccent(_value)
        ILIKE unaccent(n.initial_value);
    IF (thecodenomenclature IS NOT NULL) THEN
        RETURN thecodenomenclature;
    END IF;
    RETURN thecodenomenclature;
END;
$$;

COMMENT ON FUNCTION ref_nomenclatures.fct_c_get_synonyms_nomenclature (_type CHARACTER VARYING, _value CHARACTER VARYING) IS 'Fonction de recherche des id_nomenclatures'

/* Manage reproduction status */

CREATE TABLE IF NOT EXISTS ref_nomenclatures.t_c_vn_repro_matching_values
(
    id               INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    groupe_taxo_text VARCHAR,
    group_taxo_id    INT,
    data_type        VARCHAR,
    label            VARCHAR,
    value            VARCHAR,
    repro_status     VARCHAR,
    json_path        JSONPATH,
    priority         INT
)
;


CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_reproduction_status(_taxo_group_id INTEGER, _item JSONB)
    RETURNS VARCHAR
    IMMUTABLE
    LANGUAGE plpgsql
AS
$$
DECLARE
    the_obs_values   VARCHAR[];
    the_repro_status VARCHAR;
BEGIN
    SELECT array_agg(i.elem)
    INTO the_obs_values
    FROM jsonb_array_elements_text(
                         jsonb_path_query_array(_item, '$.observers[*].details[*].age') ||
                         jsonb_path_query_array(_item, '$.observers[*].details[*].sex') ||
                         jsonb_path_query_array(_item, '$.observers[*].behaviours[*].\@id')
             ) AS i(elem);


    RAISE DEBUG 'the obs values %', the_obs_values;

    WITH repro_status AS (SELECT group_taxo_id, repro_status, array_agg(DISTINCT value) AS values
                          FROM ref_nomenclatures.t_c_vn_repro_matching_values
                          GROUP BY repro_status, group_taxo_id, priority
                          ORDER BY group_taxo_id, priority)
    SELECT repro_status
    INTO the_repro_status
    FROM repro_status
    WHERE values && the_obs_values
      AND group_taxo_id = _taxo_group_id
    LIMIT 1;
    RETURN the_repro_status;
END;
$$;



COMMIT;
