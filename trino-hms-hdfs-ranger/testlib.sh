#!/bin/bash

# Project names
PROJECT_RANGER="ranger"
PROJECT_HADOOP="hadoop"
PROJECT_HIVE="hive"
PROJECT_TRINO="trino"
PROJECT_SPARK="spark"

# Current repo paths
CURRENT_REPO="docker-setup-helper-scripts"

# Project branches
RANGER_BRANCH="ranger-2.4-with-hmsa"
HIVE_BRANCH=

# Project Build versions
RANGER_BUILD_VERSION="2.4.1-SNAPSHOT"
HADOOP_BUILD_VERSION="3.3.6"
HIVE_BUILD_VERSION=

configureHiveVersion() {
  if [[ "${HIVE_VERSION}" == "4" ]]; then
    echo ""
    echo "Configuring project for Hive 4."
    echo ""
    HIVE_BRANCH="hive4-latest"
    HIVE_BUILD_VERSION="4.0.0"
    RANGER_BRANCH="ranger-docker-hive4"
  else
    echo ""
    echo "Configuring project for Hive 3."
    echo ""
    HIVE_BRANCH="branch-3.1-build-fixed"
    HIVE_BUILD_VERSION="3.1.3-with-backport"
    RANGER_BRANCH="ranger-2.4-with-hmsa"
  fi
}

configureHiveVersion

# Dump file names
DEFAULT_POLICIES="1_defaults"
DEFAULT_AND_NO_HIVE="2_defaults_no_hive_perm_defaultdb"
HDFS_ACCESS="3_hdfs_all"
HDFS_AND_HIVE_ALL="4_hive_defaultdb_all"
TRINO_HDFS_AND_HIVE_ALL="4_trino_hdfs_hive_defaultdb_all"
HDFS_AND_HIVE_SELECT="5_hive_defaultdb_select"
HDFS_AND_HIVE_SELECT_ALTER="6_hive_defaultdb_select_alter"
HDFS_AND_HIVE_SELECT_ALTER_DROP="7_hive_defaultdb_select_alter_drop"
HDFS_AND_HIVE_AND_CREATE_HIVE_URL="8_hdfs_hive_create_hive_url"
HDFS_AND_HIVE_EXT_DB_ALL="hive_external_db_all"
HDFS_POLICIES_FOR_RANGER_TESTING="hdfs_policies_for_ranger_testing"

# Const shared variables
TRINO_TABLE="trino_test_table"
NEW_TRINO_TABLE_NAME="new_$TRINO_TABLE"
SPARK_TABLE="spark_test_table"
NEW_SPARK_TABLE_NAME="new_$SPARK_TABLE"
EXTERNAL_DB="poc_db"
DEFAULT_DB="default"
HDFS_DIR="test"
SPARK_EVENTS_DIR="spark-events"
HIVE_WAREHOUSE_DIR="opt/hive/data"
HIVE_WAREHOUSE_PARENT_DIR="opt/hive"
TMP_FILE="tmp_output.txt"
PG_TMP_OUT_FILE="pg_tmp_output.txt"
LAST_SUCCESS_FILE="lastSuccess.txt"
PRINT_CMD=""

# Container names
# Compose V2
NAMENODE_HOSTNAME="docker-namenode-1"
DN1_HOSTNAME="docker-datanode-1"
DN2_HOSTNAME="docker-datanode-2"
DN3_HOSTNAME="docker-datanode-3"

HMS_HOSTNAME="hive-metastore-ranger-hive-metastore-1"
HMS_POSTGRES_HOSTNAME="hive-metastore-ranger-postgres-1"

RANGER_HOSTNAME="ranger"
RANGER_POSTGRES_HOSTNAME="ranger-postgres"

TRINO_HOSTNAME="trino-coordinator-1"

SPARK_MASTER_HOSTNAME="spark-master-1"
SPARK_WORKER1_HOSTNAME="spark-worker-1"

# Spark test variables
SPARK_TEST_FILENAME="test.scala"
SPARK_TEST_PATH="tests/spark"
SPARK_TEST_FOR_EXCEPTION_FILENAME="test_for_exception.scala"
SPARK_TEST_NO_EXCEPTION_FILENAME="test_no_exception.scala"
SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME="test_external_table_creation_no_exception.scala"
SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME="test_external_table_creation_for_exception.scala"
SPARK_TEST_SUCCESS_MSG="Test passed"

# Ranger jars names
RANGER_COMMON_UBER_JAR_NAME="ranger-plugins-common-$RANGER_BUILD_VERSION-jar-with-dependencies.jar"
RANGER_COMMON_JAR_NAME="ranger-plugins-common-$RANGER_BUILD_VERSION.jar"

RANGER_AUDIT_JAR_NAME="ranger-plugins-audit-$RANGER_BUILD_VERSION.jar"

RANGER_HDFS_JAR_NAME="ranger-hdfs-plugin-$RANGER_BUILD_VERSION.jar"
RANGER_HIVE_JAR_NAME="ranger-hive-plugin-$RANGER_BUILD_VERSION.jar"

# Ranger jars, paths from Ranger project root
RANGER_COMMON_UBER_JAR="agents-common/target/$RANGER_COMMON_UBER_JAR_NAME"
RANGER_COMMON_JAR="agents-common/target/$RANGER_COMMON_JAR_NAME"
RANGER_AUDIT_JAR="agents-audit/target/$RANGER_AUDIT_JAR_NAME"

RANGER_HDFS_JAR="hdfs-agent/target/$RANGER_HDFS_JAR_NAME"
RANGER_HIVE_JAR="hive-agent/target/$RANGER_HIVE_JAR_NAME"

# Hive jars names
HIVE_BEELINE_JAR_NAME="hive-beeline-$HIVE_BUILD_VERSION.jar"
HIVE_CLI_JAR_NAME="hive-cli-$HIVE_BUILD_VERSION.jar"
HIVE_COMMON_JAR_NAME="hive-common-$HIVE_BUILD_VERSION.jar"
HIVE_EXEC_CORE_JAR_NAME="hive-exec-$HIVE_BUILD_VERSION-core.jar"
HIVE_EXEC_JAR_NAME="hive-exec-$HIVE_BUILD_VERSION.jar"
HIVE_JDBC_STANDALONE_JAR_NAME="hive-jdbc-$HIVE_BUILD_VERSION-standalone.jar"
HIVE_JDBC_JAR_NAME="hive-jdbc-$HIVE_BUILD_VERSION.jar"
HIVE_LLAP_COMMON_JAR_NAME="hive-llap-common-$HIVE_BUILD_VERSION.jar"
HIVE_METASTORE_JAR_NAME="hive-metastore-$HIVE_BUILD_VERSION.jar"
HIVE_SERDE_JAR_NAME="hive-serde-$HIVE_BUILD_VERSION.jar"
HIVE_SERVICE_RPC_JAR_NAME="hive-service-rpc-$HIVE_BUILD_VERSION.jar"
HIVE_SHIMS_JAR_NAME="hive-shims-$HIVE_BUILD_VERSION.jar"
HIVE_SHIMS_COMMON_JAR_NAME="hive-shims-common-$HIVE_BUILD_VERSION.jar"
HIVE_SHIMS_SCHEDULER_JAR_NAME="hive-shims-scheduler-3.1.3-with-backport.jar"
HIVE_SPARK_CLIENT_JAR_NAME="hive-spark-client-3.1.3-with-backport.jar"
HIVE_STANDALONE_METASTORE_JAR_NAME="hive-standalone-metastore-3.1.3-with-backport.jar"

# We probably don't need those. Don't copy them for now. They are both under 'ql/target'
HIVE_EXEC_FALLBACKAUTHORIZER_JAR_NAME="hive-exec-$HIVE_BUILD_VERSION-fallbackauthorizer.jar"
HIVE_ORIGINAL_EXEC_JAR_NAME="original-hive-exec-$HIVE_BUILD_VERSION.jar"

# Hive jars, paths from Hive project root
HIVE_BEELINE_JAR="beeline/target/$HIVE_BEELINE_JAR_NAME"
HIVE_CLI_JAR="cli/target/$HIVE_CLI_JAR_NAME"
HIVE_COMMON_JAR="common/target/$HIVE_COMMON_JAR_NAME"
HIVE_EXEC_CORE_JAR="ql/target/$HIVE_EXEC_CORE_JAR_NAME"
HIVE_EXEC_JAR="ql/target/$HIVE_EXEC_JAR_NAME"
HIVE_JDBC_STANDALONE_JAR="jdbc/target/$HIVE_JDBC_STANDALONE_JAR_NAME"
HIVE_JDBC_JAR="jdbc/target/$HIVE_JDBC_JAR_NAME"
HIVE_LLAP_COMMON_JAR="llap-common/target/$HIVE_LLAP_COMMON_JAR_NAME"
HIVE_METASTORE_JAR="metastore/target/$HIVE_METASTORE_JAR_NAME"
HIVE_SERDE_JAR="serde/target/$HIVE_SERDE_JAR_NAME"
HIVE_SERVICE_RPC_JAR="service-rpc/target/$HIVE_SERVICE_RPC_JAR_NAME"
HIVE_SHIMS_JAR="shims/aggregator/target/$HIVE_SHIMS_JAR_NAME"
HIVE_SHIMS_COMMON_JAR="shims/common/target/$HIVE_SHIMS_COMMON_JAR_NAME"
HIVE_SHIMS_SCHEDULER_JAR="shims/scheduler/target/$HIVE_SHIMS_SCHEDULER_JAR_NAME"
HIVE_SPARK_CLIENT_JAR="spark-client/target/$HIVE_SPARK_CLIENT_JAR_NAME"
HIVE_STANDALONE_METASTORE_JAR="standalone-metastore/target/$HIVE_STANDALONE_METASTORE_JAR_NAME"

# Calcite jar
CALCITE_CORE_JAR_NAME="calcite-core-1.36.0.jar"

# Table names
TABLE_PERSONS="persons"
TABLE_ANIMALS="animals"
TABLE_SPORTS="sports"

getHostnameFromName() {
  name=$1

  if [ "$name" == "namenode" ]; then
    echo "$NAMENODE_HOSTNAME" 
  elif [ "$name" == "dn1" ]; then
    echo "$DN1_HOSTNAME"
  elif [ "$name" == "dn2" ]; then
    echo "$DN2_HOSTNAME"
  elif [ "$name" == "dn3" ]; then
    echo "$DN3_HOSTNAME"
  elif [ "$name" == "hms" ]; then
    echo "$HMS_HOSTNAME"
  elif [ "$name" == "hms_postgres" ]; then
    echo "$HMS_POSTGRES_HOSTNAME"
  elif [ "$name" == "ranger" ]; then
    echo "$RANGER_HOSTNAME"
  elif [ "$name" == "ranger_postgres" ]; then
    echo "$RANGER_POSTGRES_HOSTNAME"
  elif [ "$name" == "trino" ]; then
    echo "$TRINO_HOSTNAME"
  elif [ "$name" == "spark_master" ]; then
    echo "$SPARK_MASTER_HOSTNAME"
  elif [ "$name" == "spark_worker1" ]; then
    echo "$SPARK_WORKER1_HOSTNAME"
  else
    echo "The provided name is unknown."
    echo "Try one of the following: "
    echo "[namenode, dn1, dn2, dn3, hms, hms_postgres, ranger, ranger_postgres, trino, spark_master, spark_worker1]"
  fi
}

cpJarIfNotExist() {
  path_to_copy=$1
  jar_path=$2
  jar_name=$3

  if find "$path_to_copy" -type f | grep -E "/$jar_name$"; then
    echo "Jar '$jar_name' exists on destination path."
  else
    if ! find "$jar_path" -type f | grep -E "/$jar_name$"; then
      echo "Jar '$jar_name' doesn't exist on source path. This jar is not going to be copied."
    else
      echo "Jar '$jar_name' doesn't exist on destination path. Copying..."
      execCmdAndHandleErrorIfNeeded "cp $jar_path $path_to_copy"
    fi
  fi
}

setupSparkJarsIfNeeded() {
  abs_path=$1

  dir_base_path="$abs_path/$CURRENT_REPO/compose/spark/conf"
  jars_dir_name="hive-jars"
  jars_dir_path="$dir_base_path/$jars_dir_name"
  hive_jar_regex_prefix="hive-*"
  # Flag to track if any file does not contain $HIVE_BUILD_VERSION
  delete_files=false

  for file in $jars_dir_path/$hive_jar_regex_prefix; do
    if [[ ! $file =~ $HIVE_BUILD_VERSION ]]; then
      delete_files=true
      break # Exit the loop as one file not matching is enough to decide on deletion
    fi
  done

  if [ "$delete_files" = true ]; then
    echo "Not all jar files contain the build identifier. Removing files..."
    rm -rf $jars_dir_path/$hive_jar_regex_prefix
    echo "Files removed."
  else
    echo "All jar files contain the build identifier."
  fi

  # Check if the directory exists.
  if find "$dir_base_path" -type d | grep -E "/$jars_dir_name$"; then
    echo "Directory '$jars_dir_name' exists."
  else
    echo "Directory '$jars_dir_name' doesn't exist. Creating..."
    execCmdAndHandleErrorIfNeeded "mkdir $jars_dir_path"
  fi

  # Download calcite core jar if it doesn't exist.
  if find "$jars_dir_path" -type f | grep -E "/$CALCITE_CORE_JAR_NAME$"; then
    echo "Jar '$CALCITE_CORE_JAR_NAME' exists."
  else
    echo "Jar '$CALCITE_CORE_JAR_NAME' doesn't exist. Downloading..."
    calcite_download_url="https://repo1.maven.org/maven2/org/apache/calcite/calcite-core/1.36.0/calcite-core-1.36.0.jar"
    if curl -o "$jars_dir_path/$CALCITE_CORE_JAR_NAME" "$calcite_download_url"; then
      echo "Downloading '$CALCITE_CORE_JAR_NAME' succeeded."
    else
      echo "Downloading '$CALCITE_CORE_JAR_NAME' failed. Exiting..."
      exit 1
    fi
  fi

  echo ""
  # Copy jars from Hive.
  hive_beeline_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_BEELINE_JAR"
  hive_cli_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_CLI_JAR"
  hive_common_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_COMMON_JAR"
  hive_exec_core_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_EXEC_CORE_JAR"
  hive_exec_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_EXEC_JAR"
  hive_jdbc_standalone_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_JDBC_STANDALONE_JAR"
  hive_jdbc_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_JDBC_JAR"
  hive_llap_common_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_LLAP_COMMON_JAR"
  hive_metastore_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_METASTORE_JAR"
  hive_serde_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SERDE_JAR"
  hive_service_rpc_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SERVICE_RPC_JAR"
  hive_shims_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SHIMS_JAR"
  hive_shims_common_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SHIMS_COMMON_JAR"
  hive_shims_scheduler_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SHIMS_SCHEDULER_JAR"
  hive_spark_client_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_SPARK_CLIENT_JAR"
  hive_standalone_metastore_jar_path="$abs_path/$PROJECT_HIVE/$HIVE_STANDALONE_METASTORE_JAR"

  cpJarIfNotExist "$jars_dir_path" "$hive_beeline_jar_path" "$HIVE_BEELINE_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_cli_jar_path" "$HIVE_CLI_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_common_jar_path" "$HIVE_COMMON_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_exec_core_jar_path" "$HIVE_EXEC_CORE_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_exec_jar_path" "$HIVE_EXEC_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_jdbc_standalone_jar_path" "$HIVE_JDBC_STANDALONE_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_jdbc_jar_path" "$HIVE_JDBC_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_llap_common_jar_path" "$HIVE_LLAP_COMMON_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_metastore_jar_path" "$HIVE_METASTORE_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_serde_jar_path" "$HIVE_SERDE_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_service_rpc_jar_path" "$HIVE_SERVICE_RPC_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_shims_jar_path" "$HIVE_SHIMS_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_shims_common_jar_path" "$HIVE_SHIMS_COMMON_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_shims_scheduler_jar_path" "$HIVE_SHIMS_SCHEDULER_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_spark_client_jar_path" "$HIVE_SPARK_CLIENT_JAR_NAME"
  cpJarIfNotExist "$jars_dir_path" "$hive_standalone_metastore_jar_path" "$HIVE_STANDALONE_METASTORE_JAR_NAME"
}

setupRangerJarsIfNeeded() {
  abs_path=$1

  dir_base_path="$abs_path/$CURRENT_REPO/compose/hadoop/conf"
  jars_dir_name="ranger-jars"
  jars_dir_path="$abs_path/$CURRENT_REPO/compose/hadoop/conf/$jars_dir_name"

  # Check if the directory exists.
  if find "$dir_base_path" -type d | grep -E "/$jars_dir_name$"; then
    echo "Directory '$jars_dir_name' exists."
  else
    echo "Directory '$jars_dir_name' doesn't exist. Creating..."
    execCmdAndHandleErrorIfNeeded "mkdir $jars_dir_path"
  fi

  # Copy jars from Ranger.
  ranger_common_uber_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_COMMON_UBER_JAR"
  ranger_audit_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_AUDIT_JAR"
  ranger_hdfs_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_HDFS_JAR"

  cpJarIfNotExist "$jars_dir_path" "$ranger_common_uber_jar_path" "$RANGER_COMMON_UBER_JAR"
  cpJarIfNotExist "$jars_dir_path" "$ranger_audit_jar_path" "$RANGER_AUDIT_JAR"
  cpJarIfNotExist "$jars_dir_path" "$ranger_hdfs_jar_path" "$RANGER_HDFS_JAR"
}

handleRangerEnv() {
  abs_path=$1
  op=$2

  ranger_path="$abs_path/$PROJECT_RANGER"
  cd $ranger_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_RANGER' env."
    echo ""

    ./ranger_in_docker up

    echo ""
    echo "'$PROJECT_RANGER' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_RANGER' env."
    echo ""

    ./ranger_in_docker down

    echo ""
    echo "'$PROJECT_RANGER' env stopped."
    echo ""
  fi
}

handleHadoopEnv() {
  abs_path=$1
  op=$2

  hadoop_docker_path="$abs_path/$CURRENT_REPO/compose/hadoop/docker"
  cd $hadoop_docker_path

  if [ "$op" == "start" ]; then
    setupRangerJarsIfNeeded "$abs_path"

    echo ""
    echo "Starting '$PROJECT_HADOOP' env."
    echo ""

    docker compose -f "$hadoop_docker_path/docker-compose.yml" up -d --scale datanode=3

    echo ""
    echo "'$PROJECT_HADOOP' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_HADOOP' env."
    echo ""

    docker compose -f "$hadoop_docker_path/docker-compose.yml" down

    echo ""
    echo "'$PROJECT_HADOOP' env stopped."
    echo ""
  fi
}

handleHiveEnv() {
  abs_path=$1
  op=$2
  hive_url_policies_enabled=$3

  hive_docker_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD_VERSION-bin/apache-hive-$HIVE_BUILD_VERSION-bin/compose/hive-metastore-ranger"

  if [ "$hive_url_policies_enabled" == "true" ]; then
      mv "$hive_docker_path/conf/ranger-hive-security.xml" "$hive_docker_path/conf/ranger-hive-security-old.xml"
      echo "Rename original ranger-hive-security configuration."

      cp "$abs_path/$CURRENT_REPO/compose/hive/conf/ranger-hive-security_hive_url_policies_enabled.xml" "$hive_docker_path/conf/ranger-hive-security.xml"
      echo "ranger-hive-security configuration for Hive URL policies copied to Hive."
  fi
  cd $hive_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_HIVE' env."
    echo ""

    # 'docker-compose' uses v1
    # 'docker compose' uses v2, compose was integrated into the docker CLI tool as a plugin.
    # Here we need to use v2 because one of the convention changes is that
    # in v1 names are concatenated using '_' while in v2 this is done using '-'.
    # Spark shell complains about the hive-metastore name because of the '_'.
    # Changing to v2 solves the issue. Check the following exception:
    # org.apache.hadoop.hive.metastore.api.MetaException: Got exception: java.net.URISyntaxException Illegal character in hostname at index 30: thrift://hive-metastore-ranger_hive-metastore_1.common-network:9083

    # With compose v2, the command wasn't reading the path properly.
    # Explicitly specifying the docker-compose file solved the issue.
    docker compose -f "$hive_docker_path/docker-compose.yaml" up -d

    echo ""
    echo "'$PROJECT_HIVE' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_HIVE' env."
    echo ""

    docker compose -f "$hive_docker_path/docker-compose.yaml" down

    echo ""
    echo "'$PROJECT_HIVE' env stopped."
    echo ""

    mv "$hive_docker_path/conf/ranger-hive-security-old.xml" "$hive_docker_path/conf/ranger-hive-security.xml" 2>/dev/null || true
    echo "Original ranger-hive-security configuration restored."
  fi
}

handleTrinoEnv() {
  abs_path=$1
  op=$2

  trino_path="$abs_path/docker-setup-helper-scripts/compose/trino"
  docker_compose_path="$trino_path/docker/docker-compose.yml"

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_TRINO' env."

    docker compose -p trino -f $docker_compose_path up -d

    echo ""
    echo "'$PROJECT_TRINO' env started."
  else
    echo ""
    echo "Stopping '$PROJECT_TRINO' env."

    docker compose -p trino -f $docker_compose_path down

    echo ""
    echo "'$PROJECT_TRINO' env stopped."
  fi
}

handleSparkEnv() {
  abs_path=$1
  op=$2

  spark_path="$abs_path/$CURRENT_REPO/compose/spark"
  docker_compose_path="$spark_path/docker/docker-compose.yml"

  if [ "$op" == "start" ]; then
    # Setup the Spark jars if they don't exist.
    setupSparkJarsIfNeeded "$abs_path"

    echo ""
    echo "Starting '$PROJECT_SPARK' env."

    echo ""
    echo "Creating /$SPARK_EVENTS_DIR dir and changing permissions."

    mkdir $spark_path/conf/$SPARK_EVENTS_DIR
    chmod 777 $spark_path/conf/$SPARK_EVENTS_DIR

    docker compose -p spark -f $docker_compose_path up -d --scale worker=3

    echo ""
    echo "'$PROJECT_SPARK' env started."
  else
    echo ""
    echo "Stopping '$PROJECT_SPARK' env."


    docker compose -p spark -f $docker_compose_path down

    echo ""
    echo "'$PROJECT_SPARK' env stopped."

    echo "Cleaning up $SPARK_EVENTS_DIR dir."
    rm -r -f $spark_path/conf/$SPARK_EVENTS_DIR
  fi
}

checkProjectExists() {
  path=$1
  project=$2

  if ls $path | grep $project; then
    echo 0
  else
    echo 1
  fi
}

exitIfProjectNotExist() {
  path=$1
  project=$2

  res=$(checkProjectExists "$path" "$project")

  if [ "$res" == 1 ]; then
    echo "Project '$project' doesn't exist. Exiting..."
    exit 1
  else
    echo "Project '$project' exists."
  fi
}

cloneProjectIfNotExist() {
  base_path=$1
  project_name=$2
  github_user=$3

  existsLocally=$(checkProjectExists $base_path $project_name)

  if [ "$existsLocally" == 1 ]; then
    echo "'$project_name' doesn't exist locally, cloning..."
    echo ""
    cd "$base_path"
    if git clone "git@github.com:$github_user/$project_name.git"; then
      echo ""
      echo "Cloning '$project_name' succeeded."
      echo ""
    else
      echo "Cloning '$project_name' failed. Exiting..."
      exit 1
    fi
  else
    echo ""
    echo "'$project_name' exists locally."
    echo ""
  fi
}

updateProjectRepo() {
  base_path=$1
  project_name=$2
  github_remote_user=$3
  github_branch=$4

  echo "Updating '$project_name' repo."
  cd "$base_path/$project_name"

  if [ "$github_remote_user" != "origin" ]; then
    if git remote -v | grep "$github_remote_user"; then
      echo "Remote from user '$github_remote_user', already exists in project '$project_name'."
    else
      echo "Remote from user '$github_remote_user', doesn't exist in project '$project_name', adding..."

      if git remote add "$github_remote_user" "git@github.com:$github_remote_user/$project_name.git"; then
        echo "Adding remote repo for project '$project_name' succeeded."
      else
        echo "Adding remote repo for project '$project_name' failed. Exiting..."
        exit 1
      fi
    fi
  fi

  if git fetch $github_remote_user $github_branch; then
    echo "Fetching '$github_remote_user $github_branch' succeeded."
  else
    echo "Fetching '$github_remote_user $github_branch' failed. Exiting..."
    exit 1
  fi

  curr_branch=$(git branch --show-current)

  if [ "$curr_branch" != "$github_branch" ]; then
    echo ""
    echo "Current branch is $curr_branch."
    
    if [ "$github_remote_user" == "origin" ]; then
      # If we go 'git checkout origin/branch', then it will checkout
      # to the particular commit from the remote branch.
      echo "Checking out to branch '$github_branch'."
      echo ""
      if git checkout $github_branch; then
        echo "Checking out to branch '$github_branch' succeeded."
      else
        echo "Checking out to branch '$github_branch' failed. Exiting..."
        exit 1
      fi
    else
      echo "Checking out to branch '$github_remote_user/$github_branch'."
      echo ""
      if git checkout $github_remote_user/$github_branch; then
        echo "Checking out to branch '$github_remote_user/$github_branch' succeeded."
      else
        echo "Checking out to branch '$github_remote_user/$github_branch' failed. Exiting..."
        exit 1
      fi
    fi
  fi

  echo ""
  echo "Pulling changes from '$github_remote_user $github_branch'."

  if git pull $github_remote_user $github_branch; then
    echo "Pulling changes from '$github_remote_user $github_branch' succeeded."
  else
    echo "Pulling changes from '$github_remote_user $github_branch' failed. Exiting..."
    exit 1
  fi
  
  echo ""
  echo "Finished updating '$project_name' repo."
  echo ""
}

printCmdString() {
  str=$1

  echo ""
  echo "Command being run: -- '$str'"
  echo ""
}

createHdfsDir() {
  dir_name=$1

  c="hdfs dfs -mkdir -p /$dir_name"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$DN1_HOSTNAME" bash -c "$c"
  fi
}

createHdfsFile() {
  dir_name=$1
  file_name=${2:-"test.csv"} # Provide a default value if not set.

  c="hdfs dfs -put $file_name /$dir_name"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$DN1_HOSTNAME" bash -c "$c"
  fi
}

createHdfsFileAsUser() {
  user=$1
  dir_name=$2
  file_name=${3:-"test.csv"} # Provide a default value if not set.

  c="hdfs dfs -put $file_name /$dir_name"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it -u "$user" "$DN1_HOSTNAME" bash -c "$c"
  fi
}


changeHdfsDirPermissions() {
  perms=$1
  dir_name=$2

  c="hdfs dfs -chmod $perms /$dir_name"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$DN1_HOSTNAME" bash -c "$c"
  fi
}

performTrinoCmd() {
  # Join all args with space
  trino_cmd="$*"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$trino_cmd"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$trino_cmd"
  fi
}

createTrinoTable() {
  table_name=$1
  hdfs_dir_name=$2
  schema_name=$3

  c="create table hive.$schema_name.$table_name (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode:8020/$hdfs_dir_name',format = 'CSV');"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
  fi
}

selectDataFromTrinoTable() {
  table_name=$1
  schema_name=$2

  c="select * from hive.$schema_name.$table_name;"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
  fi
}

alterTrinoTable() {
  old_table_name=$1
  new_table_name=$2
  schema_name=$3

  c="alter table hive.$schema_name.$old_table_name rename to $new_table_name;"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
  fi
}

dropTrinoTable() {
  table_name=$1
  schema_name=$2

  c="drop table hive.$schema_name.$table_name;"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
  fi
}

createSchemaWithTrino() {
  schema_name=$1

  c="CREATE SCHEMA hive.$schema_name WITH (location = 'hdfs://namenode/opt/hive/data/$schema_name/external/$schema_name.db');"

  if [ "$PRINT_CMD" == "true" ]; then
    printCmdString "$c"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
  fi
}

dropSchemaWithTrino() {
  schema_name=$1
  use_cascade=$2

  if [ "$use_cascade" == "true" ]; then

    c="DROP SCHEMA hive.$schema_name CASCADE;"

    if [ "$PRINT_CMD" == "true" ]; then
      printCmdString "$c"
    else
      docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
    fi
  else

    c="DROP SCHEMA hive.$schema_name;"

    if [ "$PRINT_CMD" == "true" ]; then
      printCmdString "$c"
    else
      docker exec -it "$TRINO_HOSTNAME" trino --execute="$c"
    fi
  fi
}

# Currently, `set -e` has been set on top of every script.
# Therefore, on any failure, the script will exit.
# For that reason, this method might not be needed and probably can be deleted.
execCmdAndHandleErrorIfNeeded() {
  # cmd will be a string and therefore we need to handle it properly.
  # We need to call $($cmd), so that it will be treated as a command.
  cmd=$1
  action_msg=$2

  echo ""
  if [ "$action_msg" == "" ]; then
    action_msg="Operation"
    echo "Executing cmd: "
    echo "$cmd"
    echo ""
  else
    echo "$action_msg."
  fi

  if $($cmd); then
    echo "$action_msg succeeded."
    echo ""
  else
    echo "$action_msg failed. Exiting..."
    exit 1
  fi
}

createOrUpdateLastSuccessFile() {
  abs_path=$1

  cd "$abs_path/$CURRENT_REPO"

  # Check if file exists
  if find . -type f | grep -E "/$LAST_SUCCESS_FILE$"; then
    echo "File '$LAST_SUCCESS_FILE' exists."

    echo "Cleaning the file."
    # Clean the file.
    echo -e "" > "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  else
    echo "File '$LAST_SUCCESS_FILE' doesn't exist. Creating..."
    touch "$LAST_SUCCESS_FILE"
  fi

  # Current repo
  echo ""
  
  curr_branch=$(git branch --show-current)
  echo "Current branch for repo '$CURRENT_REPO' is '$curr_branch'."
  
  curr_commit_SHA=$(git rev-parse HEAD | awk NF)
  echo "Current commit SHA for repo '$CURRENT_REPO' is '$curr_commit_SHA'."

  # Write text to the file.
  echo "## $CURRENT_REPO ##" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Branch: $curr_branch" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Commit: $curr_commit_SHA" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"

  # Ranger
  echo ""
  cd "$abs_path/$PROJECT_RANGER"
  
  ranger_branch=$(git branch --show-current)
  echo "Current branch for repo '$PROJECT_RANGER' is '$ranger_branch'."

  ranger_commit_SHA=$(git rev-parse HEAD | awk NF)
  echo "Current branch for repo '$PROJECT_RANGER' is '$ranger_commit_SHA'."

  # Write text to the file.
  echo "## $PROJECT_RANGER ##" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Branch: $ranger_branch" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Commit: $ranger_commit_SHA" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"

  # Hive
  echo ""
  cd "$abs_path/$PROJECT_HIVE"
  hive_branch=$(git branch --show-current)
  echo "Current branch for repo '$PROJECT_HIVE' is '$hive_branch'."

  hive_commit_SHA=$(git rev-parse HEAD | awk NF)
  echo "Current branch for repo '$PROJECT_HIVE' is '$hive_commit_SHA'."

  # Write text to the file.
  echo "## $PROJECT_HIVE ##" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Branch: $hive_branch" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Commit: $hive_commit_SHA" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"

  # TODO: add Spark.
}

retryOperationIfNeeded() {
  abs_path=$1
  cmd=$2
  expMsg=$3
  expFailure=$4
  msgNotPresent=$5
  exp_exit_code=1

  result=""

  if [ "$expFailure" == "true" ]; then
    result="failed"
  else
    result="succeeded"
    exp_exit_code=0
  fi

  echo ""
  echo "- INFO: Some wait time might be needed for the policy update to get picked up. Retry a few times if needed."
  echo ""

  counter=0
  while [[ "$counter" -le 10 ]]; do
    if [ "$counter" -eq 10 ]; then
      echo ""
      echo "- RESULT -> FAILURE: Operation exceeded the retry limit. Exiting..."
      echo "---------------------------------------------------"
      exit 1
    fi

    echo "- INFO: Counter=$counter"

    # If we print the command being run, right before every execution
    # then the print will be stored in the tmp file along with the stdout.
    # This is going to make retryOperationIfNeeded() result in unexpected failures.
    #
    # E.g.
    # * We want to create a schema in trino
    # * The expected output is just the phrase 'CREATE SCHEMA'
    # * The command to create a schema, starts with the phrase 'CREATE SCHEMA ...'
    # * We do a 'grep' on the tmp file to check that the output contains 'CREATE SCHEMA'
    # * The command failed and the output is some error
    # * 'CREATE SCHEMA' exists in the command, which is present in the tmp file.
    # * 'grep' succeeds, exit status will be 0 regardless of the output.
    #
    # To fix that, each method will either print the command or execute it.
    # We will call each method twice. Once with the print parameter and once without.
    PRINT_CMD="true"
    $cmd

    # Restore the flag to empty.
    PRINT_CMD=""

    echo ""
    echo "### Stdout- {"
    echo ""

    sleep 3

    # Use the 'tee' command, which prints the output in the stdout
    # and writes it in a file at the same time.
    $cmd 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"
    exit_code=${PIPESTATUS[0]}

    echo ""
    echo "} -Stdout ###"
    echo ""

    if [ $exit_code -ne $exp_exit_code ]; then
      echo ""
      echo "- Unexpected exit code. Expected: $exp_exit_code. Actual: $exit_code."
      counter=$(($counter + 1))
      continue
    fi

    if [ "$msgNotPresent" == "true" ]; then
      # '> /dev/null' hides the grep output. Remove it to reveal the output.
      echo ""
      echo "- Not expected msg: $expMsg"
      echo ""
      if !(grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null); then
        # echo "- DEBUG: Exit code NotExp-Suc-Grep: $?"
        # echo ""
        # echo "- DEBUG: NotExp-Suc-Output= "
        # cat "$abs_path/$CURRENT_REPO/$TMP_FILE"
        # echo "- DEBUG: Exit code NotExp-Suc-Output: $?"
        echo "- RESULT -> SUCCESS: Operation $result as expected."
        echo "---------------------------------------------------"
        break
      else
        echo "- RESULT -> FAILURE: Operation $result not as expected."
        echo "---------------------------------------------------"
        counter=$(($counter + 1))
        continue
      fi
    else
      echo ""
      echo "- Expected Msg: $expMsg"
      echo ""
      if grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
        # echo "- DEBUG: Exit code NotExp-Fail-Grep: $?"
        # echo ""
        # echo "- DEBUG: NotExp-Fail-Output= "
        # cat "$abs_path/$CURRENT_REPO/$TMP_FILE"
        # echo "- DEBUG: Exit code NotExp-Fail-Output: $?"
        echo "- RESULT -> SUCCESS: Operation $result as expected."
        echo "---------------------------------------------------"
        break
      else
        echo "- RESULT -> FAILURE: Operation $result not as expected."
        echo "---------------------------------------------------"
        counter=$(($counter + 1))
        continue
      fi
    fi
  done
}

waitForPoliciesUpdate() {
  wait_time_sec=30
  echo ""
  echo "- INFO: Waiting $wait_time_sec sec to make sure enough time has passed for the policies to get updated."
  sleep "$wait_time_sec"
}

cpSparkTest() {
  testFilePath=$1

  docker cp "$testFilePath" "$SPARK_MASTER_HOSTNAME":/opt/spark/"$SPARK_TEST_FILENAME"
}

runSparkTest() {
  testFileName=$1
  sql_arg=$(echo -n "$2" | base64 --decode)
  msg_arg=$(echo -n "$3" | base64 --decode)
  message="Running Spark test: [$testFileName] with arguments sql_arg: [$sql_arg] and msg_arg: [$msg_arg]"

  if [ "$PRINT_CMD" == "true" ]; then
      printCmdString "$message"
  else
    docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.app.sql=\"$sql_arg\" --conf spark.app.msg=\"$msg_arg\" -I test.scala"
  fi
}

# This function is created to allow for substitutes or changes if base64 works differently on different systems.
# We can achieve the correct variable substitution and space handling by encoding and decoding the string.
base64encode() {
  input=$1

  # Because of OS differences, it is necessary to use -w 0 for Linux distros.
  if [[ $(uname) != "Darwin"* ]]; then
    echo -n "$input" | base64 -w 0
  else
    echo -n "$input" | base64
  fi
}