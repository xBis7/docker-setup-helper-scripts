#!/bin/bash

CURRENT_ENV="local"

# Update according to the config value. The value is in seconds.
POLICIES_UPDATE_INTERVAL=10

# Hostnames.
NAMENODE_HOSTNAME="docker-namenode-1"
DN1_HOSTNAME="docker-datanode-1"
DN2_HOSTNAME="docker-datanode-2"
DN3_HOSTNAME="docker-datanode-3"

HMS_HOSTNAME="hive-metastore-ranger-hive-metastore-1"
HMS_POSTGRES_HOSTNAME="hive-metastore-ranger-postgres-1"

RANGER_HOSTNAME="ranger"
RANGER_POSTGRES_HOSTNAME="ranger-postgres"
RANGER_USERSYNC_HOSTNAME="ranger-usersync"

TRINO_HOSTNAME="trino-coordinator-1"

SPARK_MASTER_HOSTNAME="spark-master-1"
SPARK_WORKER1_HOSTNAME="spark-worker-1"

# Service Names.
NAMENODE_NAME="namenode"

# Env variables.
HIVE_WAREHOUSE_DIR="opt/hive/data"
EXTERNAL_HIVE_DB_PATH="data/projects"
HIVE_GROSS_TEST_DIR="$EXTERNAL_HIVE_DB_PATH/gross_test"
HIVE_GROSS_DB_TEST_DIR="$HIVE_GROSS_TEST_DIR/gross_test.db"

# Test file names.
COMMON_UTILS_FILE="CommonUtils.scala"
TMP_COMBINED_FILE="tmp_combined.scala"
TEST1_FILE="1_create_db_no_create_perm.scala"
TEST2_FILE="2_create_db_no_hdfs_perms.scala"
TEST3_FILE="3_create_db_with_hive_hdfs_perms.scala"

