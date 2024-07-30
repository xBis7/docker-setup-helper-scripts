#!/bin/bash

source "./testlib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: User [trino] has HDFS permissions but no Hive permissions."
echo "- INFO: Dropping a database should fail."
echo ""

command="drop schema hive.$EXTERNAL_DB"
expectedMsg="Permission denied: user [trino] does not have [DROP] privilege on [$EXTERNAL_DB]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"


