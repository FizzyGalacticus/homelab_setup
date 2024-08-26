FROM postgres:16

ENV POSTGRES_MULTIPLE_DATABASES=

COPY create_user.sh /bin/create_user.sh

RUN chmod +x /bin/create_user.sh
RUN ln -s create_user /docker-entrypoint-initdb.d/create_user.sh