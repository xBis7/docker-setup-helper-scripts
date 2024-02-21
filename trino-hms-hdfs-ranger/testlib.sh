#!/bin/bash

# Project names
PROJECT_RANGER="ranger"
PROJECT_HADOOP="hadoop"
PROJECT_HIVE="hive"
PROJECT_TRINO="trino"
PROJECT_SPARK="spark"

# Project branches
RANGER_BRANCH="ranger-docker-hdfs"
HADOOP_BRANCH="hadoop-3.3.6-docker"
HIVE_BRANCH="branch-3.1-build-fixed"

# Dump file names
DEFAULT_POLICIES="1_defaults"
DEFAULT_AND_NO_HIVE="2_defaults_no_hive_perm_defaultdb"
HDFS_ACCESS="3_hdfs_all"
HDFS_AND_HIVE_ALL="4_hive_defaultdb_all"
HDFS_AND_HIVE_SELECT="5_hive_defaultdb_select"
HDFS_AND_HIVE_SELECT_ALTER="6_hive_defaultdb_select_alter"

# Const shared variables
TRINO_TABLE="test_table"
NEW_TRINO_TABLE_NAME="new_$TRINO_TABLE"
HDFS_DIR="test"

# Container names
NAMENODE_HOSTNAME="hadoop_namenode_1"
DN1_HOSTNAME="hadoop_datanode_1"
DN2_HOSTNAME="hadoop_datanode_2"
DN3_HOSTNAME="hadoop_datanode_3"

HMS_HOSTNAME="hive-metastore-ranger_hive-metastore_1"
HMS_POSTGRES_HOSTNAME="hive-metastore-ranger_postgres_1"

RANGER_HOSTNAME="ranger"
RANGER_POSTGRES_HOSTNAME="ranger-postgres"

TRINO_HOSTNAME="trino-spark_trino-coordinator_1"

SPARK_MASTER_HOSTNAME="trino-spark_spark-master_1"
SPARK_WORKER1_HOSTNAME="trino-spark_spark-worker_1"

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
    docker-compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml up -d

    echo ""
    echo "'$PROJECT_RANGER' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_RANGER' env."
    echo ""

    docker-compose -f docker-compose.ranger.yml -f docker-compose.ranger-postgres.yml down

    echo ""
    echo "'$PROJECT_RANGER' env stopped."
    echo ""
  fi
}

handleHadoopEnv() {
  abs_path=$1
  op=$2

  hadoop_docker_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/compose/hadoop"
  cd $hadoop_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_HADOOP' env."
    echo ""

    export COMPOSE_FILE=docker-compose.yaml:ranger.yaml
    docker-compose up -d --scale datanode=3

    echo ""
    echo "'$PROJECT_HADOOP' env started."
    echo ""

    #reset COMPOSE_FILE env variable
    export COMPOSE_FILE=
  else
    echo ""
    echo "Stopping '$PROJECT_HADOOP' env."
    echo ""

    docker-compose down

    echo ""
    echo "'$PROJECT_HADOOP' env stopped."
    echo ""
  fi
}

handleHiveEnv() {
  abs_path=$1
  op=$2

  hive_docker_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-3.1.3-bin/apache-hive-3.1.3-bin/compose/hive-metastore-ranger"
  cd $hive_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_HIVE' env."
    echo ""

    docker-compose up -d

    echo ""
    echo "'$PROJECT_HIVE' env started."
    echo ""
  else
    echo ""
    echo "Stopping '$PROJECT_HIVE' env."
    echo ""

    docker-compose down

    echo ""
    echo "'$PROJECT_HIVE' env stopped."
    echo ""
  fi
}

handleTrinoSparkEnv() {
  abs_path=$1
  op=$2

  trino_spark_docker_path="$abs_path/docker-setup-helper-scripts/compose/trino-spark"
  cd $trino_spark_docker_path

  if [ "$op" == "start" ]; then
    echo ""
    echo "Starting '$PROJECT_TRINO / $PROJECT_SPARK' env."

    echo "Creating /spark-events dir and changing permissions."
    echo ""

    mkdir $trino_spark_docker_path/conf/spark/spark-events
    chmod 777 $trino_spark_docker_path/conf/spark/spark-events

    # This can be extended to scale to 3 spark workers.
    docker-compose up -d

    echo ""
    echo "'$PROJECT_TRINO / $PROJECT_SPARK' env started."
    echo ""

    # We need to copy the hive metastore jars under the Spark master container.
    # This is needed so that spark can be configured to work with HMS 3.1.3.
    sparkMasterContainerID=$(docker ps | grep "$SPARK_MASTER_HOSTNAME" | awk '{print $1}')
    sparkWorker1ContainerID=$(docker ps | grep "$SPARK_WORKER1_HOSTNAME" | awk '{print $1}')

    hiveMetastoreJar="hive-metastore-3.1.3.jar"
    hiveStandaloneMetastoreJar="hive-standalone-metastore-3.1.3.jar"
    hiveCommonJar="hive-common-3.1.3.jar"
    hiveJdbcJar="apache-hive-3.1.3-jdbc.jar"
#hive-exec-3.1.3-core.jar
#hive-exec-3.1.3.jar

    hiveMetastoreJarPath="$abs_path/hive/metastore/target/$hiveMetastoreJar"
    hiveStandaloneMetastoreJarPath="$abs_path/hive/standalone-metastore/target/$hiveStandaloneMetastoreJar"
    hiveCommonJarPath="$abs_path/hive/common/target/$hiveCommonJar"

    # Master
    # docker cp "$hiveMetastoreJarPath" "$sparkMasterContainerID":/opt/spark/jars/hive-metastore-3.1.3.jar
    # docker cp "$hiveStandaloneMetastoreJarPath" "$sparkMasterContainerID":/opt/spark/jars/hive-standalone-metastore-3.1.3.jar
    # docker cp "$hiveCommonJarPath" "$sparkMasterContainerID":/opt/spark/jars/hive-common-3.1.3.jar

    # docker cp "$abs_path/hive/packaging/target/apache-hive-3.1.3-jdbc.jar" "$sparkMasterContainerID":/opt/spark/jars/hive-3.1.3-jdbc.jar

    # docker cp "$abs_path/hive/ql/target/hive-exec-3.1.3-core.jar" "$sparkMasterContainerID":/opt/spark/jars/hive-exec-3.1.3-core.jar
    # docker cp "$abs_path/hive/ql/target/hive-exec-3.1.3.jar" "$sparkMasterContainerID":/opt/spark/jars/hive-exec-3.1.3.jar
    # docker cp "$abs_path/hive/ql/target/original-hive-exec-3.1.3.jar" "$sparkMasterContainerID":/opt/spark/jars/original-hive-exec-3.1.3.jar

    # Worker1
    # docker cp "$hiveMetastoreJarPath" "$sparkWorker1ContainerID":/opt/spark/jars/hive-metastore-3.1.3.jar
    # docker cp "$hiveStandaloneMetastoreJarPath" "$sparkWorker1ContainerID":/opt/spark/jars/hive-standalone-metastore-3.1.3.jar
    # docker cp "$hiveCommonJarPath" "$sparkWorker1ContainerID":/opt/spark/jars/hive-common-3.1.3.jar

    # docker cp "$abs_path/hive/packaging/target/apache-hive-3.1.3-jdbc.jar" "$sparkWorker1ContainerID":/opt/spark/jars/hive-3.1.3-jdbc.jar

    # docker cp "$abs_path/hive/ql/target/hive-exec-3.1.3-core.jar" "$sparkWorker1ContainerID":/opt/spark/jars/hive-exec-3.1.3-core.jar
    # docker cp "$abs_path/hive/ql/target/hive-exec-3.1.3.jar" "$sparkWorker1ContainerID":/opt/spark/jars/hive-exec-3.1.3.jar
    # docker cp "$abs_path/hive/ql/target/original-hive-exec-3.1.3.jar" "$sparkWorker1ContainerID":/opt/spark/jars/original-hive-exec-3.1.3.jar

    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-beeline-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-cli-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-common-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-exec-2.3.9-core.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-jdbc-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-llap-common-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-metastore-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-serde-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-shims-0.23-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-shims-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-shims-common-2.3.9.jar
    # docker exec -it "$SPARK_MASTER_HOSTNAME" rm jars/hive-shims-scheduler-2.3.9.jar

    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-beeline-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-cli-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-common-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-exec-2.3.9-core.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-jdbc-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-llap-common-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-metastore-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-serde-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-shims-0.23-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-shims-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-shims-common-2.3.9.jar
    # docker exec -it "$SPARK_WORKER1_HOSTNAME" rm jars/hive-shims-scheduler-2.3.9.jar


    # This needs to be removed. -->
    # docker cp /home/xbis/Downloads/postgresql-42.7.1.jar "$sparkContainerID":/opt/spark/jars/postgresql-42.7.1.jar
    # -->
  else
    echo ""
    echo "Stopping '$PROJECT_TRINO / $PROJECT_SPARK' env."
    echo ""

    docker-compose down

    echo ""
    echo "'$PROJECT_TRINO / $PROJECT_SPARK' env stopped."
    echo ""

    echo "Cleaning up /spark-events dir."
    rm -r -f $trino_spark_docker_path/conf/spark/spark-events/
  fi
}

checkProjectExists() {
  path=$1
  project=$2

  res=$(ls $path | grep $project)

  if [ "$res" == "" ]; then
    echo 1
  else
    echo 0
  fi
}

exitIfProjectNotExist() {
  path=$1
  project=$2

  res=$(checkProjectExists "$path" "$project")

  if [ "$res" == "" ]; then
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

  curr_ranger_branch=$(git branch --show-current)

  if [ "$curr_ranger_branch" != "$github_branch" ]; then
    echo ""
    echo "Current branch is $curr_ranger_branch."
    
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

  docker exec -it hadoop_datanode_1 hdfs dfs -mkdir "/$dir_name"
  docker exec -it hadoop_datanode_1 hdfs dfs -put NOTICE.txt "/$dir_name"
}

executeTrinoCommand() {
  cmd=$1

  docker exec -it trino-spark_trino-coordinator_1 trino --execute="$cmd"
}

createTrinoTable() {
  table_name=$1
  hdfs_dir_name=$2

  executeTrinoCommand "create table hive.default.$table_name (column1 varchar,column2 int) with (external_location = 'hdfs://namenode:8020/$hdfs_dir_name',format = 'TEXTFILE');"
}

selectDataFromTrinoTable() {
  table_name=$1
  
  executeTrinoCommand "select * from hive.default.$table_name;"
}

alterTrinoTable() {
  old_table_name=$1
  new_table_name=$2

  executeTrinoCommand "alter table hive.default.$old_table_name rename to $new_table_name;"
}

retryOperationIfNeeded() {
  cmd=$1
  expMsg=$2
  expFailure=$3

  result=""

  if [ "$expFailure" == "true" ]; then
    result="failed"
  else
    result="succeeded"
  fi

  echo "- INFO: Some wait time might be needed for trino to pick up the policy update. Retry a few times if needed."
  echo ""

  counter=0

  while [[ "$counter" < 9 ]]; do

    opOutput="$($cmd)"

    echo "- INFO: Counter=$counter | out: $opOutput"

    if [[ "$opOutput" == *"$expMsg"* ]]; then
      echo ""
      echo "- RESULT -> SUCCESS: Operation $result as expected."
      echo "- Output: $opOutput"
      break
    fi

    sleep 3
    counter=$(($counter + 1))

    # If we reached counter=10 and the output is still different than the expected one, then exit.
    if [[ "$counter" == 9 ]] && [[ "$opOutput" != *"$expMsg"* ]]; then
      echo "- RESULT -> FAILURE: Table creation should have $result, but it didn't..."
      echo "- Stopping the docker env and exiting..."
      ./stop_docker_env.sh "$abs_path"
      exit 1
    fi
  done
}

