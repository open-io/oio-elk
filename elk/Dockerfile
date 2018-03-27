FROM sebp/elk

RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip

## Installation de Elasticsearch curator
WORKDIR /opt/elasticsearch-curator
RUN apt-get update -y && \
    apt-get install elasticsearch-curator -y

#COPY ./elk/elasticsearch/curator/delete_indices.yml /tmp
