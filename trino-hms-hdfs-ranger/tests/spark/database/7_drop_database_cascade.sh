#!/bin/bash

source "./testlib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Drop database."
echo "- INFO: User [spark] should be able to drop non-empty database with 'cascade'."

command="spark.sql(\"drop database if exists $EXTERNAL_DB cascade\")"
runSpark "spark" "$command" "shouldPass"
