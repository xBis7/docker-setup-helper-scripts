#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: User [trino] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty, without using CASCADE, should fail."

command="drop schema hive.$EXTERNAL_DB"
expectedMsg="Cannot drop non-empty schema '$EXTERNAL_DB'"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"
