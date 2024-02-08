#!/bin/bash

PROJECT_RANGER="ranger"
PROJECT_HADOOP="hadoop"
PROJECT_HIVE="hive"
PROJECT_TRINO="trino"

checkProjectExists() {
  path=$1
  project=$2

  res=$(ls $path | grep $project)

  if [ "$res" == "" ]; then
    echo "Project '$project' doesn't exist. Exiting..."
    exit 1
  else
    echo "Project '$project' exists."
  fi
}

