
 Docker ELK + FILEBEAT+ OPENIO/SDS    
----------------------

> les diiférentes versions des outils utilisés:  
- ELK : version 6.6.2   
- Filebeat : Version 6.6.2  
- Openio/sds: version 16.04

#### but
Le projet consiste à mettre en place une solution d'analyses de logs et de proposer  un dashboard permettant de contrôler les différents plateformes de la solution de stockage de **OPENIO**

#### Travail à réaliser
Les fichiers logs que nous allons utilisé, sont générés par la solution de de stockage de OPENIO contenu dans le container **openio/sds**. Ces logs seront extraits par **Filebeat**  (log shipper) qui se chargera de les envoyer au conteneur contenant la stack **ELK**.  
Au niveau de la stack ELK composée de **Elasticsearch**  **Logstash** et **Kibana**.   Logstash se charge de transformer ces logs en données plus ou moins structurées avant de l'envoyer à **Elasticsearch** qui se charge de les stocker dans sa base.
Kibana  va permetttre de consulter les donnnées de la base Elasticsearch et d’en construire les graphes du dashboard


#### Prérequis
 [Installer docker](https://docs.docker.com/install/)   
 [Installer docker-compose ](https://docs.docker.com/compose/install/)

#### Cloner le dépôt

```
$ git clone https://github.com/papebadiane/docker-elkf
```

# Démarrer le service
```
$ cd docker-elkf
```
#### Lancement des containers
* En mode verbose   
```
$ docker-compose up
```
* Lancement en arrière-plan  
```
$ docker-compose up -d
```


#### Activer les logs dans le container openio/sds
* Ajouter le socket /dev/log   
```
$ vi /etc/rsyslog.conf
```

  Ajoutez la ligne suivante juste après la ligne contenant  "`$ModLoad imuxsock`"  
  `input(type="imuxsock" Socket="/dev/log" CreatePath="on")`

*  Ensuite redémarrer les services avec :
 ```
 $ gridinit_cmd restart
```
