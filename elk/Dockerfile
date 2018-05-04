FROM sebp/elk

RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats && \
    /opt/elasticsearch/bin/elasticsearch-plugin install ingest-geoip

    # /opt/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3 && \
    # /opt/elasticsearch/bin/elasticsearch-plugin install cloud-aws && \
    # /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.access_key && \
    # /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.secret_key


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


#  echo "demo:demo" | bin/elasticsearch-keystore add --stdin --force s3.client.default.access_key
# echo "DEMO_PASS" | bin/elasticsearch-keystore add --stdin --force s3.client.default.secret_key
