#!/bin/bash

source "./testlib.sh"

abs_path=$1
build_project=$2
just_delete_ranger_tars=${3:-"true"} # Provide a default value if not set.
java_8_home=${4:-"/usr/lib/jvm/java-8-openjdk-amd64"}

mvn_success_msg="[INFO] BUILD SUCCESS"

buildRanger=1
buildHive=1

if [ "$build_project" == "ranger" ]; then
  buildRanger=0
elif [ "$build_project" == "hms" ]; then
  buildHive=0
elif [[ "$build_project" == "all" || "$build_project" == "" ]]; then
  buildRanger=0
  buildHive=0
else
  echo "Invalid project parameter."
  echo "Try one of the following"
  echo "'ranger'        -> building just Ranger"
  echo "'hms'           -> building just HiveMetastore"
  echo "'all' or empty  -> building all projects"
  # exit 1
  # We don't need to exit. If we ended up in the else statement,
  # then all build project variables are left to 1.
  # No project will be built and the script will exit anyway.
fi

# Hive
if [ "$buildHive" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_HIVE

  echo ""
  echo "Building '$PROJECT_HIVE'"

  cd "$abs_path/$PROJECT_HIVE"
  export JAVA_HOME="$java_8_home"
  export MAVEN_OPTS="-Xss64m -Xmx4g -XX:ReservedCodeCacheSize=1g"

  echo ""
  echo "Checking for an available patch for the '$PROJECT_HIVE' project."
  if [ "$HIVE_PATCH" != "" ]; then
    # We have `set -e`. If this fails, the script will exit.
    patch -p1 < $HIVE_PATCH
    echo "Project successfully patched."
    echo ""
  else
    echo "There is no available patch. Proceeding with the project build."
    echo ""
  fi

  mvn clean install package --batch-mode -DskipTests -Pdist 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"

  if grep -F "$mvn_success_msg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
    echo ""
    echo "'$PROJECT_HIVE' build succeeded."
    echo ""
  else
    echo ""
    echo "'$PROJECT_HIVE' build failed."
    exit 1
  fi
fi

# Ranger
if [ "$buildRanger" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_RANGER

  echo ""
  echo "Building '$PROJECT_RANGER'"

  cd "$abs_path/$PROJECT_RANGER"
  export JAVA_HOME="$java_8_home"
  export MAVEN_OPTS="-Xss64m -Xmx4g -XX:ReservedCodeCacheSize=1g"

  patch_commit_SHA="19f42c1d8b8e1edd40b1dd631821568b62a42e34"
  curr_commit_SHA=$(git rev-parse HEAD | awk NF)
  
  if [ "$patch_commit_SHA" == "$curr_commit_SHA" ]; then
    patch -p1 < "$abs_path/$CURRENT_REPO/$SIMPLIFY_RANGER_DOCKER_PATCH"
  else
    echo ""
    echo "The Ranger patch SHA is different from the current SHA."
    echo "Patching the file will fail. Skipping..."
    echo ""
  fi

  echo ""  
  echo "Checking for an available patch for the '$PROJECT_RANGER' project."
  if [ "$RANGER_PATCH" != "" ]; then
    # We have `set -e`. If this fails, the script will exit.
    patch -p1 < $RANGER_PATCH
    echo "Project successfully patched."
    echo ""
  else
    echo "There is no available patch. Proceeding with the project build."
    echo ""
  fi

  if [ "$just_delete_ranger_tars" == "true" ]; then
    echo ""
    echo "'ranger_in_docker' checks the tarballs under 'dev-support/ranger-docker/dist'."
    echo "If the tarballs are less than 20, it builds the project and then copies"
    echo "all the tarballs from the 'target' dir to the 'dev-support/ranger-docker/dist' dir."
    echo "Deleting the tarballs, will trigger the project build when running 'ranger_in_docker'."

    echo ""
    echo "Proceeding with the delete."
    ranger_docker_dist_path="$abs_path/$PROJECT_RANGER/dev-support/ranger-docker/dist"
    ranger_tar_regex_prefix="ranger-*"

    rm -rf $ranger_docker_dist_path/$ranger_tar_regex_prefix
    echo "Delete finished."
  else
    mvn clean compile package install --batch-mode -DskipTests -DskipShade 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"

    if grep -F "$mvn_success_msg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
      echo ""
      echo "'$PROJECT_RANGER' build succeeded."
      echo ""

      # 'ranger_in_docker' checks the 'dev-support/ranger-docker/dist' and if there are no tarballs there,
      # it builds the project again to generate them under the target dir.
      # After that it moves them to the dist location. If the tarballs exist in the dist location from a previous build,
      # they are not copied again and this step is skipped. Incrementally building Ranger
      # without copying the tarballs, doesn't make a difference,
      # because without the copy, the Ranger changes never end up in the docker env.
      if cp -r "$abs_path/$PROJECT_RANGER"/target/* "$abs_path/$PROJECT_RANGER"/dev-support/ranger-docker/dist/; then
        echo "Copying ranger tarballs under docker dist succeeded."
        echo ""
      else
        echo "Copying ranger tarballs under docker dist failed. Exiting..."
        exit 1
      fi
    else
      echo ""
      echo "'$PROJECT_RANGER' build failed."

      if grep -q 'on project ranger-distro: Failed' "$abs_path/$CURRENT_REPO/$TMP_FILE"; then
        echo ""
        echo "Project failure in 'ranger-distro', is a commmon failure, retry once and it will succeed."
        echo "Run these commands: "
        echo "> cd $abs_path/$PROJECT_RANGER"
        echo "> mvn clean compile package install --batch-mode -DskipTests -DskipShade -rf :ranger-distro"
        echo ""
        echo "After it succeeds, rerun this script for the rest of the projects that you need to build."
      fi
      exit 1
    fi
  fi
fi

echo ""
echo ""
echo "**Reminder: "
echo "Hive version has been set to '3.1.3-with-backport'."
echo "Ranger is using that custom version."
echo "For that reason, Hive always needs to be built before Ranger."
echo "If you are building just Ranger, make sure that Hive has already been built."

