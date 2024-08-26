FROM postgres:16

ENV POSTGRES_MULTIPLE_DATABASES=

COPY create_user.sh /bin/create_user.sh
COPY create_user.sh /docker-entrypoint-initdb.d/create_user.sh

RUN chmod +x /bin/create_user.sh
RUN chmod +x /docker-entrypoint-initdb.d/create_user.sh