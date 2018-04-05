
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
Kibana  va permettre de consulter les données de la base Elasticsearch et d’en construire les graphes du dashboard.


#### Éxigence
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
#### Changer les droits
Pour pouvoir partager le répertoire e log entre le container openio/sds et notre machine hôte, il est important de changer les droits pour permettre aux différents services de la solution de stockage de pouvoir modifier les fichiers logs. Sans cela il n'est pas possible de lancer les conteneurs correctement
```
sudo find openio/log/ -type d -exec chmod 777 {} \;
```
```
sudo find openio/log/ -type f -exec chmod 666 {} \;
```

#### Lancer les services
* En mode verbose   
```
$ docker-compose up
```
* Lancement en arrière-plan  
```
$ docker-compose up -d
```
#### Arrêter les services  
```
$ docker-compose stop
```


#### Elastic curator
Afin de maintenir notre infrastructures propres et de reduire le temps de réponse des requêtes, il important de procéder fréquemment aux nettoyages de nos index, car ces derniers consomment  beaucoup de ressources (CPU,RAM, disques).

Elastic curator permet de supprimer des données suivant certains caractères, il existe 2 manières pour le faire:

##### Curator_cli

- supprimer les données qui datent de plus de 10 jours
```
$ curator_cli --host 127.0.0.1 delete_indices --filter_list '{"filtertype":"age","source":"creation_date","timestring":"%Y.%m.%d","unit":"days","unit_count":10,"direction":"older"}'

```
- ou à partir de fichier de configuration
##### Action file

le fichier `curator.yml` contenant les informations sur le cluster elasticsearch

```
---
# Remember, leave a key empty if there is no value.  None will be a string,
# not a Python "NoneType"
client:
  hosts:
    - 127.0.0.1
  port: 9200
  url_prefix:
  use_ssl: False
  certificate:
  client_cert:
  client_key:
  ssl_no_validate: False
  http_auth:
  timeout: 30
  master_only: False

logging:
  loglevel: INFO
  logfile:
  logformat: default
  blacklist: ['elasticsearch', 'urllib3']

```
 le fichier `delete_indices.yml` contenant les actions à réaliser

```
actions:
  1:
    action: delete_indices
    description: >-
      Delete indices older than 30 days based on oio- prefixed indices
    options:
      ignore_empty_list: True
      disable_action: True
    filters:
    - filtertype: pattern
      kind: prefix
      value: oio-
    - filtertype: age
      source: creation_date
      timestring: '%Y.%m.%d'
      unit: days
      unit_count: 30
      direction: older
  2:
    action: delete_indices
    description: >-
      Delete indices when space raise 100G, based on oio- prefixed indices.
    options:
      ignore_empty_list: True
      disable_action: True
    filters:
    - filtertype: space
      disk_space: 100
      use_age: True
      source: creation_date
    - filtertype: pattern
      kind: prefix
      value: oio-
```

```
$ /usr/bin/curator ./delete_indices.yml --config ./curator.yml
```

--------------
## Quelques erreurs rencontrées fréquemment

### 1. Problème de démmarage de Elasticsearch
`max virtual memory areas vm.max_map_count [65530] likely too low, increase to at least [262144]` cette erreur est souvent rencontrée lorsqu'on démarre le service, cela juste dû à une mémoire virtuelle trope petite pour lancer Elasticsearch.

La commande suivante permet d'augmenter cette mémoire virtuelle.

```
$ sudo sysctl -w vm.max_map_count=262144
```
#### 2. Problème de droit de filebeat.yml
`Exiting: error loading config file: config file ("filebeat.yml") must be owned by the beat user (uid=0) or root`


```
$ chmod go-w chemin_vers/filebeat.yml
```

#### 3. Problème de droit du répetoire contenant les fichiers logs
`TODO`

```
$ chmod -R 777 chemin_du_répertoire
```
-------------------------------

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
