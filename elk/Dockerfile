FROM sebp/elk

# RUN apt-get update -y && \
#    apt-get upgrade -y
RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats
RUN /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
