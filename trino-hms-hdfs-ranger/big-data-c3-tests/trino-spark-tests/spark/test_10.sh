#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 10 ##"
echo "Attempt various DDL operations against the managed table as a different user"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$SPARK_USER1/read,execute:$SPARK_USER2"

updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

# Drop.
command="spark.sql(\"drop table gross_test.test\")"
expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [DROP] privilege on [gross_test/test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

verifySparkCreateWriteFailure "dropTable" "gross_test" "test"

# Alter.
command="spark.sql(\"alter table gross_test.test rename to gross_test.test2\")"
expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [ALTER] privilege on [gross_test/test]"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

# Create.
command="spark.sql(\"create table gross_test.test2 (id int, greeting string)\")"
expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [CREATE] privilege on [gross_test/test2]"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

verifySparkCreateWriteFailure "createTable" "gross_test" "test2"
