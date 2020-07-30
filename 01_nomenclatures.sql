DROP TABLE IF EXISTS
ref_nomenclatures.t_synonymes ;
CREATE TABLE ref_nomenclatures.t_synonymes
(
    id_type                 INTEGER
        CONSTRAINT t_synonymes_id_type_fkey
            REFERENCES ref_nomenclatures.bib_nomenclatures_types,
    type_mnemonique         VARCHAR(255),
    cd_nomenclature         VARCHAR(255),
    mnemonique VARCHAR(255),
    label_default           VARCHAR(255),
    initial_value           VARCHAR(255),
    id_nomenclature         INTEGER
        CONSTRAINT t_synonymes_id_nomenclature_fkey
            REFERENCES ref_nomenclatures.t_nomenclatures,
    meta_create_date        TIMESTAMP DEFAULT now(),
    meta_update_date        TIMESTAMP DEFAULT now(),
    id_synonyme             SERIAL NOT NULL
        CONSTRAINT t_synonymes_pkey
            PRIMARY KEY,
    addon_values            JSONB,
    id_source               INTEGER
        CONSTRAINT t_synonymes_id_source_fkey
            REFERENCES gn_synthese.t_sources
);

ALTER TABLE ref_nomenclatures.t_synonymes
    OWNER TO geonature;

COMMENT ON TABLE ref_nomenclatures.t_synonymes IS 'Table de correspondances des nomenclatures avec une source tierce';

CREATE INDEX i_t_synonymes_initial_value ON ref_nomenclatures.t_synonymes (initial_value);
CREATE INDEX i_t_synonymes_id_type ON ref_nomenclatures.t_synonymes (id_type);
CREATE INDEX i_t_synonymes_id_nomenclature ON ref_nomenclatures.t_synonymes (id_nomenclature);
CREATE INDEX i_t_synonymes_type_mnemonique ON ref_nomenclatures.t_synonymes (type_mnemonique);


/* Vue avec types et nomenclatures */

DROP VIEW IF EXISTS ref_nomenclatures.v_synonyms;

CREATE OR REPLACE VIEW ref_nomenclatures.v_synonyms
AS
SELECT DISTINCT
    bib_nomenclatures_types.id_type       AS types_id_type
  , bib_nomenclatures_types.mnemonique    AS types_mnemonique
  , bib_nomenclatures_types.label_default AS types_label_default
  , t_nomenclatures.id_nomenclature       AS nomenclatures_id_nomenclature
  , t_nomenclatures.cd_nomenclature       AS nomenclatures_cd_nomenclature
  , t_nomenclatures.mnemonique            AS nomenclatures_mnemonique
  , t_nomenclatures.label_default         AS nomenclatures_label_default
  , t_synonymes.initial_value             AS synonyms_initial_value
  , t_synonymes.meta_create_date          AS synonyms_meta_create_date
  , t_synonymes.meta_update_date          AS synonyms_meta_update_date
  , t_synonymes.id_source                 AS synonyms_id_source
  , t_synonymes.addon_values              AS synonyms_addon_values
  , t_sources.name_source                 AS source_name
    FROM
        ref_nomenclatures.t_synonymes
            JOIN ref_nomenclatures.bib_nomenclatures_types ON t_synonymes.id_type = bib_nomenclatures_types.id_type
            JOIN ref_nomenclatures.t_nomenclatures ON t_synonymes.id_nomenclature = t_nomenclatures.id_nomenclature
            JOIN gn_synthese.t_sources ON t_synonymes.id_source = t_sources.id_source;

ALTER TABLE ref_nomenclatures.v_synonyms
    OWNER TO geonature;


/* Function permettant de retrouver l'id_nomenclature à partir des données VisioNature */

DROP FUNCTION IF EXISTS ref_nomenclatures.fct_get_synonymes_nomenclature(_type CHARACTER VARYING, _value CHARACTER VARYING);

CREATE OR REPLACE FUNCTION ref_nomenclatures.fct_get_synonymes_nomenclature(_type CHARACTER VARYING, _value CHARACTER VARYING) RETURNS INTEGER
    IMMUTABLE
    LANGUAGE plpgsql
AS
$$
DECLARE
    thecodenomenclature INT;
BEGIN
    SELECT INTO thecodenomenclature
        id_nomenclature
        FROM
            ref_nomenclatures.t_synonymes n
        WHERE
              n.id_type = ref_nomenclatures.get_id_nomenclature_type(_type)
          AND unaccent(_value) ILIKE unaccent(n.initial_value);

    IF (thecodenomenclature IS NOT NULL) THEN
        RETURN thecodenomenclature;
    END IF;
    RETURN NULL;
    RETURN thecodenomenclature;
END;
$$;

ALTER FUNCTION ref_nomenclatures.fct_get_synonymes_nomenclature(_type CHARACTER VARYING, _value CHARACTER VARYING) OWNER TO geonature;

COMMENT ON FUNCTION ref_nomenclatures.fct_get_synonymes_nomenclature(_type CHARACTER VARYING, _value CHARACTER VARYING) IS 'Fonction de recherche des id_nomenclatures'


