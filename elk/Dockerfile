FROM sebp/elk

# RUN apt-get update -y && \
#    apt-get upgrade -y
RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
#    /opt/elasticsearch/bin/elasticsearch-plugin install x-pack && \
#    /opt/kibana/bin/kibana-plugin install x-pack
