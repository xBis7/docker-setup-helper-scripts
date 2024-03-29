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
RANGER_BRANCH="ranger-docker-hdfs"
HADOOP_BRANCH="hadoop-3.3.6-docker"
HIVE_BRANCH=

# Builds
HIVE_BUILD=

configureHiveVersion() {
  if [[ "${HIVE_VERSION}" == "4" ]]; then
    echo "Configuring project for Hive 4."
    HIVE_BRANCH="hive4-latest"
    HIVE_BUILD="4.0.0-beta-2-SNAPSHOT"
    RANGER_BRANCH="ranger-docker-hive4"
  else
    echo "Configuring project for Hive 3."
    HIVE_BRANCH="branch-3.1-build-fixed"
    HIVE_BUILD="3.1.3"
    RANGER_BRANCH="ranger-docker-hdfs"
  fi
}

configureHiveVersion

# Dump file names
DEFAULT_POLICIES="1_defaults"
DEFAULT_AND_NO_HIVE="2_defaults_no_hive_perm_defaultdb"
HDFS_ACCESS="3_hdfs_all"
HDFS_AND_HIVE_ALL="4_hive_defaultdb_all"
HDFS_AND_HIVE_SELECT="5_hive_defaultdb_select"
HDFS_AND_HIVE_SELECT_ALTER="6_hive_defaultdb_select_alter"
HDFS_AND_HIVE_SELECT_ALTER_DROP="7_hive_defaultdb_select_alter_drop"
HDFS_AND_HIVE_AND_CREATE_HIVE_URL="8_hdfs_hive_create_hive_url"
HDFS_AND_HIVE_EXT_DB_ALL="hive_external_db_all"

# Const shared variables
TRINO_TABLE="trino_test_table"
NEW_TRINO_TABLE_NAME="new_$TRINO_TABLE"
SPARK_TABLE="spark_test_table"
NEW_SPARK_TABLE_NAME="new_$SPARK_TABLE"
EXTERNAL_DB="poc_db"
HDFS_DIR="test"
TMP_FILE="tmp_output.txt"
LAST_SUCCESS_FILE="lastSuccess.txt"

# Container names
# Compose V2
NAMENODE_HOSTNAME="hadoop-ranger-namenode-1"
DN1_HOSTNAME="hadoop-ranger-datanode-1"
DN2_HOSTNAME="hadoop-ranger-datanode-2"
DN3_HOSTNAME="hadoop-ranger-datanode-3"

HMS_HOSTNAME="hive-metastore-ranger-hive-metastore-1"
HMS_POSTGRES_HOSTNAME="hive-metastore-ranger-postgres-1"

RANGER_HOSTNAME="ranger"
RANGER_POSTGRES_HOSTNAME="ranger-postgres"

TRINO_HOSTNAME="trino-coordinator-1"

SPARK_MASTER_HOSTNAME="spark-master-1"
SPARK_WORKER1_HOSTNAME="spark-worker-1"

# Ranger jars names
RANGER_COMMON_JAR_NAME="ranger-plugins-common-3.0.0-SNAPSHOT-jar-with-dependencies.jar"
RANGER_AUDIT_JAR_NAME="ranger-plugins-audit-3.0.0-SNAPSHOT.jar"

RANGER_HDFS_JAR_NAME="ranger-hdfs-plugin-3.0.0-SNAPSHOT.jar"
RANGER_HIVE_JAR_NAME="ranger-hive-plugin-3.0.0-SNAPSHOT.jar"

# Ranger jars, paths from Ranger project root
RANGER_COMMON_JAR="agents-common/target/$RANGER_COMMON_JAR_NAME"
RANGER_AUDIT_JAR="agents-audit/target/$RANGER_AUDIT_JAR_NAME"

RANGER_HDFS_JAR="hdfs-agent/target/$RANGER_HDFS_JAR_NAME"
RANGER_HIVE_JAR="hive-agent/target/$RANGER_HIVE_JAR_NAME"

# Hive jars names
HIVE_BEELINE_JAR_NAME="hive-beeline-$HIVE_BUILD.jar"
HIVE_CLI_JAR_NAME="hive-cli-$HIVE_BUILD.jar"
HIVE_COMMON_JAR_NAME="hive-common-$HIVE_BUILD.jar"
HIVE_EXEC_CORE_JAR_NAME="hive-exec-$HIVE_BUILD-core.jar"
HIVE_EXEC_JAR_NAME="hive-exec-$HIVE_BUILD.jar"
HIVE_JDBC_STANDALONE_JAR_NAME="hive-jdbc-$HIVE_BUILD-standalone.jar"
HIVE_JDBC_JAR_NAME="hive-jdbc-$HIVE_BUILD.jar"
HIVE_LLAP_COMMON_JAR_NAME="hive-llap-common-$HIVE_BUILD.jar"
HIVE_METASTORE_JAR_NAME="hive-metastore-$HIVE_BUILD.jar"
HIVE_SERDE_JAR_NAME="hive-serde-$HIVE_BUILD.jar"
HIVE_SERVICE_RPC_JAR_NAME="hive-service-rpc-$HIVE_BUILD.jar"
HIVE_SHIMS_JAR_NAME="hive-shims-$HIVE_BUILD.jar"
HIVE_SHIMS_COMMON_JAR_NAME="hive-shims-common-$HIVE_BUILD.jar"
HIVE_SHIMS_SCHEDULER_JAR_NAME="hive-shims-scheduler-3.1.3.jar"
HIVE_SPARK_CLIENT_JAR_NAME="hive-spark-client-3.1.3.jar"
HIVE_STANDALONE_METASTORE_JAR_NAME="hive-standalone-metastore-3.1.3.jar"

# We probably don't need those. Don't copy them for now. They are both under 'ql/target'
HIVE_EXEC_FALLBACKAUTHORIZER_JAR_NAME="hive-exec-$HIVE_BUILD-fallbackauthorizer.jar"
HIVE_ORIGINAL_EXEC_JAR_NAME="original-hive-exec-$HIVE_BUILD.jar"

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
  file_name_regex="hive-*-$HIVE_BUILD*"

  # Check whether compatible jar files already exist. If not cleanup jars dir.
  if ! find "$jars_dir_path" -type f -name "$file_name_regex" -print -quit | grep -q .; then
    echo "File matching regex '$file_name_regex' does not exist in '$jars_dir_name'."
    echo "Cleaning up '$jars_dir_name'..."
    rm -rf "$jars_dir_path"/*
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

handleRangerEnv() {
  abs_path=$1
  op=$2

  ranger_docker_path="$abs_path/$PROJECT_RANGER/dev-support/ranger-docker"
  cd $ranger_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_RANGER' env."
    echo ""

    export RANGER_DB_TYPE=postgres
    docker compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml up -d

    echo ""
    echo "'$PROJECT_RANGER' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_RANGER' env."
    echo ""

    docker compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml down

    echo ""
    echo "'$PROJECT_RANGER' env stopped."
    echo ""
  fi
}

handleHadoopEnv() {
  abs_path=$1
  op=$2

  hadoop_docker_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/compose/hadoop-ranger"
  cd $hadoop_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_HADOOP' env."
    echo ""

    docker compose -f "$hadoop_docker_path/docker-compose.yaml" up -d --scale datanode=3

    echo ""
    echo "'$PROJECT_HADOOP' env started."
    echo ""

    #reset COMPOSE_FILE env variable
    export COMPOSE_FILE=
  else
    echo ""
    echo "Stopping '$PROJECT_HADOOP' env."
    echo ""

    docker compose -f "$hadoop_docker_path/docker-compose.yaml" down

    echo ""
    echo "'$PROJECT_HADOOP' env stopped."
    echo ""
  fi
}

handleHiveEnv() {
  abs_path=$1
  op=$2
  hive_url_policies_enabled=$3

  hive_docker_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD-bin/apache-hive-$HIVE_BUILD-bin/compose/hive-metastore-ranger"

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
    echo "Creating /spark-events dir and changing permissions."

    mkdir $spark_path/conf/spark-events
    chmod 777 $spark_path/conf/spark-events

    docker compose -p spark -f $docker_compose_path up -d --scale worker=3

    echo ""
    echo "'$PROJECT_SPARK' env started."
  else
    echo ""
    echo "Stopping '$PROJECT_SPARK' env."


    docker compose -p spark -f $docker_compose_path down

    echo ""
    echo "'$PROJECT_SPARK' env stopped."

    echo "Cleaning up spark-events dir."
    rm -r -f $spark_path/conf/spark-events
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

createHdfsTestData() {
  dir_name=$1

  docker exec -it "$DN1_HOSTNAME" hdfs dfs -mkdir "/$dir_name"
  docker exec -it "$DN1_HOSTNAME" hdfs dfs -put test.csv "/$dir_name"
}

performSparkSql() {
  # Join all args with space
  sql="$*"
  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"$sql\" | bin/spark-shell"
}

createSparkTable() {
  table_name=$1
  hdfs_dir_name=$2
  db_name=$3

  if [ "$db_name" == "" ]; then
    db_name="default"
  fi

  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.read.text(\\\"hdfs://namenode:8020/$hdfs_dir_name\\\").write.option(\\\"path\\\", \\\"hdfs://namenode/opt/hive/data\\\").mode(\\\"overwrite\\\").format(\\\"csv\\\").saveAsTable(\\\"$db_name.$table_name\\\")\" | bin/spark-shell"
}

selectDataFromSparkTable() {
  table_name=$1
  db_name=$2

  if [ "$db_name" == "" ]; then
    db_name="default"
  fi

  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"SELECT * FROM $db_name.$table_name\\\").show()\" | bin/spark-shell"
}

alterSparkTable() {
  old_table_name=$1
  new_table_name=$2
  db_name=$3

  if [ "$db_name" == "" ]; then
    db_name="default"
  fi

  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"ALTER TABLE $db_name.$old_table_name RENAME TO $db_name.$new_table_name\\\")\" | bin/spark-shell"
}

dropSparkTable() {
  table_name=$1
  db_name=$2

  if [ "$db_name" == "" ]; then
    db_name="default"
  fi

  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"DROP TABLE $db_name.$table_name\\\")\" | bin/spark-shell"
}

createDatabaseWithSpark() {
  db_name=$1

  docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"CREATE DATABASE $db_name LOCATION 'hdfs://namenode/opt/hive/data/$db_name/external/$db_name.db'\\\")\" | bin/spark-shell"
}

dropDatabaseWithSpark() {
  db_name=$1
  use_cascade=$2

  if [ "$use_cascade" == "true" ]; then
    docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"DROP DATABASE IF EXISTS $db_name CASCADE\\\")\" | bin/spark-shell"
  else
    docker exec -it "$SPARK_MASTER_HOSTNAME" bash -c "echo \"spark.sql(\\\"DROP DATABASE IF EXISTS $db_name\\\")\" | bin/spark-shell"
  fi
}

createTrinoTable() {
  table_name=$1
  hdfs_dir_name=$2
  schema_name=$3

  if [ "$schema_name" == "" ]; then
    schema_name="default"
  fi

  docker exec -it "$TRINO_HOSTNAME" trino --execute="create table hive.$schema_name.$table_name (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode:8020/$hdfs_dir_name',format = 'CSV');"
}

selectDataFromTrinoTable() {
  table_name=$1
  schema_name=$2

  if [ "$schema_name" == "" ]; then
    schema_name="default"
  fi
  
  docker exec -it "$TRINO_HOSTNAME" trino --execute="select * from hive.$schema_name.$table_name;"
}

alterTrinoTable() {
  old_table_name=$1
  new_table_name=$2
  schema_name=$3

  if [ "$schema_name" == "" ]; then
    schema_name="default"
  fi

  docker exec -it "$TRINO_HOSTNAME" trino --execute="alter table hive.$schema_name.$old_table_name rename to $new_table_name;"
}

dropTrinoTable() {
  table_name=$1
  schema_name=$2

  if [ "$schema_name" == "" ]; then
    schema_name="default"
  fi

  docker exec -it "$TRINO_HOSTNAME" trino --execute="drop table hive.$schema_name.$table_name;"
}

createSchemaWithTrino() {
  schema_name=$1

  docker exec -it "$TRINO_HOSTNAME" trino --execute="CREATE SCHEMA hive.$schema_name WITH (location = 'hdfs://namenode/opt/hive/data/$schema_name/external/$schema_name.db');"
}

dropSchemaWithTrino() {
  schema_name=$1
  use_cascade=$2

  if [ "$use_cascade" == "true" ]; then
    docker exec -it "$TRINO_HOSTNAME" trino --execute="DROP SCHEMA hive.$schema_name CASCADE;"
  else
    docker exec -it "$TRINO_HOSTNAME" trino --execute="DROP SCHEMA hive.$schema_name;"
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

  # Hadoop
  echo ""
  cd "$abs_path/$PROJECT_HADOOP"
  
  hadoop_branch=$(git branch --show-current)
  echo "Current branch for repo '$PROJECT_HADOOP' is '$hadoop_branch'."

  hadoop_commit_SHA=$(git rev-parse HEAD | awk NF)
  echo "Current branch for repo '$PROJECT_HADOOP' is '$hadoop_commit_SHA'."

  # Write text to the file.
  echo "## $PROJECT_HADOOP ##" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Branch: $hadoop_branch" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
  echo "Commit: $hadoop_commit_SHA" >> "$abs_path/$CURRENT_REPO/$LAST_SUCCESS_FILE"
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
}

retryOperationIfNeeded() {
  abs_path=$1
  cmd=$2
  expMsg=$3
  expFailure=$4
  notExpMsg=$5

  result=""

  if [ "$expFailure" == "true" ]; then
    result="failed"
  else
    result="succeeded"
  fi

  echo "- INFO: Some wait time might be needed for the policy update to get picked up. Retry a few times if needed."
  echo ""

  counter=0

  while [[ "$counter" < 9 ]]; do

    echo "- INFO: Counter=$counter" 

    $cmd 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"
    
    if [ "$notExpMsg" == "true" ]; then
      # '> /dev/null' hides the grep output. Remove it to reveal the output.
      if !(grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null); then
        echo ""
        # echo "- Output: $opOutput"
        echo ""
        echo "- Not expected msg: $expMsg"
        echo ""
        echo "- RESULT -> SUCCESS: Operation $result as expected."
        break
      fi

      sleep 3
      counter=$(($counter + 1))

      # If we reached counter=10 and the output is still different than the expected one, then exit.
      if [ "$counter" == 9 ] && grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/nul; then
        echo ""
        # echo "- INFO: out= $opOutput"
        echo ""
        echo ""
        echo ""
        echo ""
        echo "- RESULT -> FAILURE: Operation should have $result, but it didn't..."
        echo "- Exiting..."
        exit 1
      fi
    else
      if grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
        echo ""
        # echo "- Output: $opOutput"
        echo ""
        echo "- Expected Msg: $expMsg"
        echo ""
        echo "- RESULT -> SUCCESS: Operation $result as expected."
        break
      fi

      sleep 3
      counter=$(($counter + 1))

      # If we reached counter=10 and the output is still different than the expected one, then exit.
      if [ "$counter" == 9 ] && !(grep -F "$expMsg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null); then
        echo ""
        # echo "- INFO: out= $opOutput"
        echo ""
        echo ""
        echo ""
        echo ""
        echo "- RESULT -> FAILURE: Operation should have $result, but it didn't..."
        echo "- Exiting..."
        exit 1
      fi
    fi
  done
}


