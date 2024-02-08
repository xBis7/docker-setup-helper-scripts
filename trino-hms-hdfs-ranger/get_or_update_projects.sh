#!/bin/bash

source "./testlib.sh"

abs_path=$1
github_user=$2
github_remote_user=$3

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
cloneProjectIfNotExist "$abs_path" "$PROJECT_TRINO" "$github_user"

if [ "$github_user" == "$github_remote_user" ]; then
  updateProjectRepo "$abs_path" "$PROJECT_RANGER" "$RANGER_BRANCH"
  updateProjectRepo "$abs_path" "$PROJECT_HADOOP" "$HADOOP_BRANCH"
  updateProjectRepo "$abs_path" "$PROJECT_HIVE" "$HIVE_BRANCH"
  updateProjectRepo "$abs_path" "$PROJECT_TRINO" "$TRINO_BRANCH"
else
  # Update repo if needed. No change, if everything is up-to-date.
  updateProjectFromRemoteFork "$abs_path" "$PROJECT_RANGER" "$github_remote_user" "$RANGER_BRANCH"
  updateProjectFromRemoteFork "$abs_path" "$PROJECT_HADOOP" "$github_remote_user" "$HADOOP_BRANCH"
  updateProjectFromRemoteFork "$abs_path" "$PROJECT_HIVE" "$github_remote_user" "$HIVE_BRANCH"
  updateProjectFromRemoteFork "$abs_path" "$PROJECT_TRINO" "$github_remote_user" "$TRINO_BRANCH"
fi

