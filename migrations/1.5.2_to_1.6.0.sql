BEGIN;
ALTER TABLE src_lpodatas.t_c_synthese_extended
    ADD COLUMN comment_form TEXT;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.comment_form IS 'Commentaire du formulaire';

CREATE OR REPLACE FUNCTION src_lpodatas.fct_c_create_usershub_roles_from_visionature(_site CHARACTER VARYING, _item jsonb,
                                                                          _rq TEXT DEFAULT 'Utilisateur VisioNature'::TEXT) RETURNS INTEGER
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
    IF (SELECT EXISTS(SELECT 1
                      FROM utilisateurs.t_roles
                      WHERE t_roles.champs_addi #>> '{from_vn,id_universal}' LIKE _item ->> 'id_universal')) THEN
        SELECT *
        INTO therolerecord
        FROM utilisateurs.t_roles
        WHERE t_roles.champs_addi #>> '{from_vn,id_universal}' LIKE _item ->> 'id_universal';
        -- Si utilisateur (via email) mais que la valeur id_universal n'est pas renseignée.
        -- Si nom/prenom/email/statut anonymous_in_export est différent de ce qui est stocké alors ok sinon on update le mail et les noms

        IF (_item ->> 'name' <> therolerecord.nom_role OR
            _item ->> 'surname' <> therolerecord.prenom_role OR
            _item ->> 'anonymous' <> therolerecord.champs_addi #>> '{from_vn,anonymous}' OR
            TO_JSONB((_item ->> 'anonymous_in_export') = 'anonymous'::TEXT) !=
            COALESCE(therolerecord.champs_addi #> '{from_vn,anonymous_in_export}', TO_JSONB(TRUE))
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
              , champs_addi = JSONB_SET(
                    COALESCE(champs_addi, '{}'::jsonb),
                    '{from_vn}',
                    COALESCE(champs_addi -> 'from_vn', '{}'::jsonb)
                        || JSONB_BUILD_OBJECT(
                            'anonymous_in_export',
                            TO_JSONB((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT),
                            'anonymous_in_export_ts_update',
                            CASE
                                WHEN (
                                    COALESCE(
                                            (champs_addi #>> '{from_vn,anonymous_in_export}')::BOOLEAN,
                                            FALSE
                                    ) IS DISTINCT FROM COALESCE((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT, FALSE)
                                    )
                                    THEN TO_JSONB(NOW())
                                ELSE COALESCE(
                                        champs_addi #> '{from_vn,anonymous_in_export_ts_update}',
                                        TO_JSONB(NOW())
                                     )
                                END
                           ),
                    TRUE
                              )

                /*JSONB_SET(
                  JSONB_SET(champs_addi, '{from_vn,anonymous}'::TEXT[], _item -> 'anonymous', TRUE),
                  '{from_vn,anonymous_in_export}'::TEXT[],
                  TO_JSONB((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT),
                  TRUE)*/
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
                SET champs_addi = JSONB_SET(t_roles.champs_addi, ('{from_vn,' || _site || '}')::TEXT[], '{}'::jsonb,
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
                SET champs_addi = JSONB_SET(t_roles.champs_addi, ('{from_vn,' || _site || ', id_entity}')::TEXT[],
                                            _item -> 'id_entity',
                                            TRUE)
                WHERE id_role = therolerecord.id_role;
            ELSE
                RAISE DEBUG 'id_entity % for site % and user % with email % already exists', _item ->> 'id_entity', _site, _item ->> 'id_universal', _item ->> 'email';
            END IF;


        END IF;
        RAISE DEBUG 'Observer % with email % already exists', _item ->> 'id_universal', _item ->> 'email';
        IF _item ->> 'anonymous' <> therolerecord.champs_addi #>> '{from_vn,anonymous}'
            OR TO_JSONB(_item ->> 'anonymous_in_export' = 'anonymize'::TEXT) !=
               COALESCE(therolerecord.champs_addi #> '{from_vn,anonymous_in_export}', TO_JSONB(TRUE))
        THEN
            PERFORM src_lpodatas.fct_c_update_user_observations(_item #>> '{id_universal}');
        END IF;
    ELSE
        INSERT INTO utilisateurs.t_roles ( nom_role, prenom_role, email, id_organisme, champs_addi, remarques, active
                                         , date_insert)
        VALUES ( _item ->> 'name'
               , _item ->> 'surname'
               , _item ->> 'email'
               , src_lpodatas.fct_c_get_organisme_from_vn_id(_site, _item ->> 'id_entity')
               , JSONB_BUILD_OBJECT(
                         'from_vn',
                         JSONB_BUILD_OBJECT(
                                 _site,
                                 JSONB_BUILD_OBJECT('id_entity', _item ->> 'id_entity'),
                                 'id_universal', _item ->> 'id_universal',
                                 'anonymous', _item ->> 'anonymous',
                                 'anonymous_in_export',
                                 TO_JSONB((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT),
                                 'anonymous_in_export_ts_update',
                                 TO_JSONB(NOW())
                         ))
               , _rq
               , FALSE
               , NOW())
        ON CONFLICT (email)
            DO UPDATE SET nom_role     = _item ->> 'name'
                        , prenom_role  = _item ->> 'surname'
                        , id_organisme = src_lpodatas.fct_c_get_organisme_from_vn_id(_site, _item ->> 'id_entity')
                        , champs_addi  = JSONB_SET(
                    COALESCE(t_roles.champs_addi, '{}'::jsonb),
                    '{from_vn}',
                    COALESCE(t_roles.champs_addi -> 'from_vn', '{}'::jsonb)
                        || JSONB_BUILD_OBJECT(
                            'anonymous_in_export',
                            TO_JSONB((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT),
                            'anonymous_in_export_ts_update',
                            CASE
                                WHEN (
                                    COALESCE(
                                            (t_roles.champs_addi #>> '{from_vn,anonymous_in_export}')::BOOLEAN,
                                            TRUE
                                    ) IS DISTINCT FROM COALESCE((_item ->> 'anonymous_in_export') = 'anonymize'::TEXT, TRUE)
                                    )
                                    THEN TO_JSONB(NOW())
                                ELSE COALESCE(
                                        t_roles.champs_addi #> '{from_vn,anonymous_in_export_ts_update}',
                                        TO_JSONB(NOW())
                                     )
                                END
                           ),
                    TRUE
                                         )
                        , remarques    = _rq
        RETURNING id_role INTO therolerecord;
        RAISE DEBUG 'Observer % inserted with id %', _item ->> 'id_universal', therolerecord.id_role;
        RETURN therolerecord.id_role;
    END IF;
    RETURN therolerecord.id_role;
END
$$;

CREATE OR REPLACE FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    /* Log duration informations variables */
    start_ts                                 TIMESTAMP;

    /* common_data */
    the_id_synthese                          INTEGER;

    /* gn_synthese.synthese data */
    the_unique_id_sinp                       uuid;
    the_unique_id_sinp_grp                   uuid;
    the_comment_form                         TEXT;
    the_id_source                            INTEGER;
    the_entity_source_pk_value               VARCHAR;
    the_id_dataset                           INTEGER;
    the_id_nomenclature_geo_object_nature    INTEGER;
    the_id_nomenclature_grp_typ              INTEGER;
    the_id_nomenclature_obs_technique        INTEGER;
    the_id_nomenclature_bio_status           INTEGER;
    the_id_nomenclature_bio_condition        INTEGER;
    the_id_nomenclature_naturalness          INTEGER;
    the_id_nomenclature_exist_proof          INTEGER;
    the_id_nomenclature_valid_status         INTEGER;
    the_id_nomenclature_diffusion_level      INTEGER;
    the_id_nomenclature_life_stage           INTEGER;
    the_id_nomenclature_sex                  INTEGER;
    the_id_nomenclature_obj_count            INTEGER;
    the_id_nomenclature_type_count           INTEGER;
    the_id_nomenclature_sensitivity          INTEGER;
    the_id_nomenclature_observation_status   INTEGER;
    the_id_nomenclature_blurring             INTEGER;
    the_id_nomenclature_source_status        INTEGER;
    the_id_nomenclature_info_geo_type        INTEGER;
    the_count_min                            INTEGER;
    the_count_max                            INTEGER;
    the_cd_nom                               INTEGER;
    -- TODO Pour les non match, cd_nom de Animalia
    the_nom_cite                             VARCHAR;
    the_meta_v_taxref                        VARCHAR;
    the_sample_number_proof                  VARCHAR;
    the_digital_proof                        VARCHAR;
    the_non_digital_proof                    VARCHAR;
    the_altitude_min                         INTEGER;
    the_altitude_max                         INTEGER;
    _the_geom_4326                           public.geometry(Geometry, 4326);
    _the_geom_point                          public.geometry(POINT, 4326);
    _the_geom_local                          public.geometry(Geometry, 2154);
    the_date_min                             TIMESTAMP;
    the_date_max                             TIMESTAMP;
    the_validation_comment                   TEXT;
    the_observers                            TEXT;
    the_observers_extended                   TEXT;
    the_determiner                           TEXT;
    the_id_digitiser                         INTEGER;
    the_id_nomenclature_determination_method INTEGER;
    the_comments                             TEXT;
    the_reference_biblio                     VARCHAR(255);

    /* t_c_synthese_extended data */
    --     the_observation_detail                   JSONB;
    the_id_sp_source                         INTEGER;
    the_taxo_group                           VARCHAR(50);
    the_taxo_real                            BOOLEAN;
    -- TODO plus tard; taxon vrai uniquement si rang IN ('ES';'SSES')
    the_common_name                          VARCHAR(250);
    the_pseudo_observer_uid                  VARCHAR(200);
    -- TODO Renseigner avec la fonction actuelle
    the_bird_breed_code                      INTEGER;
    the_breed_status                         VARCHAR(20);
    the_bat_breed_colo                       BOOLEAN;
    the_bat_is_gite                          BOOLEAN;
    the_bat_period                           VARCHAR(20);
    the_estimation_code                      VARCHAR(50);
    the_date_year                            INTEGER;
    the_mortality                            BOOLEAN;
    the_mortality_cause                      VARCHAR(250);
    the_export_excluded                      BOOLEAN;
    the_project_code                         VARCHAR(250);
    the_juridical_person                     VARCHAR(100);
    the_behaviour                            TEXT[];
    the_geo_accuracy                         VARCHAR(50);
    the_details                              jsonb;
    the_id_place                             INT;
    the_place                                VARCHAR(250);
    the_id_form                              VARCHAR(20);
    the_is_valid                             BOOLEAN;
    the_private_comment                      TEXT;
    the_is_hidden                            BOOLEAN DEFAULT FALSE;
BEGIN
    SELECT CLOCK_TIMESTAMP() INTO start_ts;
    RAISE DEBUG '-- % -- START SCRIPT' , start_ts;
    RAISE DEBUG '-- % -- Populate variables > Beginning' , start_ts;
    SELECT CAST(new.item #>> '{species,@id}' AS INTEGER) INTO the_id_sp_source;


    /* Partie gn_synthese.synthese */
    SELECT COALESCE(CAST(new.item #>> '{observers,0,uuid}' AS uuid),
                    src_lpodatas.fct_c_get_observation_uuid(new.site, new.id))
    INTO
        the_unique_id_sinp;
    RAISE DEBUG 'UUID is %' , the_unique_id_sinp;
    SELECT uuid
         , (item ->> 'comment')::TEXT
    INTO the_unique_id_sinp_grp, the_comment_form
    FROM src_vn_json.forms_json
    WHERE (new.site, (new.item #>> '{observers,0,id_form}')::INT) = (forms_json.site,
                                                                     forms_json.id);
    SELECT src_lpodatas.fct_c_upsert_or_get_source_from_visionature(new.site)
    INTO the_id_source;
    SELECT new.id::TEXT INTO the_entity_source_pk_value;
    SELECT src_lpodatas.fct_c_get_id_role_from_visionature_uid(new.item #>>
                                                               '{observers,0,@uid}', TRUE)
    INTO the_id_digitiser;
    SELECT public.st_setsrid(public.st_makepoint(CAST(((new.item ->
                                                        'observers') -> 0) ->> 'coord_lon' AS FLOAT), CAST(((new.item
        -> 'observers') -> 0) ->> 'coord_lat' AS FLOAT)), 4326)
    INTO
        _the_geom_4326;
    SELECT TO_TIMESTAMP(CAST(new.item #>> '{observers,0,timing,@timestamp}' AS DOUBLE PRECISION))
    INTO the_date_min;
    SELECT the_date_min INTO the_date_max;
    SELECT CAST(COALESCE(src_lpodatas.fct_c_get_taxref_values_from_vn
                         ('cd_nom'::TEXT, CAST(new.item #>> '{species,@id}' AS INTEGER))
        , gn_commons.get_default_parameter('visionature_default_cd_nom', NULL)) AS
               INTEGER)
    INTO the_cd_nom;
    SELECT CAST(new.item #>> '{observers,0,atlas_code}' AS INTEGER) INTO the_bird_breed_code;
    IF
        /* if project_code > dataset from project code */
        new.item #> '{observers,0}' ? 'project_code' THEN
        SELECT src_lpodatas.fct_c_get_or_insert_dataset_from_shortname
               (new.item #>> '{observers,0,project_code}', 'visionature_default_dataset',
                'visionature_default_acquisition_framework')
        INTO the_id_dataset;
    ELSE
        SELECT COALESCE( /* if observer in organism > organism default dataset */
                       src_lpodatas.fct_c_get_dataset_from_observer_uid(new.item #>>
                                                                        '{observers,0,@uid}'), /* else if sympetrum data > dataset LPO_SYMPETRUM*/
                       CASE
                           WHEN (st_intersects
                                 (_the_geom_4326, src_lpodatas.fct_get_geom_from_relation_name
                                                  ('ref_geo.mv_c_sympetrum_cover'))
                               AND new.item #>> '{species,taxonomy}' = '8') THEN
                               src_lpodatas.fct_c_get_or_insert_dataset_from_shortname_with_af_id('LPO_SYMPETRUM', NULL,
                                                                                                  src_lpodatas.fct_c_get_or_insert_basic_acquisition_framework(
                                                                                                          'LPO_SYMPETRUM',
                                                                                                          'CA LPO-SYMPETRUM',
                                                                                                          NOW()::DATE))
                           ELSE
                               /* else default dataset */
                               src_lpodatas.fct_c_get_or_insert_dataset_from_shortname
                               (NULL, 'visionature_default_dataset', 'visionature_default_acquisition_framework')
                           END)
        INTO the_id_dataset;
    END IF;
    SELECT ref_nomenclatures.fct_c_get_synonyms_nomenclature('NAT_OBJ_GEO',
                                                             new.item #>> '{observers,0,precision}')
    INTO
        the_id_nomenclature_geo_object_nature;
    SELECT gn_synthese.get_default_nomenclature_value
           ('TYP_GRP'::CHARACTER VARYING)
    INTO the_id_nomenclature_grp_typ;
    -- SELECT gn_synthese.get_default_nomenclature_value('METH_OBS') INTO
    --	      the_id_nomenclature_obs_meth;
    --
    --	  ref_nomenclatures.fct_c_get_synonyms_nomenclature('METH_OBS',
    --
    -- new.item
    --     #>>
    --	      '{observers,0,details,0,condition}')
    SELECT ref_nomenclatures.get_id_nomenclature('METH_OBS',
                                                 '21')
    INTO the_id_nomenclature_obs_technique;
    --	 coalesce(
    --
    --
    -- ref_nomenclatures.fct_c_get_synonyms_nomenclature('TECHNIQUE_OBS',
    --
    --	 new.item
    --	     #>>
    --	      '{observers,0,details,0,condition}'),
    --
    --
    -- ref_nomenclatures.fct_c_get_synonyms_nomenclature('TECHNIQUE_OBS',
    --
    --	 new.item
    --	     #>>
    --	      '{observers,0,details,0,age}'))
    --		   SELECT
    --      gn_synthese.get_default_nomenclature_value('STATUT_BIO')
    --	   INTO
    --	      the_id_nomenclature_bio_status;
    SELECT CASE
               WHEN ((new.item #>> '{observers,0,count}' = '0'
                   AND new.item #>> '{observers,0,estimation_code}' LIKE 'EXACT_VALUE')
                   OR (new.item #>> '{observers,0,atlas_code}' = '99')) THEN
                   ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
               ELSE
                   ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'Pr')
               END
    INTO the_id_nomenclature_observation_status;
    SELECT COALESCE(
                   COALESCE(
                           COALESCE(
                               -- Biologic status deducted from atlas code
                                   ref_nomenclatures.fct_c_get_synonyms_nomenclature('STATUT_BIO', new.item #>>
                                                                                                   '{observers,0,atlas_code}'),
                                   CASE
                                       -- Biologic status deducted from breeding status
                                       WHEN
                                           src_lpodatas.fct_c_get_reproduction_status((new.item #>>
                                                                                       '{species,taxonomy}')::INT,
                                                                                      new.item) IN
                                           ('Possible', 'Probable', 'Certain') THEN
                                           ref_nomenclatures.get_id_nomenclature('STATUT_BIO', '3')
                                       END), ref_nomenclatures.fct_c_get_synonyms_nomenclature
                                             ('STATUT_BIO', new.item #>> '{observers,0,details,0,condition}')),
                   ref_nomenclatures.get_id_nomenclature('STATUT_BIO'
                       , '1'))
    INTO
        the_id_nomenclature_bio_status;
    SELECT CASE
               WHEN new.item #> '{observers,0,extended_info}' ? 'mortality' THEN
                   ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3')
               WHEN the_id_nomenclature_observation_status =
                    ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
                   THEN
                   ref_nomenclatures.get_id_nomenclature('ETA_BIO'
                       , '1')
               ELSE
                   ref_nomenclatures.get_id_nomenclature('ETA_BIO', '2')
               END
    INTO the_id_nomenclature_bio_condition;
    SELECT ref_nomenclatures.get_id_nomenclature('NATURALITE',
                                                 '0')
    INTO the_id_nomenclature_naturalness;
    SELECT CASE
               WHEN new.item #> '{observers,0}' ? 'medias' THEN
                   ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '1')
               ELSE
                   ref_nomenclatures.get_id_nomenclature('PREUVE_EXIST', '2')
               END
    INTO the_id_nomenclature_exist_proof;
    SELECT
        -- When chr or chn accepted then certain, when admin_hidden then is douteux else
        --	      probable.
        CASE
            WHEN src_lpodatas.fct_c_get_committees_validation_is_accepted
                 (new.item #> '{observers,0,committees_validation}') THEN
                ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '1')
            WHEN CAST(new.item #>> '{observers,0,admin_hidden}' AS BOOLEAN)
                OR -- TRUE si soumis à validation
                 NOT src_lpodatas.fct_c_get_committees_validation_is_accepted
                     (new.item #> '{observers,0,committees_validation}') -- TRUE si
                THEN
                ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '3')
            ELSE
                ref_nomenclatures.get_id_nomenclature('STATUT_VALID', '2')
            END
    INTO the_id_nomenclature_valid_status;
    SELECT src_lpodatas.fct_c_get_diffusion_level(the_cd_nom, the_date_min,
                                                  the_bird_breed_code, new.item)
    INTO
        the_id_nomenclature_diffusion_level;
    SELECT
        --
        -- coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature('STADE_VIE',
        --								    new.item
        -- #>> '{observers,0,details,0,age}'),
        --		   gn_synthese.get_default_nomenclature_value('STADE_VIE'))
        ref_nomenclatures.get_id_nomenclature('STADE_VIE',
                                              '0')
    INTO the_id_nomenclature_life_stage;
    SELECT ref_nomenclatures.get_id_nomenclature('SEXE',
                                                 '0')
    INTO the_id_nomenclature_sex;
    SELECT ref_nomenclatures.get_id_nomenclature('OBJ_DENBR',
                                                 'IND')
    INTO the_id_nomenclature_obj_count;
    SELECT
        --	 ref_nomenclatures.fct_c_get_synonyms_nomenclature('STADE_VIE',
        --	      new.item #>> '{observers,0,estimation_code}')
        ref_nomenclatures.get_id_nomenclature('TYP_DENBR',
                                              'ind')
    INTO the_id_nomenclature_type_count;
    SELECT CASE
               WHEN CAST(new.item #>> '{observers,0,hidden}' AS BOOLEAN) THEN
                   ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '2')
               ELSE
                   ref_nomenclatures.get_id_nomenclature('SENSIBILITE', '0')
               END
    INTO the_id_nomenclature_sensitivity;

    SELECT ref_nomenclatures.get_id_nomenclature('DEE_FLOU',
                                                 'NON')
    INTO the_id_nomenclature_blurring;
    SELECT ref_nomenclatures.get_id_nomenclature('STATUT_SOURCE',
                                                 'Te')
    INTO the_id_nomenclature_source_status;
    SELECT ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO', '1')
    --SELECT coalesce(ref_nomenclatures.fct_c_get_synonyms_nomenclature(
    --	       'TYP_INF_GEO',
    --	       new.item #>> '{observers,0,precision}'),
    --	      ref_nomenclatures.get_id_nomenclature('TYP_INF_GEO',
    --	  '2'))s
    INTO the_id_nomenclature_info_geo_type;
    SELECT CAST(new.item #>> '{observers,0,count}' AS INTEGER) INTO the_count_min;
    SELECT CAST(new.item #>> '{observers,0,count}' AS INTEGER) INTO the_count_max;

    SELECT src_lpodatas.fct_c_get_species_values_from_vn
           ('latin_name'::TEXT, the_id_sp_source)
    INTO the_nom_cite;
    SELECT gn_commons.get_default_parameter('taxref_version', NULL)
    INTO
        the_meta_v_taxref;
    SELECT NULL INTO the_sample_number_proof;
    SELECT src_lpodatas.fct_c_get_medias_url_from_visionature_medias_array
           (new.item #> '{observers,0,medias}')
    INTO the_digital_proof;
    SELECT NULL INTO the_non_digital_proof;
    SELECT CAST(new.item #>> '{observers,0,altitude}' AS INTEGER) INTO the_altitude_min;
    SELECT CAST(new.item #>> '{observers,0,altitude}' AS INTEGER) INTO the_altitude_max;

    SELECT _the_geom_4326 INTO _the_geom_point;
    SELECT public.st_transform(_the_geom_4326,
                               (gn_commons.get_default_parameter('gn_local_srid', NULL))::INT)
    INTO
        _the_geom_local;

    SELECT NULL INTO the_validation_comment;
    SELECT CASE
               WHEN (new.item #> '{observers,0}') ? 'second_hand'
                   AND (new.item #>> '{observers,0,second_hand}') = '1' THEN
                   NULL
               ELSE
                   src_lpodatas.fct_c_get_role_name_from_visionature_uid(new.item #>>
                                                                         '{observers,0,@uid}', TRUE)
               END
    INTO the_observers;
    SELECT CASE
               WHEN (new.item #> '{observers,0}') ? 'second_hand'
                   AND (new.item #>> '{observers,0,second_hand}') = '1' THEN
                   NULL
               ELSE
                   src_lpodatas.fct_c_get_role_name_from_visionature_uid(new.item #>>
                                                                         '{observers,0,@uid}', FALSE)
               END
    INTO the_observers_extended;
    SELECT the_observers INTO the_determiner;
    SELECT gn_synthese.get_default_nomenclature_value('METH_DETERMIN')
    INTO
        the_id_nomenclature_determination_method;
    --	 COALESCE(
    --
    --
    --  ref_nomenclatures.fct_c_get_synonyms_nomenclature('METH_DETERMIN',
    --
    --	 new.item
    --	     #>>
    --	      '{observers,0,details,0,condition}'),
    --			   ,
    --	   gn_synthese.get_default_nomenclature_value('METH_DETERMIN'))
    SELECT new.item #>> '{observers,0,comment}' INTO the_comments;
    SELECT src_lpodatas.fct_c_get_source_url(the_id_source,
                                             the_entity_source_pk_value)
    INTO the_reference_biblio;
    --     SELECT
    --		       to_timestamp(cast(new.item #>> '{observers,0,insert_date}' AS
    -- DOUBLE
    --	     PRECISION))
    --		       INTO the_meta_create_date;
    --		   SELECT
    --		       to_timestamp(cast(new.item #>> '{observers,0,update_date}' AS
    -- DOUBLE
    --	     PRECISION))
    --		       INTO the_meta_update_date;
    /* Partie .t_c_synthese_extended */
    SELECT src_lpodatas.fct_c_get_taxo_group_values_from_vn('name',
                                                            new.site, CAST(new.item #>> '{species,taxonomy}' AS INT))
    INTO
        the_taxo_group;
    SELECT src_lpodatas.fct_c_get_taxref_values_from_vn('id_rang'::TEXT
               , CAST(new.item #>> '{species,@id}' AS INTEGER)) IN ('ES', 'SSES')
    INTO the_taxo_real;
    SELECT CASE
               WHEN src_lpodatas.fct_c_get_taxref_values_from_vn
                    ('nom_vern'::TEXT, the_id_sp_source) IS NOT NULL THEN
                   SPLIT_PART(src_lpodatas.fct_c_get_taxref_values_from_vn
                              ('nom_vern'::TEXT, the_id_sp_source), ','
                       , 1)
               ELSE
                   src_lpodatas.fct_c_get_species_values_from_vn
                   ('french_name'::TEXT, the_id_sp_source)
               END
    INTO the_common_name;
    SELECT ENCODE(hmac(CAST((new.item #>> '{observers,0,@uid}') AS TEXT),
                       'cyifoE!A5r', 'sha1'), 'hex')
    INTO
        the_pseudo_observer_uid;

    SELECT CASE
               WHEN (new.item #> '{observers,0}') ? 'atlas_code' THEN
                   ref_nomenclatures.get_nomenclature_label_by_cdnom_mnemonique
                   ('VN_ATLAS_CODE', new.item #>> '{observers,0,atlas_code}')
               ELSE
                   src_lpodatas.fct_c_get_reproduction_status((new.item #>>
                                                               '{species,taxonomy}')::INT, new.item)
               END
    INTO the_breed_status;
    SELECT NULL INTO the_bat_breed_colo;
    SELECT NULL INTO the_bat_is_gite;
    SELECT NULL INTO the_bat_period;
    SELECT new.item #>> '{observers,0,estimation_code}' INTO the_estimation_code;
    SELECT CAST(EXTRACT(YEAR FROM TO_TIMESTAMP(CAST(new.item #>>
                                                    '{date,@timestamp}' AS DOUBLE PRECISION))) AS INTEGER)
    INTO the_date_year;
    SELECT CAST(((new.item #>> '{observers,0,extended_info,mortality}'::TEXT[]) IS NOT NULL) AS
               BOOLEAN)
    INTO the_mortality;
    SELECT new.item #>> '{observers,0,extended_info, mortality, death_cause2}' INTO the_mortality_cause;
    SELECT FALSE INTO the_export_excluded;
    SELECT new.item #>> '{observers,0,project_code}' INTO the_project_code;
    SELECT src_lpodatas.fct_c_get_entity_from_observer_site_uid(CAST((new.item
        #>> '{observers,0,@uid}') AS INTEGER), new.site)
    INTO
        the_juridical_person;
    SELECT src_lpodatas.fct_c_get_behaviours_texts_array_from_id_array
           (new.item #> '{observers,0,behaviours}')
    INTO the_behaviour;
    SELECT new.item #>> '{observers,0,precision}' INTO the_geo_accuracy;
    SELECT new.item #> '{observers,0,details}' INTO the_details;
    SELECT CAST(new.item #>> '{place,@id}' AS INTEGER) INTO the_id_place;
    SELECT new.item #>> '{place,name}' INTO the_place;
    SELECT CASE WHEN new.id_form_universal IS NOT NULL AND new.id_form_universal != '0' THEN new.id_form_universal END
    INTO the_id_form;
    SELECT COALESCE(NOT CAST(new.item #>> '{observers,0,admin_hidden}' AS BOOLEAN), TRUE)
    INTO the_is_valid;
    SELECT new.item #>> '{observers,0,hidden_comment}' INTO the_private_comment;
    SELECT CAST(new.item #>> '{observers,0,hidden}' IS NOT NULL AS bool) INTO the_is_hidden;

    RAISE DEBUG '-- % -- Populate variables > ENDING : duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
    IF (tg_op = 'UPDATE')
        -- DO UPDATE IF trigger action is an UPDATE
    THEN
        RAISE DEBUG 'Try update data % from site % with uuid %' , new.id , new.site , the_unique_id_sinp;
        RAISE DEBUG '-- % -- Update statement synthese when found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        -- Updating data on gn_synthese.synthese when raw data is updated
        UPDATE
            gn_synthese.synthese
        SET unique_id_sinp                       = COALESCE(unique_id_sinp, the_unique_id_sinp)
          , unique_id_sinp_grp                   = the_unique_id_sinp_grp
          , id_source                            =
            the_id_source
          , entity_source_pk_value               = the_entity_source_pk_value
          , id_dataset                           = the_id_dataset
          , id_nomenclature_geo_object_nature    =
            the_id_nomenclature_geo_object_nature
          , id_nomenclature_grp_typ              =
            the_id_nomenclature_grp_typ
          --   , id_nomenclature_obs_meth             = the_id_nomenclature_obs_meth
          , id_nomenclature_obs_technique        = the_id_nomenclature_obs_technique
          , id_nomenclature_bio_status           = the_id_nomenclature_bio_status
          , id_nomenclature_bio_condition        =
            the_id_nomenclature_bio_condition
          , id_nomenclature_naturalness
                                                 = the_id_nomenclature_naturalness
          , id_nomenclature_exist_proof
                                                 = the_id_nomenclature_exist_proof
          , id_nomenclature_valid_status         = the_id_nomenclature_valid_status
          , id_nomenclature_diffusion_level      =
            the_id_nomenclature_diffusion_level
          , id_nomenclature_life_stage           = the_id_nomenclature_life_stage
          , id_nomenclature_sex                  = the_id_nomenclature_sex
          , id_nomenclature_obj_count            = the_id_nomenclature_obj_count
          , id_nomenclature_type_count           = the_id_nomenclature_type_count
          , id_nomenclature_sensitivity          = the_id_nomenclature_sensitivity
          , id_nomenclature_observation_status   =
            the_id_nomenclature_observation_status
          , id_nomenclature_blurring             = the_id_nomenclature_blurring
          , id_nomenclature_source_status        =
            the_id_nomenclature_source_status
          , id_nomenclature_info_geo_type        =
            the_id_nomenclature_info_geo_type
          , count_min                            = the_count_min
          , count_max                            = the_count_max
          , cd_nom                               = the_cd_nom
          , nom_cite                             =
            the_nom_cite
          , meta_v_taxref                        = the_meta_v_taxref
          , sample_number_proof                  = the_sample_number_proof
          , digital_proof                        =
            the_digital_proof
          , non_digital_proof                    = the_non_digital_proof
          , altitude_min                         = the_altitude_min
          , altitude_max                         =
            the_altitude_max
          , the_geom_4326                        = _the_geom_4326
          , the_geom_point                       = _the_geom_point
          , the_geom_local                       =
            _the_geom_local
          , date_min                             = the_date_min
          , date_max                             =
            the_date_max
          , validation_comment                   = the_validation_comment
          , observers                            = the_observers
          , id_digitiser                         = the_id_digitiser
          , id_nomenclature_determination_method =
            the_id_nomenclature_determination_method
          , comment_description
                                                 = the_comments
          , reference_biblio                     = the_reference_biblio
          --	   , meta_create_date			  = the_meta_create_date
          --			 , meta_update_date			= now()
          , last_action                          = 'U'
        WHERE (unique_id_sinp = the_unique_id_sinp)
           OR (entity_source_pk_value, id_source) = (the_entity_source_pk_value, the_id_source)
        RETURNING id_synthese INTO the_id_synthese;
        RAISE DEBUG '-- % -- Update statement synthese when found > ENDING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        IF NOT found THEN
            RAISE DEBUG 'Data % from site % not found, proceed INSERT to synthese' , new.id , new.site;
            RAISE DEBUG '-- % -- Update statement synthese when NOT found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
            INSERT INTO gn_synthese.synthese ( unique_id_sinp, unique_id_sinp_grp, id_source, entity_source_pk_value
                                             , id_dataset, id_nomenclature_geo_object_nature, id_nomenclature_grp_typ,
                -- , id_nomenclature_obs_meth
                                               id_nomenclature_obs_technique, id_nomenclature_bio_status
                                             , id_nomenclature_bio_condition, id_nomenclature_naturalness
                                             , id_nomenclature_exist_proof, id_nomenclature_valid_status
                                             , id_nomenclature_diffusion_level, id_nomenclature_life_stage
                                             , id_nomenclature_sex, id_nomenclature_obj_count
                                             , id_nomenclature_type_count, id_nomenclature_sensitivity
                                             , id_nomenclature_observation_status, id_nomenclature_blurring
                                             , id_nomenclature_source_status, id_nomenclature_info_geo_type, count_min
                                             , count_max, cd_nom, nom_cite, meta_v_taxref, sample_number_proof
                                             , digital_proof, non_digital_proof, altitude_min, altitude_max
                                             , the_geom_4326, the_geom_point, the_geom_local, date_min, date_max
                                             , validation_comment, observers, id_digitiser
                                             , id_nomenclature_determination_method, comment_description
                                             , reference_biblio
                --				      , meta_create_date
                --					, meta_update_date
                                             , last_action)
            VALUES ( the_unique_id_sinp, the_unique_id_sinp_grp, the_id_source, the_entity_source_pk_value
                   , the_id_dataset
                   , the_id_nomenclature_geo_object_nature, the_id_nomenclature_grp_typ,
                       -- , the_id_nomenclature_obs_meth
                     the_id_nomenclature_obs_technique, the_id_nomenclature_bio_status
                   , the_id_nomenclature_bio_condition, the_id_nomenclature_naturalness, the_id_nomenclature_exist_proof
                   , the_id_nomenclature_valid_status, the_id_nomenclature_diffusion_level
                   , the_id_nomenclature_life_stage, the_id_nomenclature_sex, the_id_nomenclature_obj_count
                   , the_id_nomenclature_type_count, the_id_nomenclature_sensitivity
                   , the_id_nomenclature_observation_status, the_id_nomenclature_blurring
                   , the_id_nomenclature_source_status, the_id_nomenclature_info_geo_type, the_count_min, the_count_max
                   , the_cd_nom, the_nom_cite, the_meta_v_taxref, the_sample_number_proof, the_digital_proof
                   , the_non_digital_proof, the_altitude_min, the_altitude_max, _the_geom_4326, _the_geom_point
                   , _the_geom_local, the_date_min, the_date_max, the_validation_comment, the_observers
                   , the_id_digitiser, the_id_nomenclature_determination_method, the_comments
                   , the_reference_biblio
                       --		     , now()
                       --			, the_meta_update_date
                   , 'U')
            RETURNING id_synthese INTO the_id_synthese;
            RAISE DEBUG '-- % -- Update statement synthese when NOT found > ENDING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        END IF;
        -- Updating extended datas when raw data is updated
        RAISE DEBUG '-- % -- Update statement t_c_synthese_extended when found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        UPDATE
            src_lpodatas.t_c_synthese_extended
        SET id_synthese         = the_id_synthese
          , id_sp_source        = the_id_sp_source
          , taxo_group          = the_taxo_group
          , taxo_real           = the_taxo_real
          , common_name         = the_common_name
          , pseudo_observer_uid =
            the_pseudo_observer_uid
          , bird_breed_code     = the_bird_breed_code
          , breed_status        = the_breed_status
          , bat_breed_colo      =
            the_bat_breed_colo
          , bat_is_gite         = the_bat_is_gite
          , bat_period          =
            the_bat_period
          , estimation_code     = the_estimation_code
          , date_year
                                = the_date_year
          , mortality           = the_mortality
          , mortality_cause     =
            the_mortality_cause
          , export_excluded     = the_export_excluded
          , project_code        = the_project_code
          , juridical_person    =
            the_juridical_person
          , behaviour           = the_behaviour
          , geo_accuracy        =
            the_geo_accuracy
          , details             = the_details
          , id_place            = the_id_place
          , place               = the_place
          , id_form             = the_id_form
          , is_valid            =
            the_is_valid
          , private_comment     = the_private_comment
          , is_hidden           =
            the_is_hidden
          , observers           = the_observers_extended
          , comment_form        = the_comment_form
        WHERE id_synthese = the_id_synthese;

        IF NOT found THEN
            RAISE DEBUG 'Data % from site % not found, proceed INSERT to synthese_extended' , new.id , new.site;
            RAISE DEBUG '-- % -- Update statement t_c_synthese_extended when NOT found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
            INSERT INTO src_lpodatas.t_c_synthese_extended ( id_synthese, id_sp_source, taxo_group, taxo_real
                                                           , common_name, pseudo_observer_uid, bird_breed_code
                                                           , breed_status, bat_breed_colo, bat_is_gite, bat_period
                                                           , estimation_code, date_year, mortality, mortality_cause
                                                           , export_excluded, project_code, juridical_person, behaviour
                                                           , geo_accuracy, details, id_place, place, id_form, is_valid
                                                           , private_comment, is_hidden, observers, comment_form)
            VALUES ( the_id_synthese, the_id_sp_source, the_taxo_group, the_taxo_real, the_common_name
                   , the_pseudo_observer_uid, the_bird_breed_code, the_breed_status, the_bat_breed_colo
                   , the_bat_is_gite, the_bat_period, the_estimation_code, the_date_year, the_mortality
                   , the_mortality_cause, the_export_excluded, the_project_code, the_juridical_person, the_behaviour
                   , the_geo_accuracy, the_details, the_id_place, the_place, the_id_form, the_is_valid
                   , the_private_comment, the_is_hidden, the_observers_extended, the_comment_form);
        END IF;
    ELSEIF (tg_op = 'INSERT') THEN
        RAISE DEBUG 'Try insert data % from site %' , new.id , new.site;
        RAISE DEBUG '-- % -- insert statement synthese when found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        INSERT INTO gn_synthese.synthese ( unique_id_sinp, unique_id_sinp_grp, id_source, entity_source_pk_value
                                         , id_dataset, id_nomenclature_geo_object_nature, id_nomenclature_grp_typ,
            -- , id_nomenclature_obs_meth
                                           id_nomenclature_obs_technique, id_nomenclature_bio_status
                                         , id_nomenclature_bio_condition, id_nomenclature_naturalness
                                         , id_nomenclature_exist_proof, id_nomenclature_valid_status
                                         , id_nomenclature_diffusion_level, id_nomenclature_life_stage
                                         , id_nomenclature_sex, id_nomenclature_obj_count, id_nomenclature_type_count
                                         , id_nomenclature_sensitivity, id_nomenclature_observation_status
                                         , id_nomenclature_blurring, id_nomenclature_source_status
                                         , id_nomenclature_info_geo_type, count_min, count_max, cd_nom, nom_cite
                                         , meta_v_taxref, sample_number_proof, digital_proof, non_digital_proof
                                         , altitude_min, altitude_max, the_geom_4326, the_geom_point, the_geom_local
                                         , date_min, date_max, validation_comment, observers, id_digitiser
                                         , id_nomenclature_determination_method
                                         , comment_description, reference_biblio
            --				  , meta_create_date
            --				   , meta_update_date
                                         , last_action)
        VALUES ( the_unique_id_sinp, the_unique_id_sinp_grp, the_id_source
               , the_entity_source_pk_value, the_id_dataset, the_id_nomenclature_geo_object_nature
               , the_id_nomenclature_grp_typ,
                   -- , the_id_nomenclature_obs_meth
                 the_id_nomenclature_obs_technique, the_id_nomenclature_bio_status, the_id_nomenclature_bio_condition
               , the_id_nomenclature_naturalness, the_id_nomenclature_exist_proof, the_id_nomenclature_valid_status
               , the_id_nomenclature_diffusion_level, the_id_nomenclature_life_stage, the_id_nomenclature_sex
               , the_id_nomenclature_obj_count, the_id_nomenclature_type_count, the_id_nomenclature_sensitivity
               , the_id_nomenclature_observation_status, the_id_nomenclature_blurring, the_id_nomenclature_source_status
               , the_id_nomenclature_info_geo_type, the_count_min, the_count_max, the_cd_nom, the_nom_cite
               , the_meta_v_taxref, the_sample_number_proof, the_digital_proof, the_non_digital_proof, the_altitude_min
               , the_altitude_max, _the_geom_4326, _the_geom_point, _the_geom_local, the_date_min, the_date_max
               , the_validation_comment, the_observers, the_id_digitiser, the_id_nomenclature_determination_method
               , the_comments, the_reference_biblio
                   --		 , the_meta_create_date
                   --		  , the_meta_update_date
               , 'U')
        ON CONFLICT (unique_id_sinp)
            DO UPDATE SET unique_id_sinp_grp                   = the_unique_id_sinp_grp
                        , id_source                            =
                the_id_source
                        , entity_source_pk_value               =
                the_entity_source_pk_value
                        , id_dataset                           = the_id_dataset
                        , id_nomenclature_geo_object_nature    =
                the_id_nomenclature_geo_object_nature
                        , id_nomenclature_grp_typ              = the_id_nomenclature_grp_typ
                        ,
                        --   , id_nomenclature_obs_meth		  = the_id_nomenclature_obs_meth
            id_nomenclature_obs_technique                      =
                the_id_nomenclature_obs_technique
                        , id_nomenclature_bio_status           = the_id_nomenclature_bio_status
                        , id_nomenclature_bio_condition        =
                the_id_nomenclature_bio_condition
                        , id_nomenclature_naturalness          =
                the_id_nomenclature_naturalness
                        , id_nomenclature_exist_proof          =
                the_id_nomenclature_exist_proof
                        , id_nomenclature_valid_status         =
                the_id_nomenclature_valid_status
                        , id_nomenclature_diffusion_level      =
                the_id_nomenclature_diffusion_level
                        , id_nomenclature_life_stage           = the_id_nomenclature_life_stage
                        , id_nomenclature_sex                  = the_id_nomenclature_sex
                        , id_nomenclature_obj_count            = the_id_nomenclature_obj_count
                        , id_nomenclature_type_count           = the_id_nomenclature_type_count
                        , id_nomenclature_sensitivity          =
                the_id_nomenclature_sensitivity
                        , id_nomenclature_observation_status   =
                the_id_nomenclature_observation_status
                        , id_nomenclature_blurring             = the_id_nomenclature_blurring
                        , id_nomenclature_source_status        =
                the_id_nomenclature_source_status
                        , id_nomenclature_info_geo_type        =
                the_id_nomenclature_info_geo_type
                        , count_min                            =
                the_count_min
                        , count_max                            = the_count_max
                        , cd_nom                               =
                the_cd_nom
                        , nom_cite                             = the_nom_cite
                        , meta_v_taxref                        =
                the_meta_v_taxref
                        , sample_number_proof                  =
                the_sample_number_proof
                        , digital_proof                        = the_digital_proof
                        , non_digital_proof                    = the_non_digital_proof
                        , altitude_min
                                                               = the_altitude_min
                        , altitude_max                         = the_altitude_max
                        , the_geom_4326                        = _the_geom_4326
                        , the_geom_point                       =
                _the_geom_point
                        , the_geom_local                       = _the_geom_local
                        , date_min                             = the_date_min
                        , date_max                             = the_date_max
                        , validation_comment                   = the_validation_comment
                        , observers                            =
                the_observers
                        , id_digitiser                         = the_id_digitiser
                        , id_nomenclature_determination_method =
                the_id_nomenclature_determination_method
                        , comment_description                  = the_comments
                        , reference_biblio                     =
                the_reference_biblio
                        --			 , meta_create_date			=
                        --	      the_meta_create_date
                        --				       , meta_update_date		      =
                        --	      the_meta_update_date
                        , last_action                          = 'U'
        RETURNING id_synthese INTO the_id_synthese;
        RAISE DEBUG '-- % -- insert statement synthese when found > ENDING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        RAISE DEBUG '-- % -- insert statement t_c_synthese_extended when found > BEGINNING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));
        INSERT INTO src_lpodatas.t_c_synthese_extended ( id_synthese, id_sp_source, taxo_group, taxo_real, common_name
                                                       , pseudo_observer_uid, bird_breed_code, breed_status
                                                       , bat_breed_colo, bat_is_gite, bat_period, estimation_code
                                                       , date_year, mortality, mortality_cause, export_excluded
                                                       , project_code, juridical_person, behaviour, geo_accuracy
                                                       , details, id_place, place, id_form, is_valid, private_comment
                                                       , is_hidden, observers, comment_form)
        VALUES ( the_id_synthese, the_id_sp_source, the_taxo_group, the_taxo_real, the_common_name
               , the_pseudo_observer_uid, the_bird_breed_code, the_breed_status, the_bat_breed_colo, the_bat_is_gite
               , the_bat_period, the_estimation_code, the_date_year, the_mortality, the_mortality_cause
               , the_export_excluded, the_project_code, the_juridical_person, the_behaviour, the_geo_accuracy
               , the_details, the_id_place, the_place, the_id_form, the_is_valid, the_private_comment, the_is_hidden
               , the_observers_extended, the_comment_form)
        ON CONFLICT (id_synthese)
            DO UPDATE SET id_synthese         = the_id_synthese
                        , id_sp_source        = the_id_sp_source
                        , taxo_group          = the_taxo_group
                        , taxo_real           = the_taxo_real
                        , common_name         = the_common_name
                        , pseudo_observer_uid =
                the_pseudo_observer_uid
                        , bird_breed_code     =
                the_bird_breed_code
                        , breed_status        = the_breed_status
                        , bat_breed_colo      = the_bat_breed_colo
                        , bat_is_gite         =
                the_bat_is_gite
                        , bat_period          = the_bat_period
                        , estimation_code     = the_estimation_code
                        , date_year           =
                the_date_year
                        , mortality           = the_mortality
                        , mortality_cause
                                              = the_mortality_cause
                        , export_excluded     =
                the_export_excluded
                        , project_code        = the_project_code
                        , juridical_person    = the_juridical_person
                        , behaviour           =
                the_behaviour
                        , geo_accuracy        = the_geo_accuracy
                        , details             =
                the_details
                        , id_place            = the_id_place
                        , place               = the_place
                        , id_form             = the_id_form
                        , is_valid            = the_is_valid
                        , private_comment     = the_private_comment
                        , is_hidden           =
                the_is_hidden
                        , observers           = the_observers_extended
                        , comment_form        = the_comment_form;
        RAISE DEBUG '-- % -- insert statement t_c_synthese_extended when found > ENDING : total duration %' , start_ts , (SELECT (CLOCK_TIMESTAMP() - start_ts));

        RAISE DEBUG 'NEW upsert data %' , the_id_synthese;
    END IF;


    /* Debug block, to comment if not used */
    --     INSERT INTO
    --		       tmp.debug_log_duration(site, id, uuid, duration,
    --      project_code,
    --	      id_dataset)
    --		       VALUES
    --			   ( new.site
    --			   , new.id
    --			   , the_unique_id_sinp
    --			   , (clock_timestamp() - start_ts)
    --			   , new.item #> '{observers,0}' ? 'project_code'
    --			   , the_id_dataset);
    RETURN new;
END;
$$;

COMMENT ON FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature() IS 'Trigger function to upsert datas from VisioNature to synthese and custom child table';

ALTER FUNCTION src_lpodatas.fct_tri_c_upsert_vn_observation_to_geonature() OWNER TO dbadmin;

UPDATE src_lpodatas.t_c_synthese_extended
SET comment_form= forms.comment
FROM (SELECT forms_json.id_form_universal, forms_json.item ->> 'comment' AS comment
      FROM src_vn_json.forms_json
               JOIN src_vn_json.observations_json
                    ON forms_json.id_form_universal = observations_json.id_form_universal
      WHERE forms_json.item ->> 'comment' IS NOT NULL
        AND observations_json.id_form_universal != '0') forms
WHERE forms.id_form_universal = t_c_synthese_extended.id_form;

COMMIT;
