#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

abs_path=$1       # /home/project/...
prepare_env=$2    # "true"
iterations=$3     # 0 or 10 or 100 or ...
check_result=$4   # "showDbAfter"

# Functions.
checkResults() {
  check=$1

  if [ "$check" == "showDbAfter" ]; then

    command="spark.sql(\"show databases\").show"
    expectedOutput="gross_test"

    runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"
  fi
}

test3() {
  policy_setup=$1

  if [ "$policy_setup" == "true" ]; then
    updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1"
    updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1"
    updateHiveDefaultDbPolicy "select:$SPARK_USER1"
    updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"

    waitForPoliciesUpdate
  fi

  command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

  runSpark "$SPARK_USER1" "$command" "shouldPass"
}

test4() {
  policy_setup=$1

  if [ "$policy_setup" == "true" ]; then
    updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1"
    updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"
    updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"
    updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"

    waitForPoliciesUpdate
  fi

  command="spark.sql(\"drop database gross_test\")"
  expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [DROP] privilege on [gross_test]"

  runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"
}

# Env setup.
if [ "$CURRENT_ENV" == "local" ] && [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"

  createHdfsDir "$HIVE_WAREHOUSE_DIR"
  createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"
  createHdfsDir "tmp"
  changeHdfsDirPermissions "tmp" 777

  HIVE_BASE_POLICIES="hive_base_policies"

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

  waitForPoliciesUpdate
  # If we try to change the policies while the Ranger container is still restarting,
  # the call will fail and the script will exit.

  # Copy the files here to make sure that they are available for test3.
  if [ "$CURRENT_ENV" == "local" ]; then
    copyTestFilesUnderSpark "$abs_path"
  fi

  test3 "true"
fi

counter=0
# If 'iterations' is 0, then it will run only once.
while [[ "$counter" -le "$iterations" ]]; do

  echo ""
  echo "--------------------------"
  echo "Starting iteration '$iterations'"
  echo "--------------------------"
  echo ""

  if [ "$counter" == 0 ]; then
    # Setup the policies only for the first run.
    test4 "true"
  else
    test4
  fi

  checkResults "$check_result"

  counter=$(($counter + 1))
done

