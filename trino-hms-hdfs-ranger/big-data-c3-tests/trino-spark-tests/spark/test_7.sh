#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 7 ##"
echo "Create a managed table"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

command=$(cat <<EOF
  val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")
  df.write.saveAsTable("gross_test.test")
EOF
)

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"select * from gross_test.test\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"describe extended gross_test.test\").show(false)"

# The 'Type' of the table shoud be 'MANAGED' and
# the location should be 'hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db/test'
# Run the command twice, so that we can check each time for a different part of the output.
expectedOutput="|Type                        |MANAGED"
runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"

expectedOutput="|Location                    |hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db/test"
runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"

command="spark.sql(\"drop table gross_test.test\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

# 'hdfs dfs -ls' and check data after drop.
listContentsOnHdfsPath "$HIVE_WAREHOUSE_DIR/gross_test.db" "shouldBeEmpty"
