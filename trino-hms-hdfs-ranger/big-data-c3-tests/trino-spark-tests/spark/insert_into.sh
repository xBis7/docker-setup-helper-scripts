#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test insert into with HDFS access and no ALTER ##"
echo "It gives an ALTER error but the data has been written."
echo ""

policy_setup=$1

if [ "$policy_setup" == "true" ]; then
  createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

  updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test" "read,write,execute:$SPARK_USER1"

  updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1"

  updateHiveDefaultDbPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1"

  updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"

  waitForPoliciesUpdate
fi

command="spark.sql(\"create database if not exists gross_test\")"
runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"drop table if exists gross_test.test\")"
runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"create table gross_test.test (id int, name string)\")"
runSpark "$SPARK_USER1" "$command" "shouldPass"

# Update the policies.
updateHiveDbAllPolicy "gross_test" "select:$SPARK_USER1"
updateHiveDefaultDbPolicy "select:$SPARK_USER1"
waitForPoliciesUpdate

exit

# Run the command manually and connect the debugger from Spark? Doesn't hit the breakpoint from hive.
# Don't forget to copy the hive jars under spark.

command="spark.sql(\"insert into gross_test.test values (1, 'str1')\")"
expectedOutput="user [$SPARK_USER1] does not have [ALTER] privilege on [gross_test/test]"
runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedOutput"

# This should be empty but it isn't.
command="spark.sql(\"select * from gross_test.test\").show(true)"
expectedOutput="|  1|str1|"

runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"

# This should also be empty but it isn't.
listContentsOnHdfsPath "opt/hive/data/gross_test.db/test" "shouldBeEmpty"
