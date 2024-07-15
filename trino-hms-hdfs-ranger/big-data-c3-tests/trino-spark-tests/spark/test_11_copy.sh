#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Repeat using an external table"
echo ""

policy_setup=$1
rerun=$2
wait_for_debugger=$3

if [ "$policy_setup" == "true" ]; then
  # changeHdfsDirPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
  # changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR" 755
  # The notes are creating 'testdb.db' but the ranger policies are providing access for 'gross_test.db'
  # also the db is named 'gross_test'. Let's assume that 'testdb.db' is a typo.

  createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

  # Create the tmp directory and provide world access to it so that Trino can use it.
  createHdfsDir "tmp"
  changeHdfsDirPermissions "tmp" 777

  updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test" "read,write,execute:$SPARK_USER1"

  # It's the same as in the previous test.
  updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"

  # It's the same as in the previous test.
  updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

  # There is no note about Hive URL policies but as long as we update HDFS policies and add '/data/projects/gross_test'
  # and we are expecting the command to succeed, then we also need to add 'hdfs://$NAMENODE_NAME/data/projects/gross_test' here.

  # If we replace 'updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"'
  # with          'updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"'
  # Then during the table creation, we will get this error
  # 'org.apache.hadoop.hive.ql.metadata.HiveException: MetaException(message:Permission denied: user [$SPARK_USER1] does not have [WRITE] privilege on [[hdfs://$NAMENODE_NAME/data/projects/gross_test/test2, hdfs://$NAMENODE_NAME/data/projects/gross_test/test2/]])'
  # but the table creation will actually succeed and the data will be there.
  # updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"
  # updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"
  # updateHiveUrlPolicy ""

updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"
# updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"

  waitForPoliciesUpdate
fi

command="spark.sql(\"create database if not exists gross_test\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"drop table if exists gross_test.test2\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

if [ "$rerun" == "true" ]; then
  deleteHdfsDir "data/projects/gross_test/test2"
fi

# if [ "$wait_for_debugger" == "true" ]; then
#   echo ""
#   echo "Waiting for the debugger"
#   echo ""
#   sleep 10
# fi

# updateHdfsPathPolicy "/data/projects/gross_test" "read,write,execute:$SPARK_USER1"
# updateHiveUrlPolicy ""

# waitForPoliciesUpdate

# Create.
command=$(cat <<EOF
  val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")
  df.write.option("path", "/data/projects/gross_test/test2").saveAsTable("gross_test.test2")
EOF
)

# command="spark.sql(\"create external table if not exists gross_test.test2 (id int, name string) location 'hdfs://namenode/data/projects/gross_test/test2'\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

# updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test" "read,write,execute:$SPARK_USER1"
# updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"
updateHdfsPathPolicy ""
updateHiveDbAllPolicy "gross_test" "create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"
updateHiveUrlPolicy ""
waitForPoliciesUpdate

# Create.
command="spark.sql(\"ALTER TABLE gross_test.test2 ADD COLUMNS (age int)\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"


# spark.sql("ALTER TABLE gross_test.test2 RENAME COLUMN name TO new_name")
#       org.apache.spark.sql.AnalysisException: RENAME COLUMN is only supported with v2 tables.

# spark.sql("ALTER TABLE gross_test.test2 DROP COLUMNS (name)")
#       org.apache.spark.sql.AnalysisException: DROP COLUMN is only supported with v2 tables.
