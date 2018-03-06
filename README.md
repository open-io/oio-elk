
 Docker ELK + FILEBEAT+ OPENIO/SDS   
----------------------

> les diiférentes versions des outils utilisés:  
- ELK : version 6.6.2   
- Filebeat : Version 6.6.2  
- Openio/sds: version 16.04


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
* En arrière plan  
```
$ docker-compose up -d
```











#### Activer les logs dans le container openio/sds
* Ajouter le socket /dev/log   
```
$ vi /etc/rsyslog.conf
```

  Ajoutez la ligne suivante juste après la ligne contenant  `$ModLoad imuxsock`   
  `input(type="imuxsock" Socket="/dev/log" CreatePath="on")`

*  Puis redémarrer les services avec
 ```
 $ gridinit_cmd restart
```
