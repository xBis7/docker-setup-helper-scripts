#!/bin/bash

PROJECT_RANGER="ranger"
PROJECT_HADOOP="hadoop"
PROJECT_HIVE="hive"
PROJECT_TRINO="trino"

RANGER_BRANCH="ranger-docker-hdfs"
HADOOP_BRANCH="hadoop-3.3.6-docker"
HIVE_BRANCH="branch-3.1-build-fixed"
TRINO_BRANCH="dev-env"

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
