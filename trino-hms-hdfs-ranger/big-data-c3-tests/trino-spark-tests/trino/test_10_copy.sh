#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test ##"
echo ""

prepare=$1

if [ "$prepare" == "true" ]; then
  updateHdfsPathPolicy "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

  updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"

  updateHiveDefaultDbPolicy ""

  updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

  waitForPoliciesUpdate

  command="create schema $TRINO_HIVE_SCHEMA.gross_test"
  expectedMsg="CREATE SCHEMA"

  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  # Run the first commands as user1.
  command="create table $TRINO_HIVE_SCHEMA.gross_test.test (id int, name varchar)"
  expectedMsg="CREATE TABLE"

  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  command="insert into $TRINO_HIVE_SCHEMA.gross_test.test values (1, 'Austin')"
  expectedMsg="INSERT: 1 row"

  runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

  # Run as user2.

  # Change permissions here to get an HDFS ACLs error and
  # check that creating a Ranger policy fixes it.
  changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR/gross_test.db" 700
fi

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
# This is the expected error according to the BigData notes for ACL access drwx------.
# expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":"
expectedMsg="Failed to list directory: hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db/test"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"
