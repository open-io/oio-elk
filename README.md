

## Demarrer le container openio sds
*  demarrage simple

`docker run -d -p 6007:6007 openio/sds`
* démarrage en recupérant créant un volume pour les fichiers logs

## Activer les logs au niveau du container
`docker run -d -p 6007:6007 -v ~/logs:/tmp:logs openio/sds`
 ## créer un lien symnbolique

`input(type="imuxsock" Socket="/dev/log" CreatePath="on")`
A ajouter sous `$ModLoad imuxsock` dans `/etc/rsyslog.conf`
Puis redémarrer les services avec `gridinit_cmd restart`
