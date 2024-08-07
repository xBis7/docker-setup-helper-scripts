#!/bin/bash

CURRENT_ENV="local"

# Update according to the config value. The value is in seconds.
POLICIES_UPDATE_INTERVAL=10

# Ranger users.
SPARK_USER1="spark"
SPARK_USER2="test1"
SPARK_USER3="test2"
SPARK_USER4="test3"
TRINO_USER1="trino"
TRINO_USER2="games"

# Hostnames.
DN1_HOSTNAME="docker-datanode-1"
SPARK_MASTER_HOSTNAME="spark-master-1"
TRINO_HOSTNAME="trino-coordinator-1"

# Service Names.
NAMENODE_NAME="namenode"

# Env variables.
# Don't use a leading / in any of the paths, so that the tests can add it where needed.
# For example we could have something like 'namenode/$HIVE_WAREHOUSE_DIR'.
# If the HIVE_WAREHOUSE_DIR had a leading /, then the above example would turn out
# to be 'namenode//opt/hive/data'.
HIVE_WAREHOUSE_DIR="opt/hive/data"
HIVE_WAREHOUSE_PARENT_DIR="opt/hive"
HIVE_WAREHOUSE_ROOT_DIR="opt"
EXTERNAL_HIVE_DB_PATH="data/projects"
EXTERNAL_HIVE_DB_PARENT_PATH="data"
HIVE_GROSS_TEST_DIR="$EXTERNAL_HIVE_DB_PATH/gross_test"
HIVE_GROSS_DB_TEST_DIR="$HIVE_GROSS_TEST_DIR/gross_test.db"
TRINO_HIVE_SCHEMA="hive"
TRINO_HIVE_WAREHOUSE_DIR="$HIVE_WAREHOUSE_DIR"
TRINO_HIVE_WAREHOUSE_PARENT_DIR="$HIVE_WAREHOUSE_PARENT_DIR"
LOAD_TESTS_DB_LOCATION="/$EXTERNAL_HIVE_DB_PATH/gross_load_tests/gross_test.db"

# Test file names for Spark-testing.
TEST_CMD_FILE="TestCmd.scala"

# Test file names for load-testing.
SETUP_CREATE_TABLE_FILE="setup_create_table.scala"
CREATE_DROP_DB_FILE="create_drop_db.scala"
CREATE_DROP_TABLE_FILE="create_drop_table.scala"
INSERT_SELECT_TABLE_WITH_ACCESS_FILE="insert_select_table_with_access.scala"
INSERT_SELECT_TABLE_NO_ACCESS_FILE="insert_select_table_no_access.scala"

# Trino variables.
TRINO_TMP_OUTPUT_FILE="trino_output_tmp.txt"
TRINO_HIVE_SCHEMA="hive"

# c3-specific
HDFS_USER=
HDFS_HOSTNAME=
SPARK_PATH=
TEST_FILES_DIR_PATH=
LOAD_TEST_FILES_DIR_PATH=
SIGNIN_PROFILE_SVC_ACCESS_TOKEN_BASE64=
SIGNIN_PROFILE_USER_ACCESS_TOKEN_BASE64=
KRB_KEYTAB_PATH=
KRB_KEYTAB_SUFFIX=
KRB_REALM=
TRINO_BIN_PATH=
