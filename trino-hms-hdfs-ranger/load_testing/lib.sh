#!/bin/bash

source "./load_testing/env_variables.sh"

set -e

copyTestFilesUnderSpark() {
  abs_path=$1

  # Initialize an empty array.
  test_files_array=()

  # Populate the array.
  test_files_array+=("$SETUP_CREATE_TABLE_FILE")
  test_files_array+=("$CREATE_DROP_DB_FILE")
  test_files_array+=("$CREATE_DROP_TABLE_FILE")
  test_files_array+=("$INSERT_SELECT_TABLE_WITH_ACCESS_FILE")
  test_files_array+=("$INSERT_SELECT_TABLE_NO_ACCESS_FILE")

  for file in "${test_files_array[@]}"
  do
    # Copy the test file.
    if [ "$CURRENT_ENV" == "local" ]; then
      project_path="docker-setup-helper-scripts/trino-hms-hdfs-ranger"

      docker cp "$abs_path/$project_path/load_testing/scala_test_files/$file" "$SPARK_MASTER_HOSTNAME:/opt/spark"
    else
      # c3 - TODO.
      echo "Implement this."
    fi
  done
}

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

# This will be run only once during setup. We don't need to run it in the background.
createSparkTableForTestingDdlOps() {
  user=$1

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

waitForPoliciesUpdate() {
  echo ""
  echo "Wait for the policies to get updated."
  echo ""

  sleep $(($POLICIES_UPDATE_INTERVAL + 5))
}

updateHdfsPathPolicy() {
  permissions=$1
  path_list=$2

  ./ranger_api/create_update/create_update_hdfs_path_policy.sh "$path_list" "$permissions" "put"
}

updateHiveDbAllPolicy() {
  permissions=$1
  db_list=$2

  ./ranger_api/create_update/create_update_hive_all_db_policy.sh "$permissions" "put" "$db_list"
}

updateHiveDefaultDbPolicy() {
  permissions=$1

  ./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "$permissions" "put"
}

updateHiveUrlPolicy() {
  permissions=$1
  url_list=$2

  ./ranger_api/create_update/create_update_hive_url_policy.sh "$permissions" "put" "$url_list"
}
