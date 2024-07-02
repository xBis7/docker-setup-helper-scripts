#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"

set -e

copyTestFilesUnderSpark() {
  abs_path=$1
  load_testing=$2

  # Initialize an empty array.
  test_files_array=()

  if [ "$load_testing" == "true" ]; then
    # Populate the array.
    test_files_array+=("$SETUP_CREATE_TABLE_FILE")
    test_files_array+=("$CREATE_DROP_DB_FILE")
    test_files_array+=("$CREATE_DROP_TABLE_FILE")
    test_files_array+=("$INSERT_SELECT_TABLE_WITH_ACCESS_FILE")
    test_files_array+=("$INSERT_SELECT_TABLE_NO_ACCESS_FILE")
  else
    # Populate the array.
    test_files_array+=("$TEST_CMD_FILE")
  fi

  for file in "${test_files_array[@]}"
  do
    # Copy the test file.
    if [ "$CURRENT_ENV" == "local" ]; then
      project_path="docker-setup-helper-scripts/trino-hms-hdfs-ranger/big-data-c3-tests"

      if [ "$load_testing" == "true" ]; then
        project_path+="/load-testing"
      else
        project_path+="/trino-spark-tests/spark"
      fi

      docker cp "$abs_path/$project_path/scala-test-files/$file" "$SPARK_MASTER_HOSTNAME:/opt/spark"
    else
      # c3 - TODO.
      echo "Implement this."
    fi
  done
}

# -- HDFS --
createHdfsDir() {
  dir_name=$1

  hdfs_cmd="hdfs dfs -mkdir -p /$dir_name"

  echo ""
  echo "Running command:"
  echo "$hdfs_cmd"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    # c3 - TODO.
    echo "Implement this."
  fi

  echo ""
  echo "Command succeeded."
  echo ""
}

changeHdfsDirPermissions() {
  path=$1
  permissions=$2

  hdfs_cmd="hdfs dfs -chmod $permissions /$path"

  echo ""
  echo "Running command:"
  echo "$hdfs_cmd"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    # c3 - TODO.
    echo "Implement this."
  fi

  echo ""
  echo "Command succeeded."
  echo ""
}

listContentsOnHdfsPath() {
  path=$1
  expectedEmptyResult=$2
  expectedOutput=$3

  hdfs_cmd="hdfs dfs -ls /$path"

  echo ""
  echo "Running command:"
  echo "$hdfs_cmd"
  echo "and checking results."
  echo ""

  # Initialize the variable.
  result=

  if [ "$CURRENT_ENV" == "local" ]; then
    result=$(docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd")
  else
    # c3 - TODO.
    echo "Implement this."
    # result=$()
  fi

  if [ "$expectedEmptyResult" == "shouldBeEmpty" ]; then
    # Check that the result is empty as expected.
    if [ "$result" != "" ]; then
      echo "Result is expected to be empty but it isn't. Exiting..."
      exit 1
    fi
  else
    # If grep fails then it will exit.
    cat "$result" | grep "$expectedOutput"
  fi

  echo ""
  echo "Command succeeded."
  echo ""
}

# -- SPARK TESTS --
runScalaFileInSparkShell() {
  spark_shell_cmd=$1
  user=$2
  background_run=$3

  if [ "$CURRENT_ENV" == "local" ]; then
    # If the command is run in the background, then we shouldn't use '-it'.
    # Otherwise, we will get 'the input device is not a TTY'
    if [ "$background_run" == "true" ]; then
      docker exec -u "$user" "$SPARK_MASTER_HOSTNAME" bash -c "$spark_shell_cmd"
    else
      docker exec -it -u "$user" "$SPARK_MASTER_HOSTNAME" bash -c "$spark_shell_cmd"
    fi
  else
    # c3 - TODO.
    echo "Implement this."
  fi
}

base64encode() {
  input=$1

  # Because of OS differences, it is necessary to use -w 0 for Linux distros.
  if [[ $(uname) != "Darwin"* ]]; then
    echo -n "$input" | base64 -w 0
  else
    echo -n "$input" | base64
  fi
}

runSpark() {
  user=$1
  spark_cmd=$2
  expected_result=$3
  expected_output=$4

  # The cmd and the error, occasionally aren't properly passed to the scala file.
  # Some times, everything after the first space is truncated.
  # To workaround the issue:
  # - encode the string here
  # - decode the string on the scala file
  encoded_cmd=$(base64encode "$spark_cmd")
  encoded_output=$(base64encode "$expected_output")

  expect_exception=true
  if [ "$expected_result" == "shouldPass" ]; then
    expect_exception=false
  fi
  runScalaFileInSparkShell "bin/spark-shell --conf spark.expect_exception=\"$expect_exception\" --conf spark.encoded.command=\"$encoded_cmd\" --conf spark.encoded.expected_output=\"$encoded_output\" -I $TEST_CMD_FILE" "$user"
}

# -- LOAD TESTING --
createSparkTableForTestingDdlOps() {
  user=$1

  # This will be run only once during setup. We don't need to run it in the background.
  runScalaFileInSparkShell "bin/spark-shell --conf spark.db_name=\"default\" --conf spark.table_name=\"test2\" -I $SETUP_CREATE_TABLE_FILE" "$user"
}

runCreateDropDbOnRepeatWithAccess() {
  user=$1
  iterations=$2
  location=$3
  background_run=$4

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" --conf spark.db_location=\"$location\" -I $CREATE_DROP_DB_FILE" "$user" "$background_run"
}

runCreateDropTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $CREATE_DROP_TABLE_FILE" "$user" "$background_run"
}

runInsertSelectTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $INSERT_SELECT_TABLE_WITH_ACCESS_FILE" "$user" "$background_run"
}

runInsertSelectTableOnRepeatNoAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $INSERT_SELECT_TABLE_NO_ACCESS_FILE" "$user" "$background_run"
}

# -- RANGER POLICIES --
waitForPoliciesUpdate() {
  echo ""
  echo "Wait for the policies to get updated."
  echo ""

  sleep $(($POLICIES_UPDATE_INTERVAL + 5))
}

updateHdfsPathPolicy() {
  permissions=$1
  path_list=$2

  ./ranger_api/create_update/create_update_hdfs_path_policy.sh "put" "$permissions" "$path_list"
}

updateHiveDbAllPolicy() {
  permissions=$1
  db_list=$2

  ./ranger_api/create_update/create_update_hive_all_db_policy.sh "put" "$permissions" "$db_list"
}

updateHiveDefaultDbPolicy() {
  permissions=$1

  ./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "put" "$permissions"
}

updateHiveUrlPolicy() {
  permissions=$1
  url_list=$2

  ./ranger_api/create_update/create_update_hive_url_policy.sh "put" "$permissions" "$url_list"
}
