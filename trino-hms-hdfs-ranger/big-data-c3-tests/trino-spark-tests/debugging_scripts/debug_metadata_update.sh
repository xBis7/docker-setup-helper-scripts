#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

abs_path=$1             # /home/project/...
prepare_env=$2          # "true"

# Local env setup.
if [ "$CURRENT_ENV" == "local" ] && [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"

  createHdfsDir "$HIVE_WAREHOUSE_DIR"
  createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"
  createHdfsDir "tmp"
  changeHdfsDirPermissions "tmp" 777

  HIVE_BASE_POLICIES="hive_base_policies"

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

  # If we try to change the policies while the Ranger container is still restarting,
  # the call will fail and the script will exit.
  waitForPoliciesUpdate

  copyTestFilesUnderSpark "$abs_path"
fi

updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1,$TRINO_USER1"
updateHiveDbAllPolicy "gross_test" "alter,create,select:$SPARK_USER1,$TRINO_USER1"
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$TRINO_USER1"
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1,$TRINO_USER1"

waitForPoliciesUpdate

# command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

# runSpark "$SPARK_USER1" "$command" "shouldPass"

hdfsLocation="hdfs://$NAMENODE_NAME/data/projects/gross_test/gross_test.db"
command="create schema $TRINO_HIVE_SCHEMA.gross_test with (location = '$hdfsLocation')"
expectedMsg="CREATE SCHEMA"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"


# Trino docs about the Hive connector:
# 'UPDATE is only supported for transactional Hive tables with format ORC. UPDATE of partition or bucket columns is not supported.'

command=$(cat <<EOF
CREATE TABLE hive.gross_test.part_table (
  id varchar,
  anim varchar,
  type varchar
)
WITH (
  partitioned_by = ARRAY['type'],
  format = 'ORC',
  transactional=true
);
EOF
)
expectedMsg="CREATE TABLE"
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command=$(cat <<EOF
INSERT INTO hive.gross_test.part_table (id, anim, type)
VALUES  ('1', 'cow', 'not pet'),
        ('2', 'dog', 'pet'),
        ('3', 'sheep', 'not pet'),
        ('4', 'cat', 'pet'),
        ('5', 'rabbit', 'pet');
EOF
)
expectedMsg="INSERT: 5 rows"
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="describe hive.gross_test.part_table;"
expectedMsg=""
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="select * from hive.gross_test.part_table;"
expectedMsg=""
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="update hive.gross_test.part_table set anim = 'x' where id = '2';"
expectedMsg="Permission denied: user [hive] does not have [ALTER] privilege on [gross_test/part_table]"
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# delete from hive.gross_test.part_table where anim = 'pet';
# call hive.system.drop_stats(schema_name => 'gross_test', table_name => 'part_table', partition_values => ARRAY[ARRAY['not pet']]);
