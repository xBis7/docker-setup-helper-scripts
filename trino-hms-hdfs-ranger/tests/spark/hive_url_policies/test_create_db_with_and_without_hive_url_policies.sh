#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
test_case=$2

with_url=1
without_url=1

if [ "$test_case" == "with" ]; then
  with_url=0
elif [ "$test_case" == "without" ]; then
  without_url=0
else
  with_url=0
  without_url=0
fi

full_test_path="$HIVE_GROSS_DB_TEST_DIR/test1/test2/test3"

setup() {
  use_url_config=$1

  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"

  if [ "$use_url_config" == "true" ]; then
    ./docker/start_docker_env.sh "$abs_path" "$use_url_config"
  else
    ./docker/start_docker_env.sh "$abs_path"
  fi

  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"
  waitForPoliciesUpdate

  notExpMsg="Permission denied"
  retryOperationIfNeeded "$abs_path" "createHdfsDir $full_test_path" "$notExpMsg" "false" "true"

  notExpMsg="Permission denied"
  retryOperationIfNeeded "$abs_path" "changeHdfsDirPermissions 777 $HIVE_GROSS_DB_TEST_DIR" "$notExpMsg" "false" "true"

  notExpMsg="Permission denied"
  retryOperationIfNeeded "$abs_path" "changeHdfsDirPermissions 777 $HIVE_GROSS_DB_TEST_DIR/test1" "$notExpMsg" "false" "true"

  notExpMsg="Permission denied"
  retryOperationIfNeeded "$abs_path" "changeHdfsDirPermissions 777 $HIVE_GROSS_DB_TEST_DIR/test1/test2" "$notExpMsg" "false" "true"

  if [ "$use_url_config" == "true" ]; then
    echo ""
    echo "- INFO: Updating Ranger policies. User [spark] will have Write permission for Hive URL policy but no HDFS access."

    updateHdfsPathPolicy "read,write,execute:hadoop" "/*"
    updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark"
    updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:trino/select:spark"
    updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,trino,spark"

    waitForPoliciesUpdate
  else
    echo ""
    echo "- INFO: Updating Ranger policies. User [spark] now will have all Hive access to default DB but no HDFS."

    updateHdfsPathPolicy "read,write,execute:hadoop" "/*"
    updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
    updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:trino,spark"
    updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

    waitForPoliciesUpdate
  fi

}

# Without URL policies.
if [ "$without_url" == 0 ]; then
  setup

  echo ""
  echo "When Hive URL policies are disabled and the coarse check is also disabled,"
  echo "then the hive plugin is recursively checking permissions for all sub-dirs under the provided path."
  echo "On the first permission check failure, the recursion stops."
  echo "We are providing POSIX permission access to the parent dir and all sub directories except the last."
  echo "The operation should fail."
  echo ""

  cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
  scala_sql=$(base64encode "create database gross_test location '/$HIVE_GROSS_DB_TEST_DIR'")
  scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR]")
  retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
fi

# With URL policies.
if [ "$with_url" == 0 ]; then
  setup "true"

  echo ""
  echo "User [spark] has metadata access, Hive URL access and no HDFS policies access, but has Hadoop POSIX permission access to the parent dir."
  echo "Because Hive URL policies are enabled, no sub-dirs should be checked for access. Operation should succeed."
  echo ""

  cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
  scala_sql=$(base64encode "create database gross_test location '/$HIVE_GROSS_DB_TEST_DIR'")
  retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
fi




