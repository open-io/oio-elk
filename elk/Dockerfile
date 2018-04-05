FROM sebp/elk

RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip

## Installation de Elasticsearch curator
RUN apt-get install wget && \
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian stable main" >> /etc/apt/sources.list.d/curator.list && \
    apt-get update -y && \
    apt-get install elasticsearch-curator -y

#COPY ./elk/elasticsearch/curator/delete_indices.yml /tmp
