#!/bin/bash

CURRENT_ENV="local"

# Update according to the config value. The value is in seconds.
POLICIES_UPDATE_INTERVAL=10

# Ranger users.
HDFS_USER="hadoop"
HIVE_USER="hive"
SPARK_USER1="spark"
SPARK_USER2="test1"
TRINO_USER1="trino"
TRINO_USER2="games"

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
HIVE_WAREHOUSE_PARENT_DIR="opt/hive"
EXTERNAL_HIVE_DB_PATH="data/projects"
HIVE_GROSS_TEST_DIR="$EXTERNAL_HIVE_DB_PATH/gross_test"
HIVE_GROSS_DB_TEST_DIR="$HIVE_GROSS_TEST_DIR/gross_test.db"

# Test file names.
COMMON_UTILS_FILE="CommonUtils.scala"
TMP_COMBINED_FILE="tmp_combined.scala"
TEST_CMD_SUCCESS_FILE="test_cmd_success.scala"
TEST_CMD_FAILURE_FILE="test_cmd_failure.scala"

# Trino variables.
TRINO_TMP_OUTPUT_FILE="trino_output_tmp.txt"
TRINO_HIVE_SCHEMA="hive"
