#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"

set -e

UPDATE_SELECT_SIGNAL_FILE="update_select.txt"
UPDATE_DONE_SIGNAL_FILE="update_done.txt"

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

# -- RANGER POLICIES --
waitForPoliciesUpdate() {
  echo ""
  echo "Wait for the policies to get updated."
  echo ""

  sleep $(($POLICIES_UPDATE_INTERVAL + 5))
}

updateHdfsPathPolicy() {
  path_list=$1
  permissions=$2
  deny_permissions=$3

  ./ranger_api/create_update/create_update_hdfs_path_policy.sh "put" "$permissions" "$path_list" "$deny_permissions"
}

updateHiveDbAllPolicy() {
  db_list=$1
  permissions=$2
  deny_permissions=$3

  # If 'deny_permissions' isn't empty, then 'db_list' won't be empty.
  # Therefore, it's ok to provide values for the in between parameters.
  if [ "$deny_permissions" != "" ]; then
    ./ranger_api/create_update/create_update_hive_all_db_policy.sh "put" "$permissions" "$db_list" "*" "*" "$deny_permissions"
  else
    ./ranger_api/create_update/create_update_hive_all_db_policy.sh "put" "$permissions" "$db_list"
  fi
}

updateHiveDefaultDbPolicy() {
  permissions=$1
  deny_permissions=$2

  ./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "put" "$permissions" "*" "$deny_permissions"
}

updateHiveUrlPolicy() {
  url_list=$1
  permissions=$2
  deny_permissions=$3

  # If 'deny_permissions' isn't empty, then 'db_list' won't be empty.
  # If we specify 'deny_permissions' and 'db_list' is empty, then the 'deny_permissions'
  # value will be stored in the place of the 'url_list' value.
  if [ "$deny_permissions" != "" ]; then
    ./ranger_api/create_update/create_update_hive_url_policy.sh "put" "$permissions" "$url_list" "$deny_permissions"
  else
    ./ranger_api/create_update/create_update_hive_url_policy.sh "put" "$permissions" "$url_list"
  fi
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

deleteHdfsDir() {
  path=$1

  hdfs_cmd="hdfs dfs -rm -r /$path"

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
    echo ""
    echo "Result is expected to be empty."
    echo ""
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
runCmdInSparkShell() {
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

updateSelectPermissionOnSignal() {
  user=$1
  background_run=$2

  echo ""
  echo "shell - Adding defaultdb select access for user '$user'."
  echo ""

  # Provide select access. Because this is running in the background,
  # it doesn't make sense to wait for the policies to get updated.
  # It won't make a difference, it's running in parallel with the scala file
  # and therefore it won't block.
  updateHiveDefaultDbPolicy "select:$user"

  while : # Infinite loop.
  do
    listTmpDirResult=$(runCmdInSparkShell "ls -lah /tmp" "$user" "$background_run")

    # If the signal file exists in the tmp dir,
    # then we need to break the loop and update select access.
    if echo "$listTmpDirResult" | grep -q "$UPDATE_SELECT_SIGNAL_FILE"; then
      echo ""
      echo "shell - Signal file for updating select access, was found. Breaking the loop."
      echo ""
      break
    fi

    wait_time=5
    echo ""
    echo "shell - Signal file for updating select access, wasn't found. Checking again in "$wait_time" secs."
    echo ""
    
    sleep $wait_time
  done
  
  echo ""
  echo "shell - Removing defaultdb select access for user '$user'."
  echo ""

  # Same as above, the scala file will have to wait for the policy update.
  # If we add a wait here, it won't make a difference.
  # The scala file will wait after it finds the signal file.
  updateHiveDefaultDbPolicy ""

  # Create signal file to let the scala file running in the spark-shell,
  # know that a select update has been made.
  runCmdInSparkShell "touch /tmp/$UPDATE_DONE_SIGNAL_FILE" "$user" "$background_run"
}

runSpark() {
  user=$1
  spark_cmd=$2
  expected_result=$3
  expected_output=$4
  prepare=$5

  # If the test is expected to pass AND we don't check for any particular output, BUT we have to set 'prepare',
  # then we need to set a reserved work for 'expected_output' so that we know to reinitialize it.
  # Otherwise, it will get the value from the next param, 'prepare'.
  if [ "$expected_output" == "noOutputCheck" ]; then
    expected_output=""
  fi

  if [ "$prepare" == "catalogObjectInit" ]; then
    # Cleanup the signal files if they exist.
    runCmdInSparkShell "rm -f /tmp/$UPDATE_SELECT_SIGNAL_FILE /tmp/$UPDATE_DONE_SIGNAL_FILE" "$user"

    updateSelectPermissionOnSignal "$user" "true" &
  fi

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

  prepare_params=""
  if [ "$prepare" == "catalogObjectInit" ]; then
    prepare_params="--conf spark.signal.file_name.update_select=\"$UPDATE_SELECT_SIGNAL_FILE\" --conf spark.signal.file_name.update_done=\"$UPDATE_DONE_SIGNAL_FILE\" --conf spark.policies_update_interval=\"$POLICIES_UPDATE_INTERVAL\""
  fi
  runCmdInSparkShell "bin/spark-shell $prepare_params --conf spark.expect_exception=\"$expect_exception\" --conf spark.encoded.command=\"$encoded_cmd\" --conf spark.encoded.expected_output=\"$encoded_output\" -I $TEST_CMD_FILE" "$user"
}

# -- TRINO TESTS --
runTrino() {
  user=$1
  trino_cmd=$2
  expectedResult=$3
  expectedOutput=$4

  resultMsg=""
  if [ "$expectedResult" == "shouldPass" ]; then
    resultMsg="succeeded"
  else
    resultMsg="failed"
  fi

  echo ""
  echo "=========================="
  echo "Running trino command: '$trino_cmd'"
  echo "--------------------------"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it -u "$user" "$TRINO_HOSTNAME" trino --execute="$trino_cmd" 2>&1 | tee "$TRINO_TMP_OUTPUT_FILE"
  else
    # c3 - TODO.
    echo "Implement this."
    # $(cmd) 2>&1 | tee "$tmp_file"
  fi

  # Test the output.
  if !(grep -F "$expectedOutput" "$TRINO_TMP_OUTPUT_FILE" > /dev/null); then
    echo ""
    echo "--------------------------"
    echo "The command failed. It didn't have the expected output."
    echo "Expected output: '$expectedOutput'"
    echo "Actual output: '$(cat $TRINO_TMP_OUTPUT_FILE)'"
    echo "=========================="
    echo ""
    exit 1
  else
    echo ""
    echo "--------------------------"
    echo "Command '$resultMsg' as expected."
    echo "The output matched the provided message!"
    echo "=========================="
    echo ""
  fi
}

# -- LOAD TESTING --
createSparkTableForTestingDdlOps() {
  user=$1

  # This will be run only once during setup. We don't need to run it in the background.
  runCmdInSparkShell "bin/spark-shell --conf spark.db_name=\"default\" --conf spark.table_name=\"test2\" -I $SETUP_CREATE_TABLE_FILE" "$user"
}

runCreateDropDbOnRepeatWithAccess() {
  user=$1
  iterations=$2
  location=$3
  background_run=$4

  runCmdInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" --conf spark.db_location=\"$location\" -I $CREATE_DROP_DB_FILE" "$user" "$background_run"
}

runCreateDropTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runCmdInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $CREATE_DROP_TABLE_FILE" "$user" "$background_run"
}

runInsertSelectTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runCmdInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $INSERT_SELECT_TABLE_WITH_ACCESS_FILE" "$user" "$background_run"
}

runInsertSelectTableOnRepeatNoAccess() {
  user=$1
  iterations=$2
  background_run=$3

  runCmdInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $INSERT_SELECT_TABLE_NO_ACCESS_FILE" "$user" "$background_run"
}
