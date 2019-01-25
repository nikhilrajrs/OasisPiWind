FROM coreoasis/builtin_keys_server:latest

EXPOSE 8080 8081

COPY /src/keys_server/PiWind/KeysServer.ini /var/www/oasis/oasis_keys_server/ 
COPY ["./keys_data/PiWind/", \
      "/var/oasis/keys_data/"]
COPY startup.sh  /usr/local/bin/

USER root

COPY ports.conf /etc/apache2
COPY oasis.conf /etc/apache2/sites-available
COPY 000-default.conf /etc/apache2/sites-available

RUN chmod +x /usr/local/bin/startup.sh

RUN mkdir -p /var/log/oasis && \
    touch /var/log/oasis/keys_server.log

RUN chgrp -R 0 /var/oasis/keys_data && \
    chmod -R g=u /var/oasis/keys_data && \
    chgrp -R 0 /var/log/oasis && \
    chmod -R g=u /var/log/oasis && \
    chgrp -R 0 /var/log/apache2 && \
    chmod -R g=u /var/log/apache2

USER 10001

ENTRYPOINT ["/bin/sh", "-c", "startup.sh"]