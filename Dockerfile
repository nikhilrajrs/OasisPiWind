FROM coreoasis/builtin_keys_server:latest

EXPOSE 8080

COPY /src/keys_server/PiWind/KeysServer.ini /var/www/oasis/oasis_keys_server/ 
COPY ["./keys_data/PiWind/", \
      "/var/oasis/keys_data/"]
COPY /startup.sh  /usr/local/bin/

USER root

RUN chmod +x /usr/local/bin/startup.sh

RUN mkdir -p /var/log/oasis && \
    touch /var/log/oasis/keys_server.log

RUN chgrp -R 0 /var/oasis/keys_data && \
    chmod -R g=u /var/oasis/keys_data && \
    chgrp -R 0 /var/log/oasis && \
    chmod -R g=u /var/log/oasis

USER 10001

ENTRYPOINT ["/bin/sh", "-c", "startup.sh"]