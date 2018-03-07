FROM openio/sds

# COPY etc/rsyslog.config /etc
# RUN gridinit_cmd restart
RUN chown -R openio:openio /var/log/oio
RUN rsyslogd

# RUN chown -R root:root /var/log/oio
# RUN find /var/log/oio -type f -exec chmod 666 {} \;
# RUN find /var/log/oio -type d -exec chmod 666 {} \;
# RUN ln -s /var/log/oio/sds/OPENIO /home/logs
