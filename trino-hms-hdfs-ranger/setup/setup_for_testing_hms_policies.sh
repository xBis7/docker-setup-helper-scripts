#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

# 'setup_for_trino_spark_testing' is setting up '$HIVE_BASE_POLICIES'.
# We don't need to repeat it here.
./setup/setup_for_trino_spark_testing.sh "$abs_path"

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:trino,spark"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
sleep 15

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $abs_path/$CURRENT_REPO/trino-hms-hdfs-ranger/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "$DEFAULT_DB.$SPARK_TABLE")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

trinoSuccessMsg="CREATE TABLE"
retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$successMsg" "false"
