#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

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

command="show schemas from hive;"
expectedMsg="$GROSS_DB_NAME"
runTrino "games" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "Trying to drop schema $GROSS_DB_NAME as user 'games'. User doesn't have permissions and operation should fail."

command="drop schema hive.$GROSS_DB_NAME;"
expectedMsg="Permission denied: user [games] does not have [DROP] privilege on [$GROSS_DB_NAME]"
runTrino "games" "$command" "shouldFail" "$expectedMsg"
