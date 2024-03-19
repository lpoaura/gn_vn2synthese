/*
OBSERVERS
---------
Various functions to import and get observers into UsersHub tables from VisioNature
*/


BEGIN;

DROP INDEX IF EXISTS utilisateurs.i_t_roles_champ_addi_id_universal;

CREATE INDEX IF NOT EXISTS i_t_roles_champ_addi_id_universal ON utilisateurs.t_roles (
    (champs_addi #>> '{from_vn, id_universal}')
);

CREATE UNIQUE INDEX IF NOT EXISTS i_uniq_t_roles_email ON utilisateurs.t_roles (
    email
);


CREATE OR REPLACE FUNCTION public.jsonb_arr_record_keys(JSONB)
RETURNS TEXT []
LANGUAGE sql
IMMUTABLE AS
'SELECT array(
                SELECT DISTINCT
                    k
                FROM jsonb_array_elements($1) elem
                   , jsonb_object_keys(elem) k
        )';

COMMENT ON FUNCTION public.jsonb_arr_record_keys(JSONB) IS '
   Generates text array of unique keys in jsonb array of records.
   Fails if any array element is not a record!';


/* Fonction to create observers if not already registered */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_create_usershub_roles_from_visionature(
    _site VARCHAR, _item JSONB, _rq TEXT
);
CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_create_usershub_roles_from_visionature(
    _site CHARACTER VARYING, _item JSONB,
    _rq TEXT DEFAULT 'Utilisateur VisioNature'::TEXT
) RETURNS INTEGER
LANGUAGE plpgsql
AS
$$
DECLARE
    therolerecord RECORD;
    theorganismid INT;
BEGIN
    /* PROCESS
       -------
       Si id_universal, alors on récupère l'utilisateur et on fait une MaJ
       Si pas d'id_universal mais mail.

       */

    -- Si l'utilisateur existe déjà (via id_universal VisioNature)
    -- Si id_entity existe dans la donnée source, alors on vérifie que la donnée et est identique dans UsersHub, sinon on la créée ou met à jour
    -- Sinon on créée l'utilisateur.
    IF (SELECT exists(SELECT 1
                      FROM utilisateurs.t_roles
                      WHERE t_roles.champs_addi #>> '{from_vn,id_universal}' LIKE _item ->> 'id_universal')) THEN
        SELECT *
        INTO therolerecord
        FROM utilisateurs.t_roles
        WHERE t_roles.champs_addi #>> '{from_vn,id_universal}' LIKE _item ->> 'id_universal';
        --         RAISE NOTICE 'from_vn exists %',therolerecord.champs_addi ? 'from_vn';
--         RAISE NOTICE 'id_universal exists %',therolerecord.champs_addi #> '{from_vn}' ? 'id_universal';
--         RAISE NOTICE 'from_vn or id_univorsal %',(therolerecord.champs_addi ? 'from_vn' OR
--                                                   therolerecord.champs_addi #> '{from_vn}' ? 'id_universal');
--         IF NOT (therolerecord.champs_addi ? 'from_vn' OR therolerecord.champs_addi #> '{from_vn}' ? 'id_universal') THEN
--             RAISE DEBUG 'Create site % key within "from_vn" for role %', _site,therolerecord.id_role;
--             UPDATE utilisateurs.t_roles
--             SET
--                 champs_addi = jsonb_set(champs_addi, ('{from_vn,id_universal}')::TEXT[], _item -> 'id_universal', TRUE)
--                 WHERE
--                     id_role = therolerecord.id_role;
--         END IF;
        -- Si utilisateur (via email) mais que la valeur id_universal n'est pas renseignée.
        -- Si nom/prenom/email est différent de ce qui est stocké alors ok sinon on update le mail et les noms

        IF (_item ->> 'name' <> therolerecord.nom_role OR
            _item ->> 'surname' <> therolerecord.prenom_role OR
            _item ->> 'anonymous' <> therolerecord.champs_addi #>> '{from_vn,anonymous}'
--             OR _item ->> 'email' <> therolerecord.email
            )
        THEN
            RAISE DEBUG 'Observer % with email % already exists', _item ->> 'id_universal', _item ->> 'email';
            RAISE DEBUG '_item %', (_item ->> 'name',
                                    _item ->> 'surname',
                                    _item ->> 'email');
            RAISE DEBUG 'therecord %', (therolerecord.nom_role, therolerecord.prenom_role, therolerecord.email);
            UPDATE
                utilisateurs.t_roles v
            SET nom_role    = _item ->> 'name'
              , prenom_role = _item ->> 'surname'
              , champs_addi = jsonb_set(champs_addi, '{from_vn,anonymous}'::TEXT[], _item -> 'anonymous', TRUE)
--               , email       = _item ->> 'email'
              , remarques   = _rq
            WHERE id_role = therolerecord.id_role;
            RAISE DEBUG 'Observer % with email % updated', _item ->> 'id_universal', _item ->> 'email';
        END IF;
        -- Si la donnée source contient une entité, on tente vérifie si elle existe déjà dans usershub
        IF (_item ? 'id_entity')
        THEN
            -- Si from_vn contient déjà un rattachement à une entité pour le site
            SELECT src_lpodatas.fct_c_get_organisme_from_vn_id(_site, _item ->> 'id_entity')
            INTO theorganismid;
            RAISE DEBUG '<ID ORGANISM> is % | % | % ', _site, _item ->> 'id_entity', theorganismid;
            IF (therolerecord.id_organisme IS NULL OR
                (therolerecord.id_organisme IS NOT NULL AND therolerecord.id_organisme != theorganismid))
            THEN
                UPDATE utilisateurs.t_roles SET id_organisme = theorganismid WHERE id_role = therolerecord.id_role;
            END IF;
            IF NOT (therolerecord.champs_addi #> '{from_vn}' ? _site) THEN
                RAISE DEBUG 'Create site % key within "from_vn" for role %', _site,therolerecord.id_role;
                UPDATE utilisateurs.t_roles
                SET champs_addi = jsonb_set(t_roles.champs_addi, ('{from_vn,' || _site || '}')::TEXT[], '{}'::JSONB,
                                            TRUE)
                WHERE id_role = therolerecord.id_role;
            END IF;
            IF NOT (therolerecord.champs_addi #> ('{from_vn,' || _site || '}')::TEXT[] ? 'id_entity') OR
               ((therolerecord.champs_addi #> ('{from_vn,' || _site || '}')::TEXT[] ? 'id_entity') AND
                (therolerecord.champs_addi #>> ('{from_vn,' || _site || ',id_entity}')::TEXT[] !=
                 _item ->> 'id_entity'))
            THEN
                RAISE DEBUG 'create or update id_entity % for site % for user % with email %', _item ->> 'id_entity', _site, _item ->> 'id_universal', _item ->> 'email';
                UPDATE utilisateurs.t_roles
                SET champs_addi = jsonb_set(t_roles.champs_addi, ('{from_vn,' || _site || ', id_entity}')::TEXT[],
                                            _item -> 'id_entity',
                                            TRUE)
                WHERE id_role = therolerecord.id_role;
            ELSE
                RAISE DEBUG 'id_entity % for site % and user % with email % already exists', _item ->> 'id_entity', _site, _item ->> 'id_universal', _item ->> 'email';
            END IF;


        END IF;
        RAISE DEBUG 'Observer % with email % already exists', _item ->> 'id_universal', _item ->> 'email';
        IF _item ->> 'anonymous' <> therolerecord.champs_addi #>> '{from_vn,anonymous}' THEN
            PERFORM src_lpodatas.fct_c_update_user_observations(_item #>> '{id_universal}');
        END IF;
    ELSE
        INSERT INTO utilisateurs.t_roles (nom_role, prenom_role, email, champs_addi, remarques, active, date_insert)
        VALUES ( _item ->> 'name'
               , _item ->> 'surname'
               , _item ->> 'email'
               , jsonb_build_object(
                         'from_vn',
                         jsonb_build_object(
                                 _site,
                                 jsonb_build_object(
                                         'id_entity',
                                         _item ->>
                                         'id_entity'),
                                 'id_universal',
                                 _item ->>
                                 'id_universal',
                                 'anonymous',
                                 _item ->>
                                 'anonymous'))
               , _rq
               , FALSE
               , now())
        ON CONFLICT (email)
            DO UPDATE SET nom_role    = _item ->> 'name'
                        , prenom_role = _item ->> 'surname'
                        , champs_addi = jsonb_set(t_roles.champs_addi, '{from_vn}',
                                                  jsonb_build_object(
                                                          _site,
                                                          jsonb_build_object(
                                                                  'id_entity',
                                                                  _item ->>
                                                                  'id_entity'), 'id_universal',
                                                          _item ->>
                                                          'id_universal',
                                                          'anonymous',
                                                          _item ->>
                                                          'anonymous'))
                        , remarques   = _rq
        RETURNING id_role INTO therolerecord;
        RAISE DEBUG 'Observer % inserted with id %', _item ->> 'id_universal', therolerecord.id_role;
        RETURN therolerecord.id_role;
    END IF;
    RETURN therolerecord.id_role;
END
$$;



COMMENT ON FUNCTION src_lpodatas.fct_c_create_usershub_roles_from_visionature(
    _site VARCHAR, _item JSONB, _rq TEXT
) IS 'créée ou mets à jour un observervateur à partir des entrées json VisioNature';


/* Function that returns id_role from VisioNature user universal id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_id_role_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL
);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_id_role_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL DEFAULT FALSE
)
RETURNS INT
AS
$$
DECLARE
    the_roleid INT;
BEGIN
    SELECT INTO the_roleid CASE
                               WHEN (_check_anonymous AND t_roles.champs_addi #>> '{from_vn,anonymous}' = '1')
                                   THEN NULL
                               ELSE
                                   t_roles.id_role END
    FROM utilisateurs.t_roles
    WHERE champs_addi #>> '{from_vn,id_universal}' = _uid;
    RETURN the_roleid;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_id_role_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL
) IS 'Retourne un id_role à partir d''un id_universal de visionature';


/* Function that returns id_role from VisioNature user universal id */
DROP FUNCTION IF EXISTS src_lpodatas.fct_c_get_role_name_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL
);

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_get_role_name_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL DEFAULT FALSE
)
RETURNS TEXT
AS
$$
DECLARE
    the_rolename TEXT;
BEGIN
    SELECT INTO the_rolename CASE
                                 WHEN (_check_anonymous AND t_roles.champs_addi #>> '{from_vn,anonymous}' = '1')
                                     THEN 'Anonyme'
                                 ELSE
                                     trim(concat(nom_role, ' ', prenom_role)) END
    FROM utilisateurs.t_roles
    WHERE champs_addi #>> '{from_vn,id_universal}' = _uid;
    RETURN the_rolename;
END
$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION src_lpodatas.fct_c_get_role_name_from_visionature_uid(
    _uid TEXT, _check_anonymous BOOL
) IS 'Retourne un id_role à partir d''un id_universal de visionature';



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


DROP TRIGGER IF EXISTS tri_upsert_vn_observers_to_geonature ON src_vn_json.observers_json;



CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_usershub()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
    PERFORM
        src_lpodatas.fct_c_create_usershub_roles_from_visionature(new.site, new.item);
    RETURN new;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_usershub() IS 'Function de trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature';

CREATE TRIGGER tri_upsert_vn_observers_to_geonature
AFTER INSERT OR UPDATE
ON src_vn_json.observers_json
FOR EACH ROW
EXECUTE FUNCTION src_lpodatas.fct_tri_c_vn_observers_to_usershub();

COMMENT ON TRIGGER tri_upsert_vn_observers_to_geonature ON src_vn_json.observers_json IS 'Trigger permettant de peupler automatiquement la table des observateurs utilisateurs.t_roles à partir des données VisioNature';

COMMIT;
