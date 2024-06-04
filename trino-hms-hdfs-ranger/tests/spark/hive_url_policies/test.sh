#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

./tests/spark/hive_url_policies/hive_url_policies_env_setup.sh "$abs_path" "$prepare_env"

./tests/spark/hive_url_policies/1_test_create_database.sh "$abs_path"

./tests/spark/hive_url_policies/2_test_select_drop_with_a_second_user.sh "$abs_path"

./tests/spark/hive_url_policies/3_create_table_managed_and_not_managed.sh "$abs_path"

./tests/spark/hive_url_policies/4_test_rename_table_uri.sh "$abs_path"
