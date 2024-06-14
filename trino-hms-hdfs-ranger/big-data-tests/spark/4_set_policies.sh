#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

./ranger_api/create_update/create_update_hive_all_db_policy.sh "alter,create,drop,index,lock,select,update:$HIVE_USER,$SPARK_USER1/select:$SPARK_USER2" "put" "gross_test"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select:$HIVE_USER,$SPARK_USER1,$SPARK_USER2" "put"

waitForPoliciesUpdate
