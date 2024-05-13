#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] won't have any Hive privileges."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo ""
echo "- INFO: User [spark] shouldn't be able to run select table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "select * from $DEFAULT_DB.$TABLE_ANIMALS")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [SELECT] privilege")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
