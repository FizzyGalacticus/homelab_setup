#!/bin/bash

set -e

function create_user_and_database() {
	local database=$1
    local sql="CREATE USER $database WITH PASSWORD '$database'; CREATE DATABASE $database; GRANT ALL PRIVILEGES ON DATABASE $database TO $database; ALTER DATABASE $database OWNER TO $database;"
	
    echo "  Creating user and database '$database'"

	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    $sql
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Multiple databases created"
fi

if [ -n "$1" ]; then
    create_user_and_database $1
fi