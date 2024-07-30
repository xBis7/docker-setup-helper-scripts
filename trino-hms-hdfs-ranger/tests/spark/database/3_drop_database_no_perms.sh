#!/bin/bash

source "./testlib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop database."

command="spark.sql(\"drop database if exists $EXTERNAL_DB cascade\")"
expectedMsg="Permission denied: user [spark] does not have [DROP] privilege on [$EXTERNAL_DB]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"
