/*
  Manage observers from VisioNature observers datas
*/

CREATE INDEX i_t_roles_champ_addi_id_universal ON utilisateurs.t_roles ((champs_addi ->> 'id_universal'));

COMMENT
INDEX i_t_roles_champ_addi_id_universal ON utilisateurs.t_roles IS 'Index spécifique aux données observateurs de VisioNature';

/* Fonction to create observers if not already registered */

DROP FUNCTION IF EXISTS src_lpodatas.fct_create_observer_from_visionature(_item JSONB, _rq TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_create_observer_from_visionature(_item JSONB, _rq TEXT DEFAULT 'Utilisateur VisioNature') RETURNS INT
AS
$$
DECLARE
    theroleid INT ;
BEGIN
    IF (SELECT
            exists(SELECT
                       1
                       FROM
                           utilisateurs.t_roles
                       WHERE
                           champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal')) THEN
        IF (_item ->> 'name', _item ->> 'surname', _item ->> 'email') <> (SELECT
                                                                              nom_role
                                                                            , prenom_role
                                                                            , email
                                                                              FROM
                                                                                  utilisateurs.t_roles
                                                                              WHERE
                                                                                  champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal') THEN
            UPDATE utilisateurs.t_roles
            SET
                nom_role    = _item ->> 'name'
              , prenom_role = _item ->> 'surname'
              , email       = _item ->> 'email'
              , remarques   = _rq
                WHERE
                    champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal';
            RAISE NOTICE 'Observer % with email % updated', _item ->> 'id_universal', _item ->> 'email';
        END IF;
        SELECT
            id_role
            INTO theroleid
            FROM
                utilisateurs.t_roles
            WHERE
                champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal';
        RAISE NOTICE 'Observer % with email % already exists', _item ->> 'id_universal', _item ->> 'email';
    ELSE
        INSERT INTO
            utilisateurs.t_roles(nom_role, prenom_role, email, champs_addi, remarques, active, date_insert)
            VALUES
            (_item ->> 'name', _item ->> 'surname', _item ->> 'email', _item, _rq, FALSE, now())
            RETURNING id_role INTO theroleid;
        RAISE NOTICE 'Observer % inserted with id %', _item ->> 'id_universal', theroleid;
        RETURN theroleid;
    END IF;
    RETURN theroleid;
END
$$
    LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_create_observer_from_visionature(_item JSONB, _rq TEXT) IS 'créée ou mets à jour un observervateur à partir des entrées json VisioNature';

/* Function that returns id_role from VisioNature user universal id */

DROP FUNCTION IF EXISTS src_lpodatas.fct_get_id_role_from_visionature_uid(_uid TEXT);

CREATE FUNCTION src_lpodatas.fct_get_id_role_from_visionature_uid(_uid TEXT) RETURNS INT
AS
$$
DECLARE
    theroleid INT ;
BEGIN
    SELECT id_role INTO theroleid FROM utilisateurs.t_roles WHERE champs_addi ->> 'id_universal' = _uid;
    RETURN theroleid;
END
$$
    LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_get_id_role_from_visionature_uid(_uid TEXT) IS 'Retourne un id_role à partir d''un id_universal de visionature';


/* TESTS */


-- WITH
--     titem AS
--         (SELECT
--              jsonb_set(item, '{name}', '"test2"') AS item
--              FROM
--                  import_vn.observers_json
--              LIMIT 1)
--
-- SELECT
--     src_lpodatas.fct_create_observer_from_visionature(item)
--     FROM
--         titem;


-- WITH
--     titem AS
--         (SELECT
--              jsonb_set(item, '{name}', '"test2"') AS item
--              FROM
--                  import_vn.observers_json
--              LIMIT 1)
--
-- SELECT
--     src_lpodatas.fct_get_id_role_from_visionature_uid(item ->> 'id_universal')
--     FROM
--         titem;

/* Trigger pour peupler automatiquement la table t_roles à partir des entrées observateurs de VisioNature*/

CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_upsert_observer() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    PERFORM src_lpodatas.fct_create_observer_from_visionature(new.item);
    RETURN new;
END;
$$;

ALTER FUNCTION src_lpodatas.fct_tri_upsert_observer() OWNER TO geonature;

COMMENT ON FUNCTION src_lpodatas.fct_tri_upsert_observer() IS 'Function de trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature'

CREATE TRIGGER tri_upsert_synthese_extended
    AFTER INSERT OR UPDATE
    ON import_vn.observers_json
    FOR EACH ROW
EXECUTE PROCEDURE src_lpodatas.fct_tri_upsert_observer();

COMMENT ON TRIGGER tri_upsert_synthese_extended ON import_vn.observers_json IS 'Trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature'
