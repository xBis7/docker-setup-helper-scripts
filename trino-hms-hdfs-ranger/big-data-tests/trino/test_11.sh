#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Attempt various DDL operations against the managed table as a different user"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$TRINO_USER1,$TRINO_USER2" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

# Run the commands as user2.
command="drop table $TRINO_HIVE_SCHEMA.gross_test.test"
# In the BigData notes, this command is expected to fail with this error. But this is a Spark error.
# The Trino error for lack of DROP privileges, is different.

# expectedMsg="Permission denied: user [$TRINO_USER2] does not have [DROP] privilege on [gross_test/test]"
expectedMsg="The following metastore delete operations failed: drop table gross_test.test"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

command="alter table $TRINO_HIVE_SCHEMA.gross_test.test rename to $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [ALTER] privilege on [gross_test/test]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

command="create table $TRINO_HIVE_SCHEMA.gross_test.test2 (id int, greeting varchar)"
# In the BigData notes, this command is expected to fail with this error.
# expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"$HIVE_WAREHOUSE_DIR/gross_test.db\":"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [CREATE] privilege on [gross_test/test2]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"
