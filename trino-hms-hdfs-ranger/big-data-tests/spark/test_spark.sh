#!/bin/bash

source "./big-data-tests/lib.sh"

set -e

# This will contain only the ranger api changes and it will run the scala files.

spark_user1=$1
external_dir=$2 # /data/projects

test1_file="1_create_db_no_create_perm.scala"

runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$spark_user1\" --conf spark.db_base_dir=\"$external_dir\" -I $test1_file"
