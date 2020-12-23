CREATE TABLE taxonomie.cor_c_vn_taxref (
    id bigint,
    vn_id integer,
    taxref_id integer
);

COMMENT ON TABLE taxonomie.cor_c_vn_taxref IS 'Correlation between taxref cd_nom (taxref) and VisioNature species id (src_vn.species).';
COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.vn_id IS 'Link to src_vn.species';
COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.taxref_id IS 'Link to taxonomie.taxref';
