#!/bin/bash

set -e

source "./big-data-tests/env_variables.sh"

copyTestFilesUnderSpark() {
  abs_path=$1

  # Initialize an empty array.
  test_files_array=()

  # Populate the array.
  test_files_array+=("$COMMON_UTILS_FILE")
  test_files_array+=("$TEST1_FILE")
  test_files_array+=("$TEST2_FILE")
  test_files_array+=("$TEST3_FILE")
  test_files_array+=("$TEST4_FILE")
  test_files_array+=("$TEST5_FILE")
  test_files_array+=("$TEST6_FILE")
  test_files_array+=("$TEST7_AND_8_1_FILE")
  test_files_array+=("$TEST7_2_FILE")
  test_files_array+=("$TEST8_2_FILE")
  test_files_array+=("$TEST8_3_FILE")

  for file in "${test_files_array[@]}"
  do
    # Copy the test file.
    if [ "$CURRENT_ENV" == "local" ]; then
      project_path="docker-setup-helper-scripts/trino-hms-hdfs-ranger"

      docker cp "$abs_path/$project_path/big-data-tests/spark/$file" "$SPARK_MASTER_HOSTNAME:/opt/spark"
    else
      # c3 - TODO.
      echo "Implement this."
    fi
  done
}

waitForPoliciesUpdate() {
  echo ""
  echo "Wait for the policies to get updated."
  echo ""

  sleep $(($POLICIES_UPDATE_INTERVAL + 5))
}

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

  if [ "$expectedEmptyResult" == "true" ]; then
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


runScalaFileInSparkShell() {
  spark_shell_cmd=$1
  user=$2

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it -u "$user" "$SPARK_MASTER_HOSTNAME" bash -c "$spark_shell_cmd"
  else
    # c3 - TODO.
    echo "Implement this."
  fi
}

# To properly import the common utils file, we would need to load the file and then execute
# the scala file that imports it, in the same spark-shell.
# Because we need to run both of them remotely in an interactive shell,
# we are combining the files and executing the combined file.
combineFileWithCommonUtilsFile() {
  file_name=$1

  cmd="cat $COMMON_UTILS_FILE $file_name > $TMP_COMBINED_FILE"

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "$cmd"
  else
    # c3 - TODO.
    echo "Implement this."
  fi
}
