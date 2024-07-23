#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

abs_path=$1
prepare_env=$2

./big-data-c3-tests/trino-spark-tests/setup.sh "$abs_path" "$prepare_env"

if [ "$CURRENT_ENV" == "local" ]; then
  ./big-data-c3-tests/copy_files_under_spark.sh "$abs_path"
fi

# createHdfsDir "tmp/squirrel.db"

updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "squirrel" "alter,create,drop,index,lock,select,update:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/tmp/squirrel.db" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

command="spark.sql(\"create database if not exists squirrel location '/tmp/squirrel.db'\")"
runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"drop database squirrel\")"
runSpark "$SPARK_USER1" "$command" "shouldPass"
