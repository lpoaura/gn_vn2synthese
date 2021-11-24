/*
TAXONOMY
--------
Specific table to manage taxa matching between VisioNature and taxref repository
*/

BEGIN;

CREATE TABLE taxonomie.cor_c_vn_taxref
(
    vn_id     INTEGER,
    taxref_id INTEGER
)
;

CREATE UNIQUE INDEX i_uniq_cor_c_vn_taxref ON taxonomie.cor_c_vn_taxref (vn_id, taxref_id)
;

COMMENT ON TABLE taxonomie.cor_c_vn_taxref IS 'Correlation between taxref cd_nom (taxref) and VisioNature species id (src_vn.species).'
;

COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.vn_id IS 'Link to src_vn.species'
;

COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.taxref_id IS 'Link to taxonomie.taxref'
;

COMMIT;
