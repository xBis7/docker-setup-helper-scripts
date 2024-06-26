#!/bin/bash

CURRENT_ENV="local"

# Update according to the config value. The value is in seconds.
POLICIES_UPDATE_INTERVAL=10

# Ranger users.
HDFS_USER="hadoop"
HIVE_USER="hive"
SPARK_USER1="spark"
SPARK_USER2="test1"
SPARK_USER3="test2"
SPARK_USER4="test3"

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
SETUP_CREATE_TABLE_FILE="setup_create_table.scala"
CREATE_DROP_DB_FILE="create_drop_db.scala"
CREATE_DROP_TABLE_FILE="create_drop_table.scala"
INSERT_SELECT_TABLE_WITH_ACCESS_FILE="insert_select_table_with_access.scala"
INSERT_SELECT_TABLE_NO_ACCESS_FILE="insert_select_table_no_access.scala"