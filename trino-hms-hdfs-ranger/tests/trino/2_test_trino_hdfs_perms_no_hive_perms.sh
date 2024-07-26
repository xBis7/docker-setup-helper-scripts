#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

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

command="create table hive.$DEFAULT_DB.$TRINO_TABLE (id varchar, name varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV');"
# Failure due to lack of Hive metastore permissions.
expectedMsg="Permission denied: user [trino] does not have [CREATE] privilege on"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

# Provide select access to verify that the table creation failed.
updateHiveDefaultDbPolicy "select:trino"
waitForPoliciesUpdate

verifyCreateWriteFailure "trino" "createTable" "$DEFAULT_DB" "$TRINO_TABLE"

# The next test will set new policies. No need to reset them here as well.
