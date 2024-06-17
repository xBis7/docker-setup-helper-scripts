#!/bin/bash

CURRENT_ENV="local"

# Update according to the config value. The value is in seconds.
POLICIES_UPDATE_INTERVAL=10

# Ranger users.
HDFS_USER="hadoop"
HIVE_USER="postgres"
SPARK_USER1="spark"
SPARK_USER2="test1"

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
TEST1_FILE="1_create_db_no_create_perm.scala"
TEST2_FILE="2_create_db_no_hdfs_perms.scala"
TEST3_FILE="3_create_db_with_hive_hdfs_perms.scala"
TEST4_FILE="4_drop_db_as_another_user_with_no_perms.scala"
TEST5_FILE="5_drop_db_and_recreate_under_hive_warehouse_dir.scala"
TEST6_FILE="6_create_managed_db_with_hdfs_and_hive_url_perms.scala"
TEST7_AND_8_1_FILE="7_and_8_1_create_managed_table.scala"
TEST7_2_FILE="7_2_select_describe_drop.scala"
TEST8_2_FILE="8_2_access_managed_table_as_different_user.scala"
TEST8_3_FILE="8_3_insert_into_managed_table.scala"
TEST9_FILE="9_select_on_managed_table_without_perms_as_another_user.scala"
TEST10_FILE="10_ddl_ops_on_managed_table_as_different_user_with_no_perms.scala"
TEST11_1_FILE="11_1_repeat_10_using_external_table.scala"
TEST11_2_FILE="11_2_repeat_using_a_different_user.scala"
TEST11_3_FILE="11_3_repeat_ddl_using_a_different_user_no_perms.scala"