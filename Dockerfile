FROM coreoasis/builtin_keys_server:latest

COPY /src/keys_server/PiWind/KeysServer.ini /var/www/oasis/oasis_keys_server/ 
COPY ["./keys_data/PiWind/", \
      "/var/oasis/keys_data/"]

RUN chown -R www-data:www-data /var/oasis/keys_data && \
    chmod -R 744 /var/oasis/keys_data

ENTRYPOINT ["/bin/sh", "-c", "startup.sh"]