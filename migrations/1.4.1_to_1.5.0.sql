BEGIN;

ALTER TABLE taxonomie.cor_c_vn_taxref
    DROP CONSTRAINT IF EXISTS cor_c_vn_taxref_cd_nom_fkey;
ALTER TABLE taxonomie.cor_c_vn_taxref
    DROP CONSTRAINT IF EXISTS cd_nom;
ALTER TABLE taxonomie.cor_c_vn_taxref
    ADD CONSTRAINT cor_c_vn_taxref_cd_nom_fkey
        FOREIGN KEY (cd_nom)
            REFERENCES taxonomie.taxref (cd_nom)
            ON DELETE SET NULL ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS taxonomie.t_c_taxref_ajout
(
    cd_nom           INTEGER NOT NULL
        CONSTRAINT t_c_taxref_ajout_pk PRIMARY KEY
        CONSTRAINT chk_cd_nom_negative CHECK (cd_nom < 0),
    id_statut        CHARACTER(1),
    id_habitat       INTEGER,
    id_rang          CHARACTER VARYING(10),
    regne            CHARACTER VARYING(20),
    phylum           CHARACTER VARYING(50),
    classe           CHARACTER VARYING(50),
    ordre            CHARACTER VARYING(50),
    famille          CHARACTER VARYING(50),
    sous_famille     CHARACTER VARYING(50),
    tribu            CHARACTER VARYING(50),
    cd_taxsup        INTEGER,
    cd_sup           INTEGER,
    cd_ref           INTEGER
        CONSTRAINT chk_cd_ref_negative CHECK (cd_ref < 0),
    lb_nom           CHARACTER VARYING(100),
    lb_auteur        CHARACTER VARYING(500),
    nom_complet      CHARACTER VARYING(500),
    nom_complet_html CHARACTER VARYING(500),
    nom_valide       CHARACTER VARYING(500),
    nom_vern         CHARACTER VARYING(1000),
    nom_vern_eng     CHARACTER VARYING(500),
    group1_inpn      CHARACTER VARYING(255),
    group2_inpn      CHARACTER VARYING(255),
    group3_inpn      CHARACTER VARYING(255),
    url              TEXT
);

CREATE OR REPLACE FUNCTION taxonomie.fct_tri_c_upsert_taxref()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Upsert operation
    IF (tg_op = 'INSERT' OR tg_op = 'UPDATE') THEN
        INSERT INTO taxonomie.taxref ( cd_nom, id_statut, id_habitat, id_rang, regne, phylum, classe, ordre, famille
                                     , sous_famille, tribu, cd_taxsup, cd_sup, cd_ref, lb_nom, lb_auteur, nom_complet
                                     , nom_complet_html, nom_valide, nom_vern, nom_vern_eng, group1_inpn, group2_inpn
                                     , url)
        VALUES ( new.cd_nom, new.id_statut, new.id_habitat, new.id_rang, new.regne, new.phylum, new.classe, new.ordre
               , new.famille, new.sous_famille, new.tribu, new.cd_taxsup, new.cd_sup, new.cd_ref, new.lb_nom
               , new.lb_auteur, new.nom_complet, new.nom_complet_html, new.nom_valide, new.nom_vern, new.nom_vern_eng
               , new.group1_inpn, new.group2_inpn, new.url)
        ON CONFLICT (cd_nom) DO UPDATE
            SET id_statut        = excluded.id_statut
              , id_habitat       = excluded.id_habitat
              , id_rang          = excluded.id_rang
              , regne            = excluded.regne
              , phylum           = excluded.phylum
              , classe           = excluded.classe
              , ordre            = excluded.ordre
              , famille          = excluded.famille
              , sous_famille     = excluded.sous_famille
              , tribu            = excluded.tribu
              , cd_taxsup        = excluded.cd_taxsup
              , cd_sup           = excluded.cd_sup
              , cd_ref           = excluded.cd_ref
              , lb_nom           = excluded.lb_nom
              , lb_auteur        = excluded.lb_auteur
              , nom_complet      = excluded.nom_complet
              , nom_complet_html = excluded.nom_complet_html
              , nom_valide       = excluded.nom_valide
              , nom_vern         = excluded.nom_vern
              , nom_vern_eng     = excluded.nom_vern_eng
              , group1_inpn      = excluded.group1_inpn
              , group2_inpn      = excluded.group2_inpn
              , group3_inpn      = excluded.group3_inpn;
        RETURN new;

    ELSIF (tg_op = 'DELETE') THEN
        DELETE FROM taxonomie.taxref WHERE cd_nom = old.cd_nom;
        RETURN old;
    END IF;

    RETURN NULL; -- Result is ignored for AFTER triggers
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION taxonomie.fct_tri_c_upsert_taxref() IS 'Trigger function to manage additional taxa from taxonomie.t_c_taxref_ajout to taxononomie.taxref';

CREATE TRIGGER trg_upsert_taxref_ajout
    AFTER INSERT OR UPDATE OR DELETE
    ON taxonomie.t_c_taxref_ajout
    FOR EACH ROW
EXECUTE FUNCTION taxonomie.fct_tri_c_upsert_taxref();

COMMIT;
