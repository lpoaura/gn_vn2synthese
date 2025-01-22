BEGIN;

ALTER TABLE taxonomie.cor_c_vn_taxref 
  ADD CONSTRAINT cd_nom 
  FOREIGN KEY (cd_nom) 
  REFERENCES taxonomie.taxref (cd_nom)
  ON DELETE SET NULL;


CREATE TABLE taxonomie.t_c_taxref_ajout (
    cd_nom           INTEGER NOT NULL
        CONSTRAINT t_c_taxref_ajout_pk PRIMARY KEY
        CONSTRAINT chk_cd_nom_negative CHECK (cd_nom < 0),
    id_statut character(1),
    id_habitat integer,
    id_rang character varying(10),
    regne character varying(20),
    phylum character varying(50),
    classe character varying(50),
    ordre character varying(50),
    famille character varying(50),
    sous_famille character varying(50),
    tribu character varying(50),
    cd_taxsup integer,
    cd_sup integer,
    cd_ref integer CONSTRAINT chk_cd_ref_negative CHECK (cd_ref < 0),
    lb_nom character varying(100),
    lb_auteur character varying(500),
    nom_complet character varying(500),
    nom_complet_html character varying(500),
    nom_valide character varying(500),
    nom_vern character varying(1000),
    nom_vern_eng character varying(500),
    group1_inpn character varying(255),
    group2_inpn character varying(255),
    group3_inpn character varying(255),
    url text
);

CREATE OR REPLACE FUNCTION taxonomie.fct_tri_c_upsert_taxref()
RETURNS TRIGGER AS $$
BEGIN
    -- Upsert operation
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        INSERT INTO taxonomie.taxref (cd_nom, id_statut, id_habitat, id_rang, regne, phylum, classe, ordre, famille, sous_famille, tribu, cd_taxsup, cd_sup, cd_ref, lb_nom, lb_auteur, nom_complet, nom_complet_html, nom_valide, nom_vern, nom_vern_eng, group1_inpn, group2_inpn, url)
        VALUES (NEW.cd_nom, NEW.id_statut, NEW.id_habitat, NEW.id_rang, NEW.regne, NEW.phylum, NEW.classe, NEW.ordre, NEW.famille, NEW.sous_famille, NEW.tribu, NEW.cd_taxsup, NEW.cd_sup, NEW.cd_ref, NEW.lb_nom, NEW.lb_auteur, NEW.nom_complet, NEW.nom_complet_html, NEW.nom_valide, NEW.nom_vern, NEW.nom_vern_eng, NEW.group1_inpn, NEW.group2_inpn, NEW.url)
        ON CONFLICT (cd_nom) DO UPDATE
        SET id_statut = EXCLUDED.id_statut,
            id_habitat = EXCLUDED.id_habitat,
            id_rang = EXCLUDED.id_rang,
            regne = EXCLUDED.regne,
            phylum = EXCLUDED.phylum,
            classe = EXCLUDED.classe,
            ordre = EXCLUDED.ordre,
            famille = EXCLUDED.famille,
            sous_famille = EXCLUDED.sous_famille,
            tribu = EXCLUDED.tribu,
            cd_taxsup = EXCLUDED.cd_taxsup,
            cd_sup = EXCLUDED.cd_sup,
            cd_ref = EXCLUDED.cd_ref,
            lb_nom = EXCLUDED.lb_nom,
            lb_auteur = EXCLUDED.lb_auteur,
            nom_complet = EXCLUDED.nom_complet,
            nom_complet_html = EXCLUDED.nom_complet_html,
            nom_valide = EXCLUDED.nom_valide,
            nom_vern = EXCLUDED.nom_vern,
            nom_vern_eng = EXCLUDED.nom_vern_eng,
            group1_inpn = EXCLUDED.group1_inpn,
            group2_inpn = EXCLUDED.group2_inpn,
            group3_inpn = EXCLUDED.group3_inpn;
        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN
        DELETE FROM taxonomie.taxref WHERE cd_nom = OLD.cd_nom;
        RETURN OLD;
    END IF;

    RETURN NULL; -- Result is ignored for AFTER triggers
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION taxonomie.fct_tri_c_upsert_taxref() IS 'Trigger function to manage additional taxa from taxonomie.t_c_taxref_ajout to taxononomie.taxref';

CREATE TRIGGER trg_upsert_taxref_ajout
AFTER INSERT OR UPDATE OR DELETE ON taxonomie.t_c_taxref_ajout
FOR EACH ROW EXECUTE FUNCTION taxonomie.fct_tri_c_upsert_taxref();

COMMIT;
