#!/bin/bash

source "./big-data-tests/env_variables.sh"
source "./big-data-tests/lib.sh"

set -e

abs_path=$1

./big-data-tests/copy_files_under_spark.sh "$abs_path"

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1,$HIVE_USER" "/*"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1" "gross_test"

updateHiveDefaultDbPolicy "select:$SPARK_USER1"

updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test"

waitForPoliciesUpdate


# create schema hive.test;
