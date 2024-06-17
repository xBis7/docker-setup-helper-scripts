#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

./ranger_api/create_update/create_update_hive_all_db_policy.sh "select,update,create,drop,alter,index,lock:$SPARK_USER1" "put" "gross_test"

waitForPoliciesUpdate
