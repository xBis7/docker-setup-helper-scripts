#!/bin/bash

abs_path=$1
dump_file_name=$2

dump_file_path="$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/ranger_dumps/$dump_file_name.sql"

docker exec -it ranger-postgres pg_dump -U rangeradmin ranger > "$dump_file_path"

echo "Created file dump."
