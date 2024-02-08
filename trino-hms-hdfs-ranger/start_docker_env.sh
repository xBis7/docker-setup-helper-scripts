#!/bin/bash

source "./testlib.sh"

abs_path=$1

# Hadoop depends on the Ranger network and 
# Hive and Trino depend on the Hadoop network.

# The environments need to be started in this particular order
# 1. Ranger
# 2. Hadoop
# 3. Hive
# 4. Trino

ranger_docker_path="$abs_path/$PROJECT_RANGER/dev-support/ranger-docker"
hadoop_docker_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/compose/hadoop"
hive_docker_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-3.1.3-bin/apache-hive-3.1.3-bin/compose/hive-metastore-ranger"
trino_docker_path="$abs_path/$PROJECT_TRINO/core/docker/compose/trino-hms-hdfs"


echo "Starting '$PROJECT_RANGER' env."
cd $ranger_docker_path
export RANGER_DB_TYPE=postgres
docker-compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml up -d
echo "'$PROJECT_RANGER' env started."

echo "Starting '$PROJECT_HADOOP' env."
cd $hadoop_docker_path
export COMPOSE_FILE=docker-compose.yaml:ranger.yaml
docker-compose up -d --scale datanode=3
echo "'$PROJECT_HADOOP' env started."

#reset COMPOSE_FILE env variable
export COMPOSE_FILE=

echo "Starting '$PROJECT_HIVE' env."
cd $hive_docker_path
docker-compose up -d
echo "'$PROJECT_HIVE' env started."

echo "Starting '$PROJECT_TRINO' env."
cd $trino_docker_path
docker-compose up -d
echo "'$PROJECT_TRINO' env started."
