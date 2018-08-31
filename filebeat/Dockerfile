FROM docker.elastic.co/beats/filebeat:6.2.2
COPY config/filebeat.yml /usr/share/filebeat/filebeat.yml
USER root
RUN mkdir -p /var/log/oio/sds/OPENIO

RUN chown filebeat /usr/share/filebeat/filebeat.yml
RUN chmod go-w /usr/share/filebeat/filebeat.yml
RUN yum install net-tools -y
USER filebeat
