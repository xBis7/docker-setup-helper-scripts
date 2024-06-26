#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 7 ##"
echo "Create a database using the default hive warehouse location with an HDFS Ranger Hive, URL-based policy present"
echo ""

# In order to get the expected output, we need to provide access for the trino user
# to the Hive Warehouse directory as well. This isn't part of the BigData notes but it must be present.
# Either there is another HDFS policy that grants access or there is world ACL access.

# Spark tests are changing the ACLs and creating the subdirectory at this part.
# Do the same here and keep the policies the same as in the notes.
changeHdfsDirPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR" 755

# createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$TRINO_USER1"

updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test"

hdfsLocation="hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

expectedErrorMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedErrorMsg"
