#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has no Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."

updateHiveDbAllPolicy "select,read:spark,trino"
waitForPoliciesUpdate

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "$EXTERNAL_DB.$SPARK_TABLE")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [CREATE] privilege on [$EXTERNAL_DB/$SPARK_TABLE]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
