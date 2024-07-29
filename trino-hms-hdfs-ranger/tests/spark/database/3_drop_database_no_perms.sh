#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop database."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop database if exists $EXTERNAL_DB cascade")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [DROP] privilege on [$EXTERNAL_DB]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
