#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
github_user=$2
github_remote_user=$3   # 'origin' if current user is also the remote user.
regenerate_ranger_patch=$4

# This script is making the following assumptions
# 1. github SSH has been setup 
# 2. the remote entry is named after the remote user's github username
# 3. the name of the fork is the same as the name of the apache repo
# 4. if we try to fetch the remote for the current user, we will use 'origin'

# The github usernames will be parameterized.

# Clone repo if it doesn't exist locally.
cloneProjectIfNotExist "$abs_path" "$PROJECT_RANGER" "$github_user"
cloneProjectIfNotExist "$abs_path" "$PROJECT_HIVE" "$github_user"

# We should discard all Ranger changes from a previous patch.
echo "Discard all changes from a previous Ranger patch."
cd "$abs_path/$PROJECT_RANGER"
git stash

# If the current user also owns the remote repo,
# then 'github_remote_user' should be set to 'origin'.

# Update repo if needed. No change, if everything is up-to-date.
updateProjectRepo "$abs_path" "$PROJECT_RANGER" "$github_remote_user" "$RANGER_BRANCH"
updateProjectRepo "$abs_path" "$PROJECT_HIVE" "$github_remote_user" "$HIVE_BRANCH"

echo "Reminder: If there are new Ranger commits,"
echo "the patch for the simplified docker env, has to be recreated."
echo "Also, update the variable 'PATCH_COMMIT_SHA' in 'testlib.sh'"
if [ "$regenerate_ranger_patch" == "true" ]; then
  cd "$abs_path/$PROJECT_RANGER"
  git stash apply
  git diff > "$abs_path/$CURRENT_REPO/$SIMPLIFY_RANGER_DOCKER_PATCH"
fi