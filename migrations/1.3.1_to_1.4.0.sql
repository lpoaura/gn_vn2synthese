/* 
Migration depuis la version 1.3.1 vers la version 1.4.0
Préalable à l'application des scripts
*/

BEGIN;


ALTER TABLE src_lpodatas.t_c_synthese_extended alter column bird_breed_status rename to breed_status;


COMMIT;
