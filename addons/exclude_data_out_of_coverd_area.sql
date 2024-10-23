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

INSERT INTO ref_geo.bib_areas_types(type_name, type_code, type_desc, ref_name, ref_version, num_version, size_hierarchy)
VALUES ('Zone de couverture faune-bfc', 'VN_COVER', NULL, NULL, NULL, NULL, NULL);
WITH t1 AS (SELECT st_simplify(st_buffer(st_union(geom), 500), 250) AS geom
            FROM ref_geo.l_areas
            WHERE id_type = ref_geo.get_id_area_type('DEP')
              AND area_code IN ('21', '25', '39', '58', '70', '71', '89', '90'))

INSERT
INTO ref_geo.l_areas( id_type, area_name, area_code, geom, centroid, source, comment, additional_data
                    , meta_create_date, meta_update_date, geom_4326)
SELECT ref_geo.get_id_area_type('VN_COVER')
     , 'Région BFC pour VN'
     , '27'
     , geom
     , st_centroid(geom)
     , 'Généré en bdd'
     , 'Zonage utilisé pour filtrer les données entrantes Faune BFC'
     , '{}'::jsonb
     , NOW()
     , NOW()
     , st_transform(geom, 4326)
FROM t1
;

BEGIN;

DELETE
FROM src_vn_json.observations_json
WHERE st_disjoint(
              public.st_setsrid(
                      public.st_makepoint(
                              (item #>> '{observers,0,coord_lon}')::FLOAT,
                              (item #>> '{observers,0,coord_lat}')::FLOAT
                      ),
                      4326
              ),
              st_transform(
                      (SELECT geom
                       FROM ref_geo.l_areas
                       WHERE id_type = ref_geo.get_id_area_type('VN_COVER')),
                      4326
              )
      );

COMMIT;

/* MISE EN PLACE DU TRIGGER D'EXCLUSION */
ROLLBACK;
BEGIN;

CREATE OR REPLACE FUNCTION src_vn_json.fct_tri_c_check_vn_cover()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$function$
DECLARE
    the_geom_4326 geometry(Geometry, 4326);
    the_vn_cover  geometry(Geometry, 4326);

BEGIN
    SELECT public.st_setsrid(public.st_makepoint((new.item #>> '{observers,0,coord_lon}')::FLOAT,
                                                 (new.item #>> '{observers,0,coord_lat}')::FLOAT), 4326)
    INTO the_geom_4326;
    SELECT st_transform(geom, 4326)
    INTO the_vn_cover
    FROM ref_geo.l_areas
    WHERE id_type = ref_geo.get_id_area_type('VN_COVER')
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
