FROM sebp/elk

RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip

## Installation de X-PACK
# RUN /opt/elasticsearch/bin/elasticsearch-plugin install x-pack && \
#       /opt/kibana/bin/kibana-plugin install x-pack

## Confguration de X-PACK
# RUN chown elasticsearch:elasticsearch /etc/elasticsearch/elasticsearch.keystore
# RUN chmod 666 /etc/elasticsearch/elasticsearch.keystore
# RUN /opt/elasticsearch/bin/x-pack/setup-passwords auto


## restart Elasticsearch
# CMD /opt/elasticsearch/bin/elasticsearch
