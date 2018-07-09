FROM sebp/elk:624


RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats


## Installation de Elasticsearch curator
RUN apt-get install wget && \
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian stable main" >> /etc/apt/sources.list.d/curator.list && \
    apt-get update -y && \
    apt-get install elasticsearch-curator -y && \
    echo "58 23 * * * /usr/bin/curator /opt/elasticsearch/curator/snapshot.yml --config /opt/elasticsearch/curator/curator.yml" >> /var/spool/cron/crontabs/curator && \
    echo "59 23 * * * /usr/bin/curator /opt/elasticsearch/curator/delete_indices.yml --config /opt/elasticsearch/curator/curator.yml" >> /var/spool/cron/crontabs/curator && \
    crontab -u root /var/spool/cron/crontabs/curator


# create a directory for the log backup
RUN mkdir /opt/repo_snapshots && \
    chown -R elasticsearch:elasticsearch /opt/repo_snapshots




#Installation and configuration of aws s3 plugins for snapshot
RUN /opt/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
RUN /opt/elasticsearch/bin/elasticsearch-keystore create && \
    # echo "cbcf7f62497845518ddf573049d885ef" | /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.access_key && \
    # echo "a241d07e9db64f68a38d68868ed42712" | /opt/elasticsearch/bin/elasticsearch-keystore add s3.client.default.secret_key && \
    chown root:elasticsearch /etc/elasticsearch/elasticsearch.keystore


# Installation and configuration of search GUARD
RUN /opt/elasticsearch/bin/elasticsearch-plugin install --batch com.floragunn:search-guard-6:6.2.4-22.1 && \
    chmod +x /opt/elasticsearch/plugins/search-guard-6/tools/*.sh
RUN /opt/kibana/bin/kibana-plugin install https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.2.4-13/search-guard-kibana-plugin-6.2.4-13.zip


## Install Sentinl
# RUN /opt/kibana/bin/kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.3-3/sentinl-v6.2.4.zip
