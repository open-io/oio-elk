FROM sebp/elk



RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip



USER root
## Installation de Elasticsearch curator
RUN apt-get install wget && \
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian stable main" >> /etc/apt/sources.list.d/curator.list && \
    apt-get update -y && \
    apt-get install elasticsearch-curator -y && \
    echo "58 23 * * * /usr/bin/curator /opt/elasticsearch/curator/snapshot.yml --config /opt/elasticsearch/curator/curator.yml" >> /var/spool/cron/crontabs/curator && \
    echo "59 23 * * * /usr/bin/curator /opt/elasticsearch/curator/delete_indices.yml --config /opt/elasticsearch/curator/curator.yml" >> /var/spool/cron/crontabs/curator && \
    crontab -u root /var/spool/cron/crontabs/curator



RUN mkdir /opt/repo_snapshots && \
    chown -R elasticsearch:elasticsearch /opt/repo_snapshots




# curl -XPUT 'localhost:9200/_snapshot/oio_logs_backup' -H 'Content-Type: application/json' -d '{ "type": "fs", "settings": {"location": "/opt/repo_snapshots","compress": true}}'

# curl -XDELETE 'http://localhost:9200/oio-*?pretty'


## Installation and configuration of aws s3 plugins for snapshot

# RUN /opt/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
# RUN /opt/elasticsearch/bin/elasticsearch-keystore create && \
#     # /opt/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3 && \
#     echo "demo:demo" | /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.access_key && \
#     echo "DEMO_PASS" | /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.secret_key && \
#     # echo "192.168.1.43:6007" | /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.endpoint && \
#     chown root:elasticsearch /etc/elasticsearch/elasticsearch.keystore


# Installation and configuration of search GUARD
# RUN /opt/elasticsearch/bin/elasticsearch-plugin install --batch com.floragunn:search-guard-6:6.2.2-22.1 && \
#     curl -sL https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-tlstool/1.3/search-guard-tlstool-1.3.tar.gz | tar zx -C /opt/elasticsearch && \
#     ./opt/elasticsearch/tools/
#
#
#
# RUN /opt/kibana/bin/kibana-plugin install https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.2.2-11/search-guard-kibana-plugin-6.2.2-11.zip


## Install Sentinl
RUN opt/kibana/bin/kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.2/sentinl-v6.2.2.zip
