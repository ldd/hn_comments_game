#!/bin/bash
source .env

psql postgres -c "CREATE USER $POSTGRES_USER with PASSWORD '$POSTGRES_PASSWORD';"
psql postgres -c "DROP DATABASE $DB_NAME;"
psql postgres -c "CREATE DATABASE $DB_NAME;"
psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME to $POSTGRES_USER;"
