#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

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

# Even if the directory exists, there won't be any errors. The command uses the '-p' option.
createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

# This is the error that we get without updating the Hive warehouse ACLs and creating the 'gross_test.db' directory.
# Query 20240701_134717_00010_39diz failed: Got exception: org.apache.hadoop.security.AccessControlException Permission denied: user=trino, access=WRITE, inode="/opt/hive/data":hadoop:supergroup:drwxr-xr-x

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$TRINO_USER1"

updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test"

# In the BigData notes, this is expected to fail with metadata WRITE error. But this was the expected error for the previous test.
# This test is updating both HDFS and Hive URL policies and with the updates, we shouldn't be getting any errors.
# In addition, the next test is creating a table under this schema. It must have been a typo error on the notes.

# hdfsLocation="hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"
# expectedErrorMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"
expectedMsg="CREATE SCHEMA"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"
