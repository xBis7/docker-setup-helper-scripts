#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 12 ##"
echo "Repeat using an external table"
echo ""

prepare=$1

if [ "$prepare" == "true" ]; then
  updateHdfsPathPolicy "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

  updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"

  updateHiveDefaultDbPolicy ""

  updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

  waitForPoliciesUpdate

  command="create schema if not exists $TRINO_HIVE_SCHEMA.gross_test"
  expectedMsg="CREATE SCHEMA"

  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  # Run the commands as user1.
  command="create table if not exists $TRINO_HIVE_SCHEMA.gross_test.test2 (id int, name varchar) with (external_location = 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test2')"
  expectedMsg="CREATE TABLE"

  # 1st parameter: the user to execute the command
  # 2nd parameter: the command to be executed
  # 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
  # 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  command="insert into $TRINO_HIVE_SCHEMA.gross_test.test2 values (1, 'Austin')"
  expectedMsg="INSERT: 1 row"

  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  # Change permissions here to get an HDFS ACLs error and
  # check that creating a Ranger policy fixes it.

  changeHdfsDirPermissions "data/projects/gross_test" 700

  updateHdfsPathPolicy "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1/read,execute:$TRINO_USER2"
  waitForPoliciesUpdate

fi

# We have updated the HDFS policies. We shouldn't still get an EXECUTE error.
command="insert into $TRINO_HIVE_SCHEMA.gross_test.test2 values (2, 'Fred')"
# In the BigData notes we are getting this error.
# expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"
expectedMsg="Create temporary directory for hdfs://$NAMENODE_NAME/data/projects/gross_test/test2 failed: Permission denied: user=$TRINO_USER2, access=WRITE, inode=\"/tmp\":"

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"
