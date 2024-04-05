#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

./setup/setup_for_trino_spark_testing.sh "$abs_path"

echo ""
echo "- INFO: Updating Ranger policies. Users [spark/postgres] will now have all access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $abs_path/$CURRENT_REPO/trino-hms-hdfs-ranger/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "$DEFAULT_DB.$SPARK_TABLE")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

trinoSuccessMsg="CREATE TABLE"
retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$successMsg" "false"
