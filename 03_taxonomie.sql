/*
TAXONOMY
--------
Specific table to manage taxa matching between VisioNature and taxref repository
*/

BEGIN;

CREATE TABLE taxonomie.cor_c_vn_taxref
(
    vn_id            INTEGER,
    cd_nom           INTEGER REFERENCES taxonomie.taxref (cd_nom),
    meta_create_date TIMESTAMP,
    meta_update_date TIMESTAMP
)
;

CREATE UNIQUE INDEX i_uniq_cor_c_vn_taxref ON taxonomie.cor_c_vn_taxref (vn_id, cd_nom)
;

COMMENT ON TABLE taxonomie.cor_c_vn_taxref IS 'Correlation between taxref cd_nom (taxref) and VisioNature species id (src_vn.species).'
;

COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.vn_id IS 'Link to src_vn.species'
;

COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.cd_nom IS 'Link to taxonomie.taxref'
;

CREATE TRIGGER tri_meta_dates_change_cor_c_vn_taxref
    BEFORE INSERT OR UPDATE
    ON taxonomie.cor_c_vn_taxref
    FOR EACH ROW
EXECUTE PROCEDURE public.fct_trg_meta_dates_change();

COMMIT;
