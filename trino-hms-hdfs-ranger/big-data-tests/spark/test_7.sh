#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 7 ##"
echo "Create a managed table"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1" "/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

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

runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"drop table gross_test.test\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

# 'hdfs dfs -ls' and check data after drop.
listContentsOnHdfsPath "$HIVE_WAREHOUSE_DIR/gross_test.db" "shouldBeEmpty"
