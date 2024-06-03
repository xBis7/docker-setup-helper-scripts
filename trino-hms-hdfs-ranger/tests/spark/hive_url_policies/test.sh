#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "User 'spark' doesn't have access to create a table. Operation should fail."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $GROSS_TABLE_NAME (id INT, num INT) USING parquet LOCATION 'hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR'")
op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi
scala_msg=$(base64encode "Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
