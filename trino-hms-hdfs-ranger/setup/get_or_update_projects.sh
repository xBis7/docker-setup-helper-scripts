#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
github_user=$2
github_remote_user=$3   # 'origin' if current user is also the remote user.

# This script is making the following assumptions
# 1. github SSH has been setup 
# 2. the remote entry is named after the remote user's github username
# 3. the name of the fork is the same as the name of the apache repo
# 4. if we try to fetch the remote for the current user, we will use 'origin'

# The github usernames will be parameterized.

# Clone repo if it doesn't exist locally.
cloneProjectIfNotExist "$abs_path" "$PROJECT_RANGER" "$github_user"
cloneProjectIfNotExist "$abs_path" "$PROJECT_HADOOP" "$github_user"
cloneProjectIfNotExist "$abs_path" "$PROJECT_HIVE" "$github_user"
if [[ "${HIVE_VERSION}" == "4" ]]; then
  cloneProjectIfNotExist "$abs_path" "$PROJECT_SPARK" "$github_user"
fi

# If the current user also owns the remote repo,
# then 'github_remote_user' should be set to 'origin'.

# Checkout to commit. No change, if the commit is the same as the current.
checkoutToProjectCommit "$abs_path" "$PROJECT_RANGER" "$github_remote_user" "$RANGER_COMMIT_SHA"
checkoutToProjectCommit "$abs_path" "$PROJECT_HIVE" "$github_remote_user" "$HIVE_COMMIT_SHA"
checkoutToProjectCommit "$abs_path" "$PROJECT_HADOOP" "$github_remote_user" "$HADOOP_COMMIT_SHA"
if [[ "${HIVE_VERSION}" == "4" ]]; then
  checkoutToProjectCommit "$abs_path" "$PROJECT_SPARK" "$github_remote_user" "$SPARK_COMMIT_SHA"
fi