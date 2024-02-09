#!/bin/bash

PROJECT_RANGER="ranger"
PROJECT_HADOOP="hadoop"
PROJECT_HIVE="hive"
PROJECT_TRINO="trino"

RANGER_BRANCH="ranger-docker-hdfs"
HADOOP_BRANCH="hadoop-3.3.6-docker"
HIVE_BRANCH="branch-3.1-build-fixed"
TRINO_BRANCH="dev-env"

DEFAULT_POLICIES="1_defaults"
DEFAULT_AND_NO_HIVE="2_defaults_no_hive_perm_defaultdb"
POSTGRES_HDFS_ACCESS="3_postgres_hdfs"
HDFS_AND_HIVE_ALL="4_hive_defaultdb_all"
HDFS_AND_HIVE_SELECT="5_hive_defaultdb_select"
HDFS_AND_HIVE_SELECT_ALTER="6_hive_defaultdb_select_alter"

TRINO_TABLE="test_table"
NEW_TRINO_TABLE_NAME="new_$TRINO_TABLE"
HDFS_DIR="test"

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
    cd "$base_path"
    git clone "git@github.com:$github_user/ranger.git"
  else
    echo "'$project_name' exists locally."
  fi
}

updateProjectRepo() {
  base_path=$1
  project_name=$2
  github_branch=$4

  echo "Updating '$project_name' repo."
  cd "$base_path/$project_name"

  git fetch origin $github_branch

  curr_ranger_branch=$(git branch --show-current)

  if [ "$curr_ranger_branch" != "$github_branch" ]; then
    git checkout $github_branch
  fi

  git pull origin $github_branch

  echo "Finished updating '$project_name' repo."
}

updateProjectFromRemoteFork() {
  base_path=$1
  project_name=$2
  github_remote_user=$3
  github_branch=$4

  echo "Updating '$project_name' repo."
  cd "$base_path/$project_name"

  if git remote -v | grep "$github_remote_user"; then
    echo "Remote from user '$github_remote_user', already exists in project '$project_name'."
  else
    echo "Remote from user '$github_remote_user', doesn't exist in project '$project_name', adding..."
    
    git remote add "$github_remote_user" "https://github.com/$github_remote_user/$project_name"
  fi

  git fetch $github_remote_user $github_branch

  curr_ranger_branch=$(git branch --show-current)

  if [ "$curr_ranger_branch" != "$github_branch" ]; then
    git checkout $github_remote_user/$github_branch
  fi

  git pull $github_remote_user $github_branch

  echo "Finished updating '$project_name' repo."
}

createHdfsTestData() {
  dir_name=$1

  docker exec -it hadoop_datanode_1 hdfs dfs -mkdir "/$dir_name"
  docker exec -it hadoop_datanode_1 hdfs dfs -put NOTICE.txt "/$dir_name"
}

executeTrinoCommand() {
  cmd=$1

  docker exec -it trino-hms-hdfs_trino-coordinator_1 trino --execute="$cmd"
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
      echo "- RESULT: Operation $result as expected."
      echo "- Output: $opOutput"
      break
    fi

    sleep 3
    counter=$(($counter + 1))

    # If we reached counter=10 and the output is still different than the expected one, then exit.
    if [[ "$counter" == 9 ]] && [[ "$opOutput" != *"$expMsg"* ]]; then
      echo "- RESULT: Table creation should have $result, but it didn't..."
      echo "- Stopping the docker env and exiting..."
      ./stop_docker_env.sh "$abs_path"
      exit 1
    fi
  done
}

