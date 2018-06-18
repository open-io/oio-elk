#!/bin/bash
/opt/elasticsearch/plugins/search-guard-6/tools/sgadmin.sh \
	-cd /etc/elasticsearch/sgconfig/ \
	-ts /etc/elasticsearch/sgconfig/truststore.jks \
	-tspass changeit \
	-ks /etc/elasticsearch/sgconfig/kirk-keystore.jks  \
	-kspass changeit \
	-nhnv \
	-icl
