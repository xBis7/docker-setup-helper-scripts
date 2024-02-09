#!/bin/bash

source "./testlib.sh"

abs_path=$1

# We need to stop the docker environments in reverse order, 
# from the one we used to start them.

# This needs to be done, so that all docker networks will be properly removed.

# We need to stop Hive and Trino before Hadoop and Hadoop before Ranger.
# The order will be
# 1. Trino
# 2. Hive
# 3. Hadoop
# 4. Ranger

ranger_docker_path="$abs_path/$PROJECT_RANGER/dev-support/ranger-docker"
hadoop_docker_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/compose/hadoop"
hive_docker_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-3.1.3-bin/apache-hive-3.1.3-bin/compose/hive-metastore-ranger"
trino_docker_path="$abs_path/$PROJECT_TRINO/core/docker/compose/trino-hms-hdfs"

echo ""
echo "Stopping '$PROJECT_TRINO' env."
echo ""

cd $trino_docker_path
docker-compose down

echo ""
echo "'$PROJECT_TRINO' env stopped."
echo ""

echo ""
echo "Stopping '$PROJECT_HIVE' env."
echo ""

cd $hive_docker_path
docker-compose down

echo ""
echo "'$PROJECT_HIVE' env stopped."
echo ""

echo ""
echo "Stopping '$PROJECT_HADOOP' env."
echo ""

cd $hadoop_docker_path
docker-compose down

echo ""
echo "'$PROJECT_HADOOP' env stopped."
echo ""

echo ""
echo "Stopping '$PROJECT_RANGER' env."
echo ""

cd $ranger_docker_path
docker-compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml down

echo ""
echo "'$PROJECT_RANGER' env stopped."
echo ""
