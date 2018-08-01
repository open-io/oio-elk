Docker ELK + FILEBEAT+ OPENIO/SDS    
----------------------

> Tools versions:  
- ELK : version 6.2.4   
- Filebeat : Version 6.2.4  
- Openio/sds: version 17.04


#### Requirement
 [Install docker](https://docs.docker.com/install/)   
 [Install docker-compose](https://docs.docker.com/compose/install/)

## Setup

### Clone the repository

 ```
 $ git clone https://github.com/openio/oio-elk && cd oio-elk
 ```

###  Increase host's virtual memory
  ```
  $ sudo sysctl -w vm.max_map_count=262144
  ```
### Run container(s)

#### a. Run ELK container
 ```
 $ docker-compose up  --build elk
 ```

#### b. Test all the stack (elk + openio-sds_17.04 + Filebeat)

If you want to test ELK-6.2.4 + openio-sds_17.04 + Filebeat-6.2.4 in local, you just need to run the following command:
 ```
 $ docker-compose up --build
 ```

### Set cluster's access control

After that container ElK startup, you will need to inialise the access control of the cluster.

```
$ docker-compose exec -T elk /etc/elasticsearch/bin/sgadmin_install.sh  
```

### Logging to kibana

Go to `http://[IP_HOST]:5601` and

Login: openio   
Password: openio
__________________________________________________________________________________
