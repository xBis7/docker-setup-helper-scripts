#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] won't have any Hive privileges."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: User [spark] shouldn't be able to run select table."

command="spark.sql(\"select * from $DEFAULT_DB.$TABLE_ANIMALS\").show(true)"
expectedMsg="Permission denied: user [spark] does not have [SELECT] privilege"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"
