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
      echo "No need to copy files under Spark."
    fi
  done
}

# -- HDFS --
createHdfsDir() {
  dir_name=$1
  location=${2:-hdfs} # Ignored if the env is local.

  hdfs_cmd="hdfs dfs -mkdir -p /$dir_name"

  echo ""
  echo "Running command:"
  echo "$hdfs_cmd"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    if [ "$location" == "hdfs" ]; then
      eval "$hdfs_cmd"
    else
      echo "Running through sshpass"
      sshpass -e ssh "$HDFS_USER@$HDFS_HOSTNAME" "$hdfs_cmd"
    fi
  fi

  echo ""
  echo "Command succeeded."
  echo ""
}

changeHdfsDirPermissions() {
  path=$1
  permissions=$2
  location=${3:-hdfs} # Ignored if the env is local.

  hdfs_cmd="hdfs dfs -chmod $permissions /$path"

  echo ""
  echo "Running command:"
  echo "$hdfs_cmd"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    if [ "$location" == "hdfs" ]; then
      eval "$hdfs_cmd"
    else
      echo "Running through sshpass"
      sshpass -e ssh "$HDFS_USER@$HDFS_HOSTNAME" "$hdfs_cmd"
    fi
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
    echo "Running through sshpass"
    sshpass -e ssh "$HDFS_USER@$HDFS_HOSTNAME" "$hdfs_cmd"
  fi

  echo ""
  echo "Command succeeded."
  echo ""
}

listContentsOnHdfsPath() {
  path=$1
  expectedEmptyResult=$2
  expectedOutput=$3
  location=${4:-hdfs} # Ignored if the env is local.

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
    if [ "$location" == "hdfs" ]; then
      eval "$hdfs_cmd"
    else
      echo "Running through sshpass"
      sshpass -e ssh "$HDFS_USER@$HDFS_HOSTNAME" "$hdfs_cmd"
    fi
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
    # 'ignoreExpectedOutput' is provided in case we don't want to check the output,
    # but the env isn't local and we need to set a location.
    if [ "$expectedOutput" != "ignoreExpectedOutput" ]; then
      # If grep fails then it will exit.
      cat "$result" | grep "$expectedOutput"
    fi
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
    echo "Executing Scala file in Spark shell"
    eval $SPARK_PATH/$spark_shell_cmd
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

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$TEST_CMD_FILE"
  else
    echo "kinit for $user"
    eval kinit -kt $KRB_KEYTAB_PATH/$user$KRB_KEYTAB_SUFFIX $user$KRB_REALM

    file="$TEST_FILES_DIR_PATH/$TEST_CMD_FILE"
  fi

  runScalaFileInSparkShell "bin/spark-shell --conf spark.expect_exception=\"$expect_exception\" --conf spark.encoded.command=\"$encoded_cmd\" --conf spark.encoded.expected_output=\"$encoded_output\" -I $file" "$user"
}

# -- TRINO TESTS --
runTrino() {
  user=$1
  trino_cmd=$2
  expectedResult=$3
  expectedOutput=$4
  signin_profile=${5:-svc}

  resultMsg=""
  if [ "$expectedResult" == "shouldPass" ]; then
    resultMsg="succeeded"
  else
    resultMsg="failed"
  fi

  access_token=
  signin_msg_if_provided=""
  if [ "$CURRENT_ENV" != "local" ]; then
    if [ "$signin_profile" == "svc" ]; then
      access_token=$SIGNIN_PROFILE_SVC_ACCESS_TOKEN_BASE64
    else
      access_token=$SIGNIN_PROFILE_USER_ACCESS_TOKEN_BASE64
    fi
    signin_msg_if_provided="and signin profile '$signin_profile'"
  fi

  echo ""
  echo "=========================="
  echo "Running trino command: '$trino_cmd' for user '$user' $signin_msg_if_provided"
  echo "--------------------------"
  echo ""

  if [ "$CURRENT_ENV" == "local" ]; then
    # Use '--output-format ALIGNED' to make sure that there is always output and it has the correct format.
    # This option, aligns the output columns in tabs.
    docker exec -it -u "$user" "$TRINO_HOSTNAME" trino --output-format ALIGNED --debug --execute="$trino_cmd" 2>&1 | tee "$TRINO_TMP_OUTPUT_FILE"
  else
    # TODO: enable --debug for c3.
    eval "$TRINO_BIN_PATH" "--server $TRINO_HOSTNAME" "--access-token=$(echo -n $access_token | base64 --decode)" "--user $user" "--execute \"$trino_cmd\"" 2>&1 | tee "$TRINO_TMP_OUTPUT_FILE"
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

# -- CHECK CREATE/WRITE FAILURES --
verifyCreateWriteFailure() {
  # Run all checks as user1 for now.
  component=$1
  operation=$2
  db_name=$3
  table_name=$4
  insert_id=$5 # All tables have an id field.

  if [ "$operation" == "createDb" ]; then
    echo ""
    echo "=> Testing that the db hasn't been created."
    echo ""

    # If createDb failed, then show tables in db should return that db doesn't exist.

    if [ "$component" == "spark" ]; then
      command="spark.sql(\"show tables in $db_name\").show"
      expectedOutput="Database '$db_name' not found"

      runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedOutput"
    else
      command="show tables in $TRINO_HIVE_SCHEMA.$db_name"
      expectedOutput="Schema '$db_name' does not exist"

      runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedOutput" "user"
    fi

    echo ""
    echo "=> Verified successfully that the db hasn't been created."
    echo ""
  elif [ "$operation" == "dropDb" ]; then
    echo ""
    echo "=> Testing that the db hasn't been dropped."
    echo ""

    # If dropDb failed, then db should exist in show databases.

    if [ "$component" == "spark" ]; then
      command="spark.sql(\"show databases\").show"
      expectedOutput="|$db_name|"

      runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"
    else
      command="show schemas in $TRINO_HIVE_SCHEMA"
      expectedOutput="$db_name"

      runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedOutput" "user"
    fi

    echo ""
    echo "=> Verified successfully that the db hasn't been dropped."
    echo ""
  elif [ "$operation" == "createTable" ]; then
    echo ""
    echo "=> Testing that the table hasn't been created."
    echo ""

    # If createTable failed, then select table should fail.

    if [ "$component" == "spark" ]; then
      command="spark.sql(\"select * from $db_name.$table_name\").show"
      expectedOutput="Table or view not found: $db_name.$table_name;"

      runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedOutput"
    else
      command="select * from $TRINO_HIVE_SCHEMA.$db_name.$table_name"
      expectedOutput="Table '$TRINO_HIVE_SCHEMA.$db_name.$table_name' does not exist"

      runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedOutput"
    fi

    echo ""
    echo "=> Verified successfully that the table hasn't been created."
    echo ""
  elif [ "$operation" == "dropTable" ]; then
    echo ""
    echo "=> Testing that the table hasn't been dropped."
    echo ""

    # If dropTable failed, then the table should exist in show tables from db.

    if [ "$component" == "spark" ]; then
      command="spark.sql(\"show tables from $db_name\").show"
      expectedOutput="$table_name"

      runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"
    else
      command="show tables in $TRINO_HIVE_SCHEMA.$db_name"
      expectedOutput="$table_name"

      runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedOutput" "user"
    fi

    echo ""
    echo "=> Verified successfully that the table hasn't been dropped."
    echo ""
  elif [ "$operation" == "insertInto" ]; then
    echo ""
    echo "=> Testing that the data haven't been inserted into the table."
    echo ""
    # In most insert into calls, the table isn't empty.
    # Therefore, it doesn't make sense to check the table dir in HDFS.

    # All tables have an id column. Check that the provided id
    # hasn't been inserted into the table.

    if [ "$component" == "spark" ]; then
      command="spark.sql(\"select id from $db_name.$table_name where id=$insert_id\").show"
      expectedOutput=$(cat <<EOF
+---+
| id|
+---+
+---+
EOF
)

      runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"
    else
      command="select id from $TRINO_HIVE_SCHEMA.$db_name.$table_name where id=$insert_id"
      expectedOutput="0 rows"

      runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedOutput"
    fi

    echo ""
    echo "=> Verified successfully that the data haven't been inserted into the table."
    echo ""
  else
    echo ""
    echo "Invalid operation. Try one of the following: createDb, dropDb, createTable, dropTable, insertInto"
    echo ""
  fi
}

# -- LOAD TESTING --
createSparkTableForTestingDdlOps() {
  user=$1

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$SETUP_CREATE_TABLE_FILE"
  else
    file="$LOAD_TEST_FILES_DIR_PATH/$SETUP_CREATE_TABLE_FILE"
  fi

  # This will be run only once during setup. We don't need to run it in the background.
  runScalaFileInSparkShell "bin/spark-shell --conf spark.db_name=\"default\" --conf spark.table_name=\"test2\" -I $file" "$user"
}

runCreateDropDbOnRepeatWithAccess() {
  user=$1
  iterations=$2
  location=$3
  background_run=$4

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$CREATE_DROP_DB_FILE"
  else
    file="$LOAD_TEST_FILES_DIR_PATH/$CREATE_DROP_DB_FILE"
  fi

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" --conf spark.db_location=\"$location\" -I $file" "$user" "$background_run"
}

runCreateDropTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$CREATE_DROP_TABLE_FILE"
  else
    file="$LOAD_TEST_FILES_DIR_PATH/$CREATE_DROP_TABLE_FILE"
  fi

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $file" "$user" "$background_run"
}

runInsertSelectTableOnRepeatWithAccess() {
  user=$1
  iterations=$2
  background_run=$3

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$INSERT_SELECT_TABLE_WITH_ACCESS_FILE"
  else
    file="$LOAD_TEST_FILES_DIR_PATH/$INSERT_SELECT_TABLE_WITH_ACCESS_FILE"
  fi

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $file" "$user" "$background_run"
}

runInsertSelectTableOnRepeatNoAccess() {
  user=$1
  iterations=$2
  background_run=$3

  file=
  if [ "$CURRENT_ENV" == "local" ]; then
    file="$INSERT_SELECT_TABLE_NO_ACCESS_FILE"
  else
    file="$LOAD_TEST_FILES_DIR_PATH/$INSERT_SELECT_TABLE_NO_ACCESS_FILE"
  fi

  runScalaFileInSparkShell "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $file" "$user" "$background_run"
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
