#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

# This if block is in case we need to run this script independently.
if [ "$prepare_env" == "true" ]; then
  ./tests/hive_url_policies_env_setup.sh "$abs_path" "$prepare_env"
fi

./tests/trino/hive_url_policies/1_test_create_schema.sh "$abs_path"

./tests/trino/hive_url_policies/2_test_select_drop_with_a_second_user.sh "$abs_path"

./tests/trino/hive_url_policies/3_test_create_table_managed_and_not_managed.sh "$abs_path"

./tests/trino/hive_url_policies/4_test_alter_table_uri.sh "$abs_path"
