#!/bin/bash

source "./testlib.sh"

# This script assumes that the docker env is setup and all containers are up and running.

abs_path=$1
dump_file_name=$2

dump_file_path="$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/ranger_dumps/$dump_file_name.sql"

echo "Stopping the Ranger container."
docker stop ranger

echo "Dropping the old populated ranger DB."
docker exec -it ranger-postgres psql -U postgres -d postgres -c "DROP DATABASE ranger"

echo "Creating a new empty ranger DB."
docker exec -it ranger-postgres psql -U postgres -d postgres -c "CREATE DATABASE ranger"

echo "Copying dump file '$dump_file_name.sql' under the Ranger container."
docker cp "$dump_file_path" ranger-postgres:/dump.sql

echo "Populate the empty ranger DB with the '$dump_file_name.sql' contents."
docker exec -it ranger-postgres psql -U rangeradmin -d ranger -f dump.sql

echo "Starting the Ranger container."
docker start ranger
