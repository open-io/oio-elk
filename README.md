Docker ELK + FILEBEAT+ OPENIO/SDS    
----------------------

> les diiférentes versions des outils utilisés:  
- ELK : version 6.2.4   
- Filebeat : Version 6.2.4  
- Openio/sds: version 17.04


#### Requirement
 [Installer docker](https://docs.docker.com/install/)   
 [Installer docker-compose ](https://docs.docker.com/compose/install/)


 #### Clone the repository

 ```
 $ git clone https://github.com/papebadiane/docker-elkf
 ```


# Setup

 ```
 $ cd docker-elkf
 ```

#### increase host's virtual memory
  ```
  $ sudo sysctl -w vm.max_map_count=262144
  ```
### Run containers
 * if you just want run  stack ELK
 ```
 $ docker-compose up -d --build elk
 ```
 * if you just want run all containers from docker compose
 ```
 $ docker-compose up -d --build
 ```

___________________________________________________________________________________
### How manage data retention with Elastic curator

 In order to keep our infrastructures clean and to reduce the response time of requests, it is important to clean our indexes frequently, because they consume a lot of resources (CPU, RAM, disks).

 Elastic curator allows you to delete data according to certain characters, there are 2 ways to do this:

##### 1. Curator_cli

 - This next command permit to delete data older than 10 days

 ```
 $ curator_cli --host 127.0.0.1 delete_indices --filter_list '{"filtertype":"age","source":"creation_date","timestring":"%Y.%m.%d","unit":"days","unit_count":10,"direction":"older"}'

 ```
##### 2. Action file

The file `curator.yml` containing information about cluster elasticsearch

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
The file `delete_indices.yml` containing actions to do

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
       unit: days
       unit_count: 30
       direction: older

 ```

```
 $ /usr/bin/curator ./delete_indices.yml --config ./curator.yml
```

#### Activate openio/sds log on container
```
 $ vi /etc/rsyslog.conf
```

Add the following line juste after the line containing "`$ModLoad imuxsock`"  
`input(type="imuxsock" Socket="/dev/log" CreatePath="on")`  


* Now restart services

```
$ gridinit_cmd restart

```

##### Create un  backup

* Filesystem backup
```
$ curl -XPUT 'localhost:9200/_snapshot/oio_logs_backup' -H 'Content-Type: application/json' -d '{ "type": "fs", "settings": {"location": "/opt/repo_snapshots","compress": true}}'
```
* S3  backup
```
curl -XPUT 'localhost:9200/_snapshot/s3_repository' -H 'Content-Type: application/json' -d'
{
  "type": "s3",
  "settings": {
    "bucket": "test6",
    "region": "us-east-1",
    "server_side_encryption": false,
    "client": "default"
  }
}'
```
