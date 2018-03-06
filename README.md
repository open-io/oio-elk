
Docker ELK + FILEBEAT+ OPENIO/SDS
----------------------
la version des containers utilisés:  
- ELK : version 6.6.2   
- Filebeat : Version 6.6.2  
- Openio/sds: version 16.04  

# Installation des paquets
#### Installer docker

#### Installer docker-compose


# Démarrer le service

#### Activer les logs dans le container openio/sds
* Ajouter le socket /dev/log   
``$ vi /etc/rsyslog.conf``

  Ajoutez la ligne suivante juste après la ligne contenant  `$ModLoad imuxsock`   
  `input(type="imuxsock" Socket="/dev/log" CreatePath="on")`

*  Puis redémarrer les services avec
 `$ gridinit_cmd restart`

#### Lancement des containers
* En mode verbose   
`$ docker-compose up`
* En arrière plan  
`$ docker-compose up -d `
