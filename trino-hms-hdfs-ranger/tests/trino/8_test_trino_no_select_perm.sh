#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] won't have any Hive privileges."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: User [trino] shouldn't be able to run select table."
failMsg="Permission denied: user [trino] does not have [SELECT] privilege"
retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TABLE_ANIMALS $DEFAULT_DB" "$failMsg" "true"
