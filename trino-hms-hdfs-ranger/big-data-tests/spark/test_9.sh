#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 9 ##"
echo "Attempt to access a managed table as another user when select has been revoked"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1/read,execute:$SPARK_USER2" "/$HIVE_WAREHOUSE_DIR/gross_test.db"

# Revoke select for user2.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

command="spark.sql(\"select * from gross_test.test\").show()"

expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [SELECT] privilege on [gross_test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

