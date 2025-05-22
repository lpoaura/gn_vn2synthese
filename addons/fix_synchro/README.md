# Correctif aux problèmes de synchro (données manquantes)

## Principe

Il peut arriver que des données soient manquantes, suite à des erreurs de 
synchro (erreurs d'API notamment).

Afin de palier à ces aléas, la LPO AuRA a mis en place une synchronisation 
parallèle des données dans un schéma distinct et des routines pour
mettre à jour les données de la synchro principale.

Le principe est le suivant&nbsp;:

- Mise en place d'une seconde synchronisation des données > 
  Les données sont donc dupliquées en base de données
- Tous les jours, une mise à jour (`transfer_vn --update`) des données est réalisée.
- Toutes les semaines, un téléchargement complet est réalisé sur les 2 dernières semaines. 
  Le script `transfer_vn_full_2w.sh` met alors automatiquement à jour la valeur `start_ts`
  du fichier de configuration de l'appli Client-API-VN.
- Suite à ce téléchargement hebdomadaire (sur les 2 dernières semaines), le script 
  `transfer_vn_full_2w.sh` se termine par l'exécution en base de donnée de la fonction 
  `src_vn_json_check.fct_fix_sync()` qui insère les données manquantes ou met à jour 
  les données qui ne le sont pas.

> [!WARNING]
> Les suppressions possiblement non réalisées ne peuvent être corrigées en l'état


## Mise en place

1. Créer un compte utilisateur

L'application Client-API-VN v2 ne permet pas d'exécuter plusieurs synchronisations 
sur un même compte utilisateur, il faut donc créer un nouveau compte système pour
cette synchronisation. La connexion à la bdd depuis le script `transfer_vn_full_2w.sh`
s'effectue via des services configurés dans les fichiers 
[`~/.pg_services.conf`](https://www.postgresql.org/docs/current/libpq-pgservice.html) 
et [`~/.pgpass`](https://www.postgresql.org/docs/current/libpq-pgpass.html).

2. Installer le client-api-vn pour ce compte :

```bash
python -m venv .venv.clientapivn
source .venv.clientapivn/bin/activate
pip install Client-API-VN
```
3. Réaliser un premier import complet dans le schéma spécifique `src_vn_json_check`
4. Mettre en place et lancer la synchro quotidienne (tache cron)
5. Exécuter en bdd le script sql `fix_synchro.sql` (**une seule fois**) pour installer 
   les vues matérialisées et fonctions nécessaires à la correction des données:

```psql service=<mon service pgsql> -f fix_synchro.sql```

6. Copier à la racine du dossier utilisateur le fichier `transfer_vn_full_2w.sh`
7. Vous pouvez vérifier son fonctionnement en le lançant manuellement : 

```bash
# transfer_vn_full_2w.sh <mon fichier de config ClientApiVN> <mon service pgsql>
transfer_vn_full_2w.sh evn.yaml geonature
```
Attention, cela peut être long, il est recommandé de le lancer dans un terminal screen ou tmux.

8. Mettre en place une tache cron hebdomadaire pour exécuter cette commande.

Le suivi des mises à jour effectuées sur le schéma principal de production peut être consulté 
dans la table `dbadmin.monitoring_vn_check_to_prod`.

Si l'envoie de mail est configurée sur le serveur, vous pouvez ajouter une adresse mail à 
l'exécution de la fonction `src_vn_json_check.fct_fix_sync('<mon adresse mail>')` dans le
script bash `transfer_vn_full_2w.sh`. Cela enverra automatiquement un email en fin d'exécution 
au destinataire via la fonctionne nouvellement créée 
`dbadmin.email_notify(message TEXT, subject CHARACTER VARYING, recipient CHARACTER VARYING)`.
