#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
dump_file_name=$2

dump_file_path="$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/ranger_dumps/ranger-$RANGER_DB_DUMP_VERSION/$dump_file_name.sql"

if docker exec -it ranger-postgres pg_dump -U rangeradmin ranger > "$dump_file_path"; then
  echo "Created file dump."
else
  echo "Creating file dump failed."
fi
