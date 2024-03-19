/*
Filtrage territorialisé des données issues de l'API VN depuis l'appli Client-API-VN


Objectif: Supprimer les données de src_vn_json.observations_json qui ne sont pas comprises dans VN_COVER :

PREREQUIS
=========

Le filtrage des données se fait sur un zonage intégré à la table ref_geo.l_areas dont le type_code est VN_COVER.

Il faut dont créer un type de code VN_COVER dans ref_geo.bib_areas_type et créer un zonage associé à ce type dans reg_geo.l_areas.
Suppression des données hors zone si présentes en bdd

*/

/*
Si des données hors-zone sont déjà présentes dans la bdd. Il est possible de les supprimer avec la requête suivante.
*/
BEGIN;

DELETE FROM src_vn_json.observations_json
WHERE st_disjoint(
    public.st_setsrid(
        public.st_makepoint(
            (item #>> '{observers,0,coord_lon}')::float,
            (item #>> '{observers,0,coord_lat}')::float
        ),
        4326
    ),
    st_transform(
        (
            SELECT geom
            FROM ref_geo.l_areas
            WHERE id_type = ref_geo.get_id_area_type('VN_COVER')
        ),
        4326
    )
);

COMMIT;

/* MISE EN PLACE DU TRIGGER D'EXCLUSION */
BEGIN;

CREATE OR REPLACE FUNCTION src_vn_json.fct_tri_c_check_vn_cover()
RETURNS trigger
LANGUAGE plpgsql
AS
$function$
DECLARE
    the_geom_4326 GEOMETRY(Geometry, 4326);
    the_vn_cover  GEOMETRY(Geometry, 4326);

BEGIN
    SELECT
        public.st_setsrid(public.st_makepoint((new.item #>> '{observers,0,coord_lon}')::FLOAT,
                                              (new.item #>> '{observers,0,coord_lat}')::FLOAT), 4326)
        INTO the_geom_4326;
    SELECT
        st_transform(geom, 4326)
        INTO the_vn_cover
        FROM
            ref_geo.l_areas
        WHERE
            id_type = ref_geo.get_id_area_type('VN_COVER')
        LIMIT 1;

    IF (st_intersects(the_geom_4326, the_vn_cover)) THEN
        RAISE DEBUG 'In COVER';
        RETURN new;
    ELSE
        RAISE DEBUG 'Out COVER';
        RETURN NULL;
    END IF;

END;
$function$;


DROP TRIGGER IF EXISTS tri_c_check_vn_cover ON src_vn_json.observations_json;

CREATE TRIGGER tri_c_check_vn_cover
BEFORE INSERT OR UPDATE
ON src_vn_json.observations_json
FOR EACH ROW
EXECUTE FUNCTION src_vn_json.fct_tri_c_check_vn_cover();

COMMIT;
