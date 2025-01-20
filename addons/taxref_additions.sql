
CREATE TABLE taxonomie.t_c_taxref_ajout (
    cd_nom integer NOT NULL,
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
    cd_ref integer,
    lb_nom character varying(100),
    lb_auteur character varying(500),
    nom_complet character varying(500),
    nom_complet_html character varying(500),
    nom_valide character varying(500),
    nom_vern character varying(1000),
    nom_vern_eng character varying(500),
    group1_inpn character varying(255),
    group2_inpn character varying(255),
    url text
);


--
-- Data for Name: t_c_taxref_ajout; Type: TABLE DATA; Schema: taxonomie; Owner: -
--

INSERT INTO taxonomie.t_c_taxref_ajout VALUES
	(-79325, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79325, 'Myotis bechsteinii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Bechstein / à moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-60258, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Verspertilionidae', NULL, NULL, NULL, 196414, -60258, 'Plecotus auritus / austriacus', NULL, NULL, NULL, NULL, 'Oreillard gris / roux', NULL, 'Chordés', 'Mammifères', NULL),
	(-1966, 'P', 8, 'ES', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, 189130, 189130, -1966, 'Anas platyrhynchos domestica', 'Linnaeus, 1758', 'Anas platyrhynchos Linnaeus, 1758', '<i>Anas platyrhynchos</i> Linnaeus, 1758', 'Anas platyrhynchos Linnaeus, 1758', 'Canard colvert domestique', 'Mallard', 'Chordés', 'Oiseaux', 'https://inpn.mnhn.fr/espece/cd_nom/1966'),
	(-3420, 'P', 3, 'ES', 'Animalia', 'Chordata', 'Aves', 'Columbiformes', 'Columbidae', NULL, NULL, 191053, 191053, -3420, 'Columba livia domestica', 'Gmelin, 1789', 'Columba livia Gmelin, 1789', '<i>Columba livia</i> Gmelin, 1789', 'Columba livia Gmelin, 1789', 'Pigeon biset domestique', 'Rock Pigeon', 'Chordés', 'Oiseaux', 'https://inpn.mnhn.fr/espece/cd_nom/3420'),
	(-4288, 'P', 3, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Phylloscopidae', NULL, NULL, 4280, 4280, -4288, 'Phylloscopus collybita tristis / "fulvescens"', 'Blyth, 1843', '', '', 'Phylloscopus collybita tristis Blyth, 1843', 'Pouillot de type sibérien', NULL, 'Chordés', 'Oiseaux', 'https://inpn.mnhn.fr/espece/cd_nom/4288'),
	(-647478, 'P', 3, 'SSES', 'Animalia', 'Arthropoda', 'Insecta', 'Lepidoptera', 'Lycaenidae', 'Polyommatinae', 'Polyommatini', NULL, 631131, -647478, 'Phengaris alcon alcon', '(Denis & Schiffermüller, 1775)', 'Phengaris alcon alcon (Denis & Schiffermüller, 1775)', '<i>Phengaris alcon alcon</i> (Denis & Schiffermüller, 1775)', 'Phengaris alcon (Denis & Schiffermüller, 1775)', 'Azuré de la Croisette (L''), Argus bleu marine (L'')', '', 'Arthropodes', 'Insectes', 'https://inpn.mnhn.fr/espece/cd_nom/647478'),
	(-774796, 'P', 3, 'SSES', 'Animalia', 'Arthropoda', 'Insecta', 'Lepidoptera', 'Lycaenidae', 'Polyommatinae', 'Polyommatini', NULL, 631131, -774796, 'Phengaris alcon rebeli', '(Hirschke, 1904)', 'Phengaris alcon rebeli (Hirschke, 1904)', '<i>Phengaris alcon rebeli</i> (Hirschke, 1904)', 'Phengaris alcon (Denis & Schiffermüller, 1775)', 'Azuré de la Croisette (L''), Argus bleu marine (L'')', '', 'Arthropodes', 'Insectes', 'https://inpn.mnhn.fr/espece/cd_nom/774796'),
	(-67774, 'P', 4, 'SSES', 'Animalia', 'Chordata', 'Actinopterygii', 'Salmoniformes', 'Salmonidae', 'Salmoninae', '', NULL, 67772, -67774, 'Salmo trutta trutta', 'Linnaeus, 1758', 'Salmo trutta trutta Linnaeus, 1758', '<i>Salmo trutta trutta</i> Linnaeus, 1758', 'Salmo trutta Linnaeus, 1758', 'Truite de mer, Truite commune, Truite d''Europe', 'Sea trout, Brown trout', 'Chordés', 'Poissons', 'https://inpn.mnhn.fr/espece/cd_nom/67774'),
	(-53524, 'P', 3, 'ES', 'Animalia', 'Arthropoda', 'Insecta', 'Lepidoptera', 'Nymphalidae', 'Satyrinae', 'Satyrini', NULL, 219802, -53524, 'Erebia cassioides', 'auct. non (Reiner & Hohenwarth, 1792)', 'Erebia cassioides auct. non (Reiner & Hohenwarth, 1792)', '<i>Erebia cassioides</i> auct. non (Reiner & Hohenwarth, 1792)', 'Erebia arvernensis Oberthür, 1908', 'Moiré lustré (Le), Moiré arverne (Le)', '', 'Arthropodes', 'Insectes', 'https://inpn.mnhn.fr/espece/cd_nom/53524'),
	(-886228, 'P', 3, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Fringillidae', NULL, NULL, 886228, 886228, -886228, 'Acanthi sp.', NULL, NULL, NULL, NULL, 'Sizerin indéterminé', NULL, 'Chordés', 'Oiseaux', NULL),
	(-186233, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186233, 'Aucune capture filet', NULL, NULL, NULL, NULL, 'Aucune capture filet', NULL, 'Chordés', 'Mammifères', NULL),
	(-61568, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Mammalia', 'Rodentia', 'Muridae', 'Murinae', 'Murini', NULL, 61568, -61568, 'Mus musculus domesticus', NULL, NULL, NULL, NULL, 'Souris grise domestique', NULL, 'Chordés', 'Mammifères', NULL),
	(-60297, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Rhinolophidae', NULL, NULL, NULL, 197139, -60297, 'Rhinolophus euryale / ferrumequinum', NULL, NULL, NULL, NULL, 'Grand rhinolophe / Rhinolophe euryale', NULL, 'Chordés', 'Mammifères', NULL),
	(-60313, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Rhinolophidae', NULL, NULL, NULL, 197139, -60313, 'Rhinolophus euryale / hipposideros', NULL, NULL, NULL, NULL, 'Petit rhinolophe / euryale', NULL, 'Chordés', 'Mammifères', NULL),
	(-60418, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -60418, 'Myotis myotis / M. blythii', NULL, NULL, NULL, NULL, 'Murin de grande taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-79299, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79299, 'Myotis alcathoe / brandtii / mystacinus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / Brandt / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79300, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79300, 'Myotis alcathoe / capaccini / mystacinus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / Capaccini / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79301, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79301, 'Myotis alcathoe / daubentonii', NULL, NULL, NULL, NULL, 'Murin d''Alcathoe / de Daubenton', NULL, 'Chordés', 'Mammifères', NULL),
	(-79302, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79302, 'Myotis alcathoe / emarginatus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / émarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79304, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79304, 'Myotis alcathoe / mystacinus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79305, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79305, 'Myotis bechsteinii / brandtii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79306, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79306, 'Myotis bechsteinii / daubentonii', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Daubenton', NULL, 'Chordés', 'Mammifères', NULL),
	(-79307, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79307, 'Myotis bechsteinii / daubentonii / myotis-bly', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Daubenton / grande taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-79308, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79308, 'Myotis bechsteinii / daubentonii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79309, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79309, 'Myotis bechsteinii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Bechstein / émarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79310, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79310, 'Myotis bechsteinii / myotis-blythii', NULL, NULL, NULL, NULL, 'Murin de Bechstein / murin de grande taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-79311, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79311, 'Myotis brandtii / daubentonii', NULL, NULL, NULL, NULL, 'Murin de Brandt / Daubenton', NULL, 'Chordés', 'Mammifères', NULL),
	(-79312, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79312, 'Myotis brandtii / daubentonii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Brandt / Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79313, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79313, 'Myotis brandtii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Brandt / échancré', NULL, 'Chordés', 'Mammifères', NULL),
	(-79314, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79314, 'Myotis brandtii / emarginatus / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Brandt / émarginé / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79315, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79315, 'Myotis brandtii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Brandt / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79316, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79316, 'Myotis capaccinii / daubentonii', NULL, NULL, NULL, NULL, 'Murin de Capaccini / de Daubenton', NULL, 'Chordés', 'Mammifères', NULL),
	(-79317, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79317, 'Myotis capaccini / daubentonii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Capaccini / Daubenton / émarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79318, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79318, 'Myotis daubentonii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Daubenton / émarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79319, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79319, 'Myotis daubentonii / mystacinus / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Daubenton / moustaches / emarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79320, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79320, 'Myotis daubentonii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-64468, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195295, -64468, 'Nyctalus noctula / N. lasiopterus', NULL, NULL, NULL, NULL, 'Noctule commune / Grande noctule', NULL, 'Chordés', 'Mammifères', NULL),
	(-64469, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195295, -64469, 'Nyctalus leisleri / Vespertilio murinus', NULL, NULL, NULL, NULL, 'Noctule de Leisler / Sérotine bicolore', NULL, 'Chordés', 'Mammifères', NULL),
	(-64470, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -64470, 'Nyctalus / Tadarida', NULL, NULL, NULL, NULL, 'Noctule / Molosse', NULL, 'Chordés', 'Mammifères', NULL),
	(-192256, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192256, 'Eptesicus / Nyctalus', NULL, NULL, NULL, NULL, 'Sérotine / Noctule', NULL, 'Chordés', 'Mammifères', NULL),
	(-192257, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192257, 'Eptesicus / Vespertilio / Nyctalus', NULL, NULL, NULL, NULL, 'Sérotine / Noctule', NULL, 'Chordés', 'Mammifères', NULL),
	(-192258, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192258, 'Eptesicus / Myotis myotis / M. blythii', NULL, NULL, NULL, NULL, 'Sérotine / Murin de grande taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-79303, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196296, -79303, 'P. kuhlii / nathusii', NULL, NULL, NULL, NULL, 'Pipistrelle de Kuhl / Nathusius', NULL, 'Chordés', 'Mammifères', NULL),
	(-60479, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196296, -60479, 'P. pipistrellus / nathusii', NULL, NULL, NULL, NULL, 'Pipistrelle commune / Nathusius', NULL, 'Chordés', 'Mammifères', NULL),
	(-60480, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196296, -60480, 'P. pipistrellus / pygmaeus', NULL, NULL, NULL, NULL, 'Pipistrelle commune / pygmée', NULL, 'Chordés', 'Mammifères', NULL),
	(-60481, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196296, -60481, 'P. pipistrellus / M. schreibersii', NULL, NULL, NULL, NULL, 'Pipistrelle commune / Minioptère', NULL, 'Chordés', 'Mammifères', NULL),
	(-60489, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196296, -60489, 'P. pygmaeus / M. schreibersii', NULL, NULL, NULL, NULL, 'Pipistrelle pygmée / Minioptère', NULL, 'Chordés', 'Mammifères', NULL),
	(-60518, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196414, -60518, 'Plecotus auritus / macrobullaris', NULL, NULL, NULL, NULL, 'Oreillard roux / montagnard', NULL, 'Chordés', 'Mammifères', NULL),
	(-60257, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 196414, -60257, 'Plecotus austriacus / macrobullaris', NULL, NULL, NULL, NULL, 'Oreillard gris / montagnard', NULL, 'Chordés', 'Mammifères', NULL),
	(-186234, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186234, 'Aucune chauve-souris ou trace', NULL, NULL, NULL, NULL, 'Aucune chauve-souris ou trace', NULL, 'Chordés', 'Mammifères', NULL),
	(-186235, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186235, 'Aucun contact acoustique', NULL, NULL, NULL, NULL, 'Aucun contact acoustique', NULL, 'Chordés', 'Mammifères', NULL),
	(-259, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Amphibia', 'Anura', 'Bufonidae', NULL, NULL, NULL, 699157, -259, 'Bufo bufo / spinosus', NULL, NULL, NULL, NULL, 'Crapaud commun ou épineux', NULL, 'Chordés', 'Amphibiens', NULL),
	(-185939, NULL, NULL, 'RGN', 'Animalia', 'Chordata', 'Amphibia', 'Anura', NULL, NULL, NULL, NULL, 185939, -185939, 'Bufo/Bufotes/Epidalea sp', NULL, NULL, NULL, NULL, 'Crapaud indéterminé', NULL, 'Chordés', 'Amphibiens', NULL),
	(-351, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Amphibia', 'Anura', 'Ranidae', NULL, NULL, NULL, 197040, -351, 'Rana temporaria/dalmatina', NULL, NULL, NULL, NULL, 'Grenouille rousse/agile', NULL, 'Chordés', 'Amphibiens', NULL),
	(-444440, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Amphibia', 'Anura', 'Ranidae', NULL, NULL, NULL, 444436, -444440, 'Pelophylax kl. esculentus / lessonae', NULL, NULL, NULL, NULL, 'Grenouille commune / de Lessona', NULL, 'Chordés', 'Amphibiens', NULL),
	(-139, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Amphibia', 'Urodela', 'Salamandridae', NULL, NULL, NULL, 198682, -139, 'Triturus cristatus / carnifex', NULL, NULL, NULL, NULL, 'Triton crêté / bourreau', NULL, 'Chordés', 'Amphibiens', NULL),
	(-836346, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Accipitriformes', 'Accipitridae', NULL, NULL, NULL, 189372, -836346, 'Aquila clanga / pomarina x clanga', NULL, NULL, NULL, NULL, 'Aigle criard ou hybride pomarin x criard', NULL, 'Chordés', 'Oiseaux', NULL),
	(-836347, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Accipitriformes', 'Accipitridae', NULL, NULL, NULL, 189372, -836347, 'Aquila pomarina / clanga', NULL, NULL, NULL, NULL, 'Aigle pomarin ou criard', NULL, 'Chordés', 'Oiseaux', NULL),
	(-2891, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Accipitriformes', 'Accipitridae', NULL, NULL, NULL, 188728, -2891, 'Accipiter gentilis / nisus', NULL, NULL, NULL, NULL, 'Autour / Epervier', NULL, 'Chordés', 'Oiseaux', NULL),
	(-3943, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Motacillidae', NULL, NULL, NULL, 194916, -3943, 'Motacilla alba alba / yarrellii', NULL, NULL, NULL, NULL, 'Bergeronnette grise ou de Yarrell', NULL, 'Chordés', 'Oiseaux', NULL),
	(-3741, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Motacillidae', NULL, NULL, NULL, 194916, -3741, 'Motacilla flava / tschutschensis', NULL, NULL, NULL, NULL, 'Bergeronnette printanière / orientale', NULL, 'Chordés', 'Oiseaux', NULL),
	(-2787, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Accipitriformes', 'Accipitridae', NULL, NULL, NULL, 190851, -2787, 'Circus pygargus / cyaneus', NULL, NULL, NULL, NULL, 'Busard cendré / Saint-Martin', NULL, 'Chordés', 'Oiseaux', NULL),
	(-2788, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Accipitriformes', 'Accipitridae', NULL, NULL, NULL, 190851, -2788, 'Circus macrourus / pygargus', NULL, NULL, NULL, NULL, 'Busard pâle / cendré', NULL, 'Chordés', 'Oiseaux', NULL),
	(-441709, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, NULL, 441709, -441709, 'Cairina moschata f. domestica', NULL, NULL, NULL, NULL, 'Canard de Barbarie', NULL, 'Chordés', 'Oiseaux', NULL),
	(-199501, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Fringillidae', NULL, NULL, NULL, 199501, -199501, 'Serinus canaria f. domestica', NULL, NULL, NULL, NULL, 'Canari', NULL, 'Chordés', 'Oiseaux', NULL),
	(-3656, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Alaudidae', NULL, NULL, NULL, 192683, -3656, 'Galerida cristata / theklae', NULL, NULL, NULL, NULL, 'Cochevis huppé / de Thékla', NULL, 'Chordés', 'Oiseaux', NULL),
	(-3482, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Strigiformes', 'Tytonidae', NULL, NULL, NULL, 3482, -3482, 'Tyto alba alba', NULL, NULL, NULL, NULL, 'Effraie des clochers (T.a.alba)', NULL, 'Chordés', 'Oiseaux', NULL),
	(-3483, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Strigiformes', 'Tytonidae', NULL, NULL, NULL, 3482, -3483, 'Tyto alba guttata', NULL, NULL, NULL, NULL, 'Effraie des clochers (T.a.guttata)', NULL, 'Chordés', 'Oiseaux', NULL),
	(-1958, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, NULL, 189130, -1958, 'Anas crecca / querquedula', NULL, NULL, NULL, NULL, 'Sarcelle d''hiver / d''été', NULL, 'Chordés', 'Oiseaux', NULL),
	(-4518, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Sturnidae', NULL, NULL, NULL, 198063, -4518, 'Sturnus unicolor / vulgaris', NULL, NULL, NULL, NULL, 'Étourneau unicolore ou sansonnet', NULL, 'Chordés', 'Oiseaux', NULL),
	(-2669, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Falconiformes', 'Falconidae', NULL, NULL, NULL, 192519, -2669, 'Falco naumanni / tinnunculus', NULL, NULL, NULL, NULL, 'Faucon crécerellette ou crécerelle', NULL, 'Chordés', 'Oiseaux', NULL),
	(-4229, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Sylviidae', NULL, NULL, NULL, 198113, -4229, 'Sylvia cantillans / subalpina', NULL, NULL, NULL, NULL, 'Fauvette passerinette ou de Moltoni', NULL, 'Chordés', 'Oiseaux', NULL),
	(-189690, NULL, NULL, 'RGN', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, NULL, 189690, -189690, 'Aythya sp x Aythya sp.', NULL, NULL, NULL, NULL, 'Fuligule hybride indéterminé', NULL, 'Chordés', 'Oiseaux', NULL),
	(-1998, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, NULL, 189690, -1998, 'Aythya fuligula / marila', NULL, NULL, NULL, NULL, 'Fuligule morillon ou milouinan', NULL, 'Chordés', 'Oiseaux', NULL),
	(-79321, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79321, 'Myotis bechsteinii / brandtii', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt', NULL, 'Chordés', 'Mammifères', NULL),
	(-79322, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79322, 'Myotis bechsteinii / brandtii / daubentonii', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt / Daubenton', NULL, 'Chordés', 'Mammifères', NULL),
	(-79323, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79323, 'Myotis bechsteinii / brandtii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt / émarginé', NULL, 'Chordés', 'Mammifères', NULL),
	(-79324, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79324, 'Myotis bechsteinii / brandtii / myotis-bly', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt / grande taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-79333, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79333, 'Myotis alcathoe / emarginatus / mystacinus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / émarginé / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79341, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79341, 'Myotis emarginatus / mystacinus', NULL, NULL, NULL, NULL, 'Murin émarginé / moustaches', NULL, 'Chordés', 'Mammifères', NULL),
	(-79342, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79342, 'Myotis natterreri / blythii', NULL, NULL, NULL, NULL, 'Murin de Natterer / Petit murin', NULL, 'Chordés', 'Mammifères', NULL),
	(-79343, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL, NULL, 195005, -79343, 'Myotis pt taille sp.', NULL, NULL, NULL, NULL, 'Murin de petite taille', NULL, 'Chordés', 'Mammifères', NULL),
	(-4494, NULL, NULL, 'RSES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Corvidae', NULL, NULL, NULL, 4494, -4494, 'Corvus monedula monedula / soemmeringgii', NULL, NULL, NULL, NULL, 'Choucas des tours de type nordique / oriental', NULL, 'Chordés', 'Oiseaux', NULL),
	(-4503, NULL, NULL, 'RSES', 'Animalia', 'Chordata', 'Aves', 'Passeriformes', 'Corvidae', NULL, NULL, NULL, 4503, -4503, 'Corvus corone / cornix', NULL, NULL, NULL, NULL, 'Corneille noire ou mantelée', NULL, 'Chordés', 'Oiseaux', NULL),
	(-2938, NULL, NULL, 'RSES', 'Animalia', 'Chordata', 'Aves', 'Falconiformes', 'Falconidae', NULL, NULL, NULL, 2938, -2938, 'Falco peregrinus calidus / tundrius', NULL, NULL, NULL, NULL, 'Faucon pèlerin de type toundra', NULL, 'Chordés', 'Oiseaux', NULL),
	(-185167, NULL, NULL, 'RGN', 'Animalia', 'Chordata', 'Aves', 'Anseriformes', 'Anatidae', 'Anatinae', NULL, NULL, 185167, -185167, 'Anatidae sp. x Anatidae sp.', NULL, NULL, NULL, NULL, 'Canard hybride', NULL, 'Chordés', 'Oiseaux', NULL),
	(-1411, NULL, NULL, 'SSES', 'Animalia', 'Chordata', 'Aves', 'Charadriiformes', 'Scolopacidae', NULL, NULL, NULL, 1411, -1411, 'Numenius arquata orientalis', NULL, NULL, NULL, NULL, 'Courlis cendré (N.a.orientalis)', NULL, NULL, NULL, NULL);


--
-- Name: t_c_taxref_ajout t_c_taxref_ajout_pk; Type: CONSTRAINT; Schema: taxonomie; Owner: -
--

ALTER TABLE ONLY taxonomie.t_c_taxref_ajout
    ADD CONSTRAINT t_c_taxref_ajout_pk PRIMARY KEY (cd_nom);


INSERT INTO taxonomie.taxref( cd_nom, id_statut, id_habitat, id_rang, regne, phylum, classe, ordre, famille
                            , sous_famille, tribu, cd_taxsup, cd_sup, cd_ref, lb_nom, lb_auteur, nom_complet
                            , nom_complet_html, nom_valide, nom_vern, nom_vern_eng, group1_inpn, group2_inpn, url)
SELECT cd_nom
     , id_statut
     , id_habitat
     , id_rang
     , regne
     , phylum
     , classe
     , ordre
     , famille
     , sous_famille
     , tribu
     , cd_taxsup
     , cd_sup
     , cd_ref
     , lb_nom
     , lb_auteur
     , nom_complet
     , nom_complet_html
     , nom_valide
     , nom_vern
     , nom_vern_eng
     , group1_inpn
     , group2_inpn
     , url
FROM taxonomie.t_c_taxref_ajout
ON CONFLICT DO NOTHING;
