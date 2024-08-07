#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 1 ##"
echo "Create a database without having Create permissions"
echo ""

# The 'permissions' parameters have this format -> 'operation1,operation2:user1,user2/operation4,operation5,operation6:user3'
# e.g. 'read,write:hadoop,spark/read,execute:hive'

# 1st parameter: comma-separated list of paths
# 2nd parameter: permissions
# 3rd parameter: deny permissions if necessary
updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1"

# 1st parameter: comma-separated list of DBs
# 2nd parameter: permissions
# 3rd parameter: deny permissions if necessary
updateHiveDbAllPolicy ""

# 1st parameter: permissions
# 2nd parameter: deny permissions if necessary
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

# 1st parameter: comma-separated list of URLs
# 2nd parameter: permissions
# 3rd parameter: deny permissions if necessary
updateHiveUrlPolicy ""

waitForPoliciesUpdate

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

expectedErrorMsg="Permission denied: user [$SPARK_USER1] does not have [CREATE] privilege on [gross_test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedErrorMsg"

verifyCreateWriteFailure "spark" "createDb" "gross_test"
