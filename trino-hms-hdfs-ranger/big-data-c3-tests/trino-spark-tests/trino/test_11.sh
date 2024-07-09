#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Attempt various DDL operations against the managed table as a different user"
echo ""

# There are no notes about making policy changes. But if we leave them as they are in the previous test, then user2 will have all HDFS access.
# We are expecting that 'create table' will fail with an HDFS error which won't happen. Instead, it will fail with a metadata error.
# "Permission denied: user [$TRINO_USER2] does not have [CREATE] privilege on [gross_test/test2]"

# Remove user2.
updateHdfsPathPolicy "/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# In order to get the expected errors then user2 must have select access.
# The select that has been added here, isn't part of the BigData notes.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

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
expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"
