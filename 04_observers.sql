/*
 Manage observers from VisioNature observers datas
 */
CREATE INDEX IF NOT EXISTS i_t_roles_champ_addi_id_universal ON utilisateurs.t_roles ((champs_addi ->> 'id_universal'));


/* Fonction to create observers if not already registered */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_create_geonatadmin_observer_from_visionature (_item JSONB, _rq TEXT);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_create_geonatadmin_observer_from_visionature (_item jsonb, _rq text DEFAULT 'Utilisateur VisioNature')
    RETURNS int
    AS $$
DECLARE
    theroleid int;
BEGIN
    IF (
        SELECT
            EXISTS (
            SELECT
                1
            FROM
                utilisateurs.t_roles
            WHERE
                champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal')) THEN
        IF (_item ->> 'name',
            _item ->> 'surname',
            _item ->> 'email') <> (
    SELECT
        nom_role,
        prenom_role,
        email
    FROM
        utilisateurs.t_roles
    WHERE
        champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal') THEN
            UPDATE
                utilisateurs.t_roles v
            SET
                nom_role = _item ->> 'name',
                prenom_role = _item ->> 'surname',
                email = _item ->> 'email',
                remarques = _rq
            WHERE
                champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal';
            RAISE NOTICE 'Observer % with email % updated', _item ->> 'id_universal', _item ->> 'email';
        END IF;
        SELECT
            id_role INTO theroleid
        FROM
            utilisateurs.t_roles
        WHERE
            champs_addi ->> 'id_universal' LIKE _item ->> 'id_universal';
        RAISE NOTICE 'Observer % with email % already exists', _item ->> 'id_universal', _item ->> 'email';
    ELSE
        INSERT INTO utilisateurs.t_roles (nom_role, prenom_role, email, champs_addi, remarques, active, date_insert)
            VALUES (_item ->> 'name', _item ->> 'surname', _item ->> 'email', _item, _rq, FALSE, now())
        RETURNING
            id_role INTO theroleid;
        RAISE NOTICE 'Observer % inserted with id %', _item ->> 'id_universal', theroleid;
        RETURN theroleid;
    END IF;
    RETURN theroleid;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_create_geonatadmin_observer_from_visionature (_item JSONB, _rq TEXT) IS 'créée ou mets à jour un observervateur à partir des entrées json VisioNature';


/* Function that returns id_role from VisioNature user universal id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_id_role_from_visionature_uid (_uid TEXT);

CREATE FUNCTION src_lpodatas.fct_c_get_id_role_from_visionature_uid (_uid text)
    RETURNS int
    AS $$
DECLARE
    theroleid int;
BEGIN
    SELECT
        id_role INTO theroleid
    FROM
        utilisateurs.t_roles
    WHERE
        champs_addi ->> 'id_universal' = _uid;
    RETURN theroleid;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_role_from_visionature_uid (_uid TEXT) IS 'Retourne un id_role à partir d''un id_universal de visionature';


/* TESTS */
-- WITH
--     titem AS
--         (SELECT
--              jsonb_set(item, '{name}', '"test2"') AS item
--              FROM
--                  src_vn_json.observers_json
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
--                  src_vn_json.observers_json
--              LIMIT 1)
--
-- SELECT
--     src_lpodatas.fct_get_id_role_from_visionature_uid(item ->> 'id_universal')
--     FROM
--         titem;
/* Trigger pour peupler automatiquement la table t_roles à partir des entrées observateurs de VisioNature*/
DROP TRIGGER IF EXISTS tri_upsert_synthese_extended ON src_vn_json.observers_json;

DROP FUNCTION IF EXISTS src_lpodatas.fct_tri_c_vn_observers_to_g ();

CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_geonature ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM
        src_lpodatas.fct_c_create_geonatadmin_observer_from_visionature (NEW.item);
    RETURN new;
END;
$$;

ALTER FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_geonature () OWNER TO geonatadmin;

COMMENT ON FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_geonature () IS 'Function de trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature';

CREATE TRIGGER tri_upsert_vn_observers_to_geonature
    AFTER INSERT OR UPDATE ON src_vn_json.observers_json
    FOR EACH ROW
    EXECUTE PROCEDURE src_lpodatas.fct_tri_c_vn_observers_to_geonature ();

COMMENT ON TRIGGER tri_upsert_vn_observers_to_geonature ON src_vn_json.observers_json IS 'Trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature'
