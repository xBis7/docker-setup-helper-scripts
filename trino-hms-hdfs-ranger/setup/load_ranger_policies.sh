#!/bin/bash

# This script assumes that the docker env is setup and all containers are up and running.

abs_path=$1
dump_file_name=$2

dump_file_path="$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/ranger_dumps/$dump_file_name.sql"

echo ""
echo "Stopping the Ranger container."
if docker stop ranger; then
  echo "Stopping ranger container succeeded."
else
  echo "Stopping ranger container failed. Exiting..."
  exit 1
fi

echo ""
echo "Dropping the old populated ranger DB."
if docker exec -it ranger-postgres psql -U postgres -d postgres -c "DROP DATABASE ranger"; then
  echo "Dropping the old populated ranger DB succeeded."
else
  echo "Dropping the old populated ranger DB failed. Exiting..."
  exit 1
fi

echo ""
echo "Creating a new empty ranger DB."
if docker exec -it ranger-postgres psql -U postgres -d postgres -c "CREATE DATABASE ranger"; then
  echo "Creating a new empty ranger DB succeeded."
else
  echo "Creating a new empty ranger DB failed. Exiting..."
  exit 1
fi

echo ""
echo "Copying dump file '$dump_file_name.sql' under the Ranger container."
if docker cp "$dump_file_path" ranger-postgres:/dump.sql; then
  echo "Copying dump file '$dump_file_name.sql' under the Ranger container succeeded."
else
  echo "Copying dump file '$dump_file_name.sql' under the Ranger container failed. Exiting..."
  exit 1
fi

echo ""
echo "Populate the empty ranger DB with the '$dump_file_name.sql' contents."
# This is polluting the output a lot.
# TODO: find a way to hide the output.
if docker exec -it ranger-postgres psql -U rangeradmin -d ranger -f dump.sql; then
  echo "Populate the empty ranger DB with the '$dump_file_name.sql' contents succeeded."
else
  echo "Populate the empty ranger DB with the '$dump_file_name.sql' contents failed. Exiting..."
  exit 1
fi

echo ""
echo "Starting the Ranger container."
if docker start ranger; then
  echo "Starting the Ranger container succeeded."
else
  echo "Starting the Ranger container failed. Exiting..."
  exit 1
fi
