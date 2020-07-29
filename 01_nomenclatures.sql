CREATE TABLE ref_nomenclatures.t_synonymes
(
    id_type                 INTEGER
        CONSTRAINT t_synonymes_id_type_fkey
            REFERENCES bib_nomenclatures_types,
    type_mnemonique         VARCHAR(255),
    cd_nomenclature         VARCHAR(255),
    nomenclature_mnemonique VARCHAR(255),
    label_default           VARCHAR(255),
    initial_value           VARCHAR(255),
    id_nomenclature         INTEGER
        CONSTRAINT t_synonymes_id_nomenclature_fkey
            REFERENCES t_nomenclatures,
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
  , t_synonymes.id_synonyme               AS synonyms_id_synonyme
  , t_synonymes.id_type                   AS synonyms_id_type
  , t_synonymes.cd_nomenclature           AS synonyms_cd_nomenclature
  , t_synonymes.mnemonique                AS synonyms_mnemonique
  , t_synonymes.label_default             AS synonyms_label_default
  , t_synonymes.initial_value             AS synonyms_initial_value
  , t_synonymes.id_nomenclature           AS synonyms_id_nomenclature
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


/* Intégration des correspondances nomenclatures SINP / Données VisioNature */

INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'OUTSHELTER'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 80
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'BONESREMAINS'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 81
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'BONESREMAINS'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 82
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'BONESREMAINS'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 83
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'LAIDINACTIV', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 84, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDINACTIV'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 85
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDINACTIV'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 86
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'LAID', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 98, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '5'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 1
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '6'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 2
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '7'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 3
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '8'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 4
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '9'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 5
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '10'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 6
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '11'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 7
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '12'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 8
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '13'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 9
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '14'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 10
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '15'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 11
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '16'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 12
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '17'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 13
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '4'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 14
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '18'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 15
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '19'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 16
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '40'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 17
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '3'
    , 'Reproduction'
    , 'Reproduction'
    , '50'
    , 31
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 18
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (18, 'No', 'No', 'Non observé', '99', 87, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 19, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (18, 'No', 'No', 'Non observé', '100', 87, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 20, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '2'
    , 'Coquilles d''œuf'
    , 'Coquilles d''œuf'
    , '12'
    , 43
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 21
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '8', 'Nid/Gîte', 'Nid/Gîte', '14', 49, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 22, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '8', 'Nid/Gîte', 'Nid/Gîte', '18', 49, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 23, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '8', 'Nid/Gîte', 'Nid/Gîte', '19', 49, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 24, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (9, '3', 'Mâle', 'Mâle', 'M', 169, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 25, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (9, '2', 'Femelle', 'Femelle', 'F', 168, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 26, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (9, '5', 'Mixte', 'Mixte', 'MF', 171, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 27, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (9, '0', 'Inconnu', 'Inconnu', 'U', 166, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 28, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 9
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'FT'
    , 167
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 29
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '1Y', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 30, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '1YP', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 31, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '2Y', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 32, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '3Y', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 33, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '4Y', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 34, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', '5Y', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 35, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '2', 'Adulte', 'Adulte', 'AD', 3, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 36, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '1'
    , 'Indéterminé'
    , 'Indéterminé'
    , 'ADYOUNG'
    , 2
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 37
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '7', 'Chenille', 'Chenille', 'CAT', 8, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 38, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '12'
    , 'Chrysalide'
    , 'Chrysalide'
    , 'CHRY'
    , 13
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 39
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '9', 'Œuf', 'Œuf', 'EGG', 10, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 40, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENT'
    , 26
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 41
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '11', 'Exuvie', 'Exuvie', 'EXUVIE', 12, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 42, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '15', 'Imago', 'Imago', 'IMAGO', 16, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 43, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '4', 'Immature', 'Immature', 'IMM', 5, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 44, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '3', 'Juvénile', 'Juvénile', 'JUVENILE', 4, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 45, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '6', 'Larve', 'Larve', 'LARVA', 7, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 46, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '2', 'Adulte', 'Adulte', 'MATURE', 3, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 47, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '3', 'Juvénile', 'Juvénile', 'PULL', 4, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 48, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '9', 'Œuf', 'Œuf', 'SPAWN', 10, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 49, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '5'
    , 'Sub-adulte'
    , 'Sub-adulte'
    , 'SUBAD'
    , 6
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 50
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '8', 'Têtard', 'Têtard', 'TETARD', 9, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 51, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '0', 'Inconnu', 'Inconnu', 'U', 1, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 52, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGBOLD'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 53
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (10, '3', 'Juvénile', 'Juvénile', 'YOUNGDEP', 4, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 54, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGFLYING'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 55
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '3'
    , 'Juvénile'
    , 'Juvénile'
    , 'YOUNGHAIRY'
    , 4
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 56
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '48'
    , 'Observation de larves (recherche de larves)'
    , 'Observation de larves (recherche de larves)'
    , 'LARVA'
    , 232
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 57
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '51'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'Observation de pontes (observation des œufs, recherche des pontes)'
    , 'SPAWN'
    , 235
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 58
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '56'
    , 'Observation d''exuvies'
    , 'Observation d''exuvies'
    , 'EXUVIE'
    , 240
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 59
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'MUMMIE'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 60
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'MUMMIE'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 61
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'MUMMIE'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 62
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 115
    , '9'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'Prélèvement (capture avec collecte d''échantillon) : capture-conservation'
    , 'COLLECTED'
    , 411
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 63
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'VIEW', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 64, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'VIEW'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 65
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '10'
    , 'Restes dans pelote de réjection'
    , 'Restes dans pelote de réjection'
    , 'PEL'
    , 51
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 66
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'VIDEO', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 169, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '14'
    , 'Examen visuel des restes de l’individu'
    , 'Examen visuel des restes de l’individu'
    , 'PEL'
    , 457
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 67
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '49'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'Observation de macro-restes (cadavres, élytres…)'
    , 'PEL'
    , 233
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 68
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '3'
    , 'Trouvé mort'
    , 'Trouvé mort'
    , 'PEL'
    , 159
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 69
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '21', 'Inconnu', 'Inconnu', 'U', 62, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 70, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '20'
    , 'Examen visuel sous loupe ou microscope'
    , 'Examen visuel sous loupe ou microscope'
    , 'MAGNIFYING'
    , 463
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 71
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'MAGNIFYING', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 72, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'DRYGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 73
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'DRYGUANO'
    , 460
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 74
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'DRYGUANO'
    , 241
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 75
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '21'
    , 'Examen visuel de l’individu en main'
    , 'Examen visuel de l’individu en main'
    , 'HAND'
    , 464
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 76
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'HAND', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 77, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'OUTSHELTER', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 78, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'OUTSHELTER'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 79
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'LAIDACTIV', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 87, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '3'
    , 'Ultrasons'
    , 'Ultrasons'
    , 'DETECT'
    , 44
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 88
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAIDACTIV'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 89
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAIDACTIV'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 90
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'DETECT'
    , 205
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 91
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'DETECT'
    , 350
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 92
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'DETECT'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 93
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '1', 'Entendu', 'Entendu', 'AUDIO', 42, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 94, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '9'
    , 'Examen auditif direct'
    , 'Examen auditif direct'
    , 'AUDIO'
    , 349
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 95
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'AUDIO'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 96
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '20', 'Autre', 'Autre', 'OTHER', 61, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 97, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'LAID'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 99
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'LAID'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 100
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '11'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'Examen des organes reproducteurs ou critères spécifiques en laboratoire'
    , 'LABO'
    , 351
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 101
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'LABO', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 102, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 13
    , '10'
    , 'Passage en vol'
    , 'Passage en vol'
    , 'FLY'
    , 38
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 103
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'FLY', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 104, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'FLY'
    , 461
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 105
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'FLY'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 106
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'RESCUE', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 107, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 7
    , '2'
    , 'Observé vivant'
    , 'Observé vivant'
    , 'RESCUE'
    , 158
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 108
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 115
    , '1'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'Observation directe : Vue, écoute, olfactive, tactile'
    , 'OLFACTIF'
    , 403
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 109
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '20', 'Autre', 'Autre', 'OLFACTIF', 61, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 110, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '6'
    , 'Fèces/Guano/Epreintes'
    , 'Fèces/Guano/Epreintes'
    , 'FRESHGUANO'
    , 47
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 111
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '17'
    , 'Examen direct des traces ou indices de présence'
    , 'Examen direct des traces ou indices de présence'
    , 'FRESHGUANO'
    , 460
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 112
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '57'
    , 'Observation d''indices de présence'
    , 'Observation d''indices de présence'
    , 'FRESHGUANO'
    , 241
    , '2019-12-12 12:57:53.904659'
    , '2019-12-16 12:01:47.861097'
    , 113
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'MUMMIE', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 114, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'COLLECTED', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 115, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'BONESREMAINS', 41, '2019-12-12 12:57:53.904659', '2019-12-16 12:01:47.861097', 116, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 10
    , '25'
    , 'Emergent'
    , 'Emergent'
    , 'EMERGENCE'
    , 26
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 147
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '4'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'Analyse ADN de l''individu ou de ses restes'
    , 'GENETIC'
    , 344
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 148
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'TRAP', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 149, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'TRAP'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 150
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '67'
    , 'Observation par piège photographique'
    , 'Observation par piège photographique'
    , 'TRAP'
    , 251
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 151
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '2'
    , 'Autre méthode de détermination'
    , 'Autre méthode de détermination'
    , 'OTHER'
    , 352
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 152
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'EYE', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 153, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 14
    , '25'
    , 'Vu et entendu'
    , 'Vu et entendu'
    , 'EYE_IDENTIFIED'
    , 66
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 154
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '21'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'Détection des ultrasons (écoute indirecte, analyse sonore, détection ultrasonore)'
    , 'EYE_IDENTIFIED'
    , 205
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 155
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '10'
    , 'Examen auditif avec transformation électronique'
    , 'Examen auditif avec transformation électronique'
    , 'EYE_IDENTIFIED'
    , 350
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 156
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'BINOCULARS', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 157, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'BINOCULARS'
    , 229
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 158
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'BINOCULARS'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 159
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'TELESCOPE', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 160, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 100
    , '45'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'Observation aux jumelles (observation à la longue-vue)'
    , 'TELESCOPE'
    , 229
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 161
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'TELESCOPE'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 162
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'NIGHT_VISION', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 163, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'NIGHT_VISION'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 164
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'THERMAL', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 165, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '18'
    , 'Examen visuel à distance'
    , 'Examen visuel à distance'
    , 'THERMAL'
    , 461
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 166
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (14, '0', 'Vu', 'Vu', 'PHOTO', 41, '2019-12-16 10:40:40.908147', '2019-12-16 12:01:47.861097', 167, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'PHOTO'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 168
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 106
    , '22'
    , 'Examen visuel sur photo ou vidéo'
    , 'Examen visuel sur photo ou vidéo'
    , 'VIDEO'
    , 465
    , '2019-12-16 10:40:40.908147'
    , '2019-12-16 12:01:47.861097'
    , 170
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (15, '1', 'Oui', 'Oui', 'TRAP', 82, '2019-12-16 10:43:47.532533', '2019-12-16 12:01:47.861097', 171, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (15, '1', 'Oui', 'Oui', 'PHOTO', 82, '2019-12-16 10:43:47.532533', '2019-12-16 12:01:47.861097', 172, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    (15, '1', 'Oui', 'Oui', 'VIDEO', 82, '2019-12-16 10:43:47.532533', '2019-12-16 12:01:47.861097', 173, 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'garden'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 174
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'municipality'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 175
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'place'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 176
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 177
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'polygone_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 178
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'square'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 179
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 180
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'subplace_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 181
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 182
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'In'
    , 'Inventoriel'
    , 'Inventoriel'
    , 'transect_precise'
    , 173
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 183
    , 2);
INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , label_default
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source)
    VALUES
    ( 3
    , 'St'
    , 'Stationnel'
    , 'Stationnel'
    , 'precise'
    , 175
    , '2019-12-16 11:16:44.597905'
    , '2019-12-16 12:01:47.861097'
    , 184
    , 2);

INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values)
    VALUES
    (101, '1', 'Certain - très probable', 'ACCEPTED', 318, now(), now(), 185, 2, json_build_object(
            'visionature_json_path',
            '{observers,0,committees_validation,chr}'));


INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values)
    VALUES
    (101, '1', 'Certain - très probable', 'ACCEPTED', 318, now(), now(), 186, 2, json_build_object(
            'visionature_json_path',
            '{observers,0,committees_validation,chn}'));


INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , cd_nomenclature
                                  , mnemonique
                                  , initial_value
                                  , id_nomenclature
                                  , meta_create_date
                                  , meta_update_date
                                  , id_synonyme
                                  , id_source
                                  , addon_values)
    VALUES
    (101, '1', 'Certain - très probable', 'ACCEPTED', 318, now(), now(), 187, 2, json_build_object('visionature_json_path',
                                                                                              '{observers,0,committees_validation,chr}'));