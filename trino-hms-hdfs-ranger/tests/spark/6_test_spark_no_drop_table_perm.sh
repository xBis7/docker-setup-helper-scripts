#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,alter:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Drop table."
echo "- INFO: User [spark] shouldn't be able to drop table."

command="spark.sql(\"drop table $DEFAULT_DB.$NEW_SPARK_TABLE_NAME\")"
expectedMsg="Permission denied: user [spark] does not have [DROP] privilege on [$DEFAULT_DB/$NEW_SPARK_TABLE_NAME]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"
