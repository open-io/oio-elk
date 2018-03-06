
Les outils d'analyse de log open-source
------

## 1. ELK

ELK est une offre composée de 3 outils :

* **Elasticsearch** qui est un moteur de recherche orienté document facilement scalable pour répondre à de gros volumes
* **Logstash** qui permet de configurer des flux d’entrées et des flux de sorties (un fichier lu et envoyé vers Elasticsearch par exemple)
* **Kibana** qui est une IHM permettant de consulter les documents d’une base Elasticsearch et d’en sortir des tableaux de bords

#### Avantages
- Kibana est très complet avec de nombreux widgets : camembert, graphique, mappemonde
- Solution rapide à mettre  en place suivant les besoins
- Permet de  développer ses propres outils pour gérer les alertes par exemple (X-PACK).
- Permet de déchiffrer des coordonnées géographiques à partir d'adresses IP
- traite des données de toutes formes, tailles et sources en simultané (Pipeline & Grok)
- documentation facile à comprendre

#### Incovénients
- Kibana ne gère cependant pas d’authentification utilisateur, Elastic propose pour cela un autre outil **Shield**  mais qui est payant.
- Il n’est pas possible de recevoir des alertes sur des conditions précises, , un outil peut être utilisé **Watcher** mais il est soumis à l’achat d’une licence.
- problème à supprimer  les anciens logs


## 2. Les logs shippers

un *log shipper*  doit pouvoir remplir 3 différentes fonctions que sont :
- d'aller chercher les données depuis la source
- pouvoir traiter ces données (ajouter un timestamp, de pouvoir structurer les données et d'ajouter une information de géolocalisation basée sur l'adresse IP)
- transmettre les données à un moteur de recherche

### 2.1. Logstash


#### Points forts
* bénéficie de plusieurs plugins (entrées, codecs, filtres et sorties) qui permettent la transformation et l'enrichissement  des données
#### Points faibles
* La performance, consomme une mémoire importante

### 2.2. RsysLog
**Rsyslog** implemente **Syslog**



#### Points forts
- Très efficace lorsque vous voulez analyser plusieurs sources car son module **mmnormaliser** fonctionne à vitesse constante
- L'un des analyseurs les plus rapides sur le marché, en fonction des mémoires tampons configurées. (100 à MB RAM)
#### Points faibles
 - limite la machine hote en bande passante


### 2.3. FileBeat
Filebeat est un léger Log shipper , il a été conçu pour remédier à la faiblesse de Logstash.

#### Points forts
- Filebeat lit et transfère les lignes de logs et, en cas d'interruption, reprend de là où il en était au retour de la connexion
- il est doté de module pouvant qui facilite la collecte et l'analyse de différents formats de logs ( Apache, nginx, Mysql)
- il peut transférer les données à logstash ou à Elasticsearch dans ce cas Elasticsearch jouera le role de parser et de stockage des données
- il supporte l'encryption SSL and TLS

#### Points faibles
* il ne peut ni transformer, ni filtrer, ni parser les données


## 3. Graylog

#### fonctionnalités:
* la rétention des données (offre la possibilité de créer plusieurs index)
* système d'alerte détaillant
* système de pipeline
* le collector sidecar

Graylog est composé de 3 briques :

* **Elasticsearch** qui est le moteur d’indexation des documents
* **Mongodb** qui est une base NoSQL permettant de stocker la configuration et quelques autres paramètres
* **Graylog-server** et **graylog-web-interface** pour la collecte et la visualisation des logs


####  Avantages
- Dès lors qu’une entreprise aura besoin d’une authentification pour les utilisateurs et d’alertes pour pouvoir agir rapidement, la solution Graylog sera la plus à même de répondre au besoin.
- Les droits d’accès : l’accès à l’interface web nécessite un login et un mot de passe. L’outil propose également une gestion de droit complète permettant de définir les accès aux streams et dashboard pour chaque utilisateur. Il est même possible de brancher Graylog avec le LDAP de votre entreprise
- des streams : un stream permet de catégoriser vos logs.
- des alertes : sur chaque stream, il est possible de définir des alertes afin d’être prévenu s’il y a plus de 10 logs d’erreur sur les 5 dernières minutes par exemple. L’alerte peut être de différents types : par mail, par message slack...


#### Incovénients
- Le dashboard possède moins de widgets que Kibana
