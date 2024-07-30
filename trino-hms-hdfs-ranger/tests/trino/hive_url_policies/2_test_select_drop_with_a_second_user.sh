#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test2-trino: ############### test select and drop with user 'games' ###############"
echo ""

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:trino"

waitForPoliciesUpdate

echo ""
echo "User 'games' has SELECT access. Show database should succeed."

cmd="show schemas from hive;"
successMsg="$GROSS_DB_NAME"
retryOperationIfNeeded "$abs_path" "performTrinoCmd games $cmd" "$successMsg" "false"

echo ""
echo "Trying to drop schema $GROSS_DB_NAME as user 'games'. User doesn't have permissions and operation should fail."

cmd="drop schema hive.$GROSS_DB_NAME;"
failureMsg="Permission denied: user [games] does not have [DROP] privilege on [$GROSS_DB_NAME]"
retryOperationIfNeeded "$abs_path" "performTrinoCmd games $cmd" "$failureMsg" "true"
