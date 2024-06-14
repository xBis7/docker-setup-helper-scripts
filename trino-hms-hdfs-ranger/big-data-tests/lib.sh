#!/bin/bash

set -e

source "./big-data-tests/env_variables.sh"

copyTestFilesUnderSpark() {
  abs_path=$1

  project_path="docker-setup-helper-scripts/trino-hms-hdfs-ranger"

  # Initialize an empty array.
  test_files_array=()

  # Populate the array.
  test_files_array+=("$COMMON_UTILS_FILE")
  test_files_array+=("$TEST1_FILE")
  test_files_array+=("$TEST2_FILE")
  test_files_array+=("$TEST3_FILE")

  for file in "${test_files_array[@]}"
  do
    # Copy the test file.
    if [ "$CURRENT_ENV" == "local" ]; then
      docker cp "$abs_path/$project_path/big-data-tests/spark/$file" "$SPARK_MASTER_HOSTNAME:/opt/spark"
    else
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

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    echo "Implement this."
  fi  
}

runScalaFileInSparkShell() {
  spark_shell_cmd=$1

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "$spark_shell_cmd"
  else
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
    echo "Implement this."
  fi
}
