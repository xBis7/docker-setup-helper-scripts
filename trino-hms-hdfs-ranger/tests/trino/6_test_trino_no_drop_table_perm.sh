#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,Alter:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: [drop] should fail."

# It is expected for this test to fail with the permission denied exception with message similar to 'Permission denied: user [trino] does not have [DROP] privilege on [default/new_trino_test_table]', but it fails with a different error.
# Thanks to xBis7 for investigation, it was found that permission denied exception is swallowed and a new exception is thrown with a different message.
# This seems to done for better messaging experience, but it is misleading.
# More info could be found on the link https://github.com/G-Research/gr-oss/issues/551#issuecomment-1994240651.
failMsg="The following metastore delete operations failed: drop table $DEFAULT_DB.$NEW_TRINO_TABLE_NAME"
retryOperationIfNeeded "$abs_path" "dropTrinoTable $NEW_TRINO_TABLE_NAME $DEFAULT_DB" "$failMsg" "true"
