#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

echo ""
echo "- INFO: This test is run after the schema tests." 
echo "- INFO: The previous policies allow a user to create a table."
waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [trino] does not have [CREATE] privilege on"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$failMsg" "true"
