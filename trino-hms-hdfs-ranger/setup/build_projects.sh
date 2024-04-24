#!/bin/bash

source "./testlib.sh"

abs_path=$1
build_project=$2
java_8_home=${3:-"/usr/lib/jvm/java-8-openjdk-amd64"}

mvn_success_msg="[INFO] BUILD SUCCESS"

buildRanger=1
buildHive=1
buildSpark=1

if [ "$build_project" == "ranger" ]; then
  buildRanger=0
elif [ "$build_project" == "hms" ]; then
  buildHive=0
elif [ "$build_project" == "spark" ]; then
  buildSpark=0
elif [[ "$build_project" == "ranger/hms" || "$build_project" == "hms/ranger" ]]; then
  buildRanger=0
  buildHive=0
elif [[ "$build_project" == "ranger/spark" || "$build_project" == "spark/ranger" ]]; then
  buildRanger=0
  buildSpark=0
elif [[ "$build_project" == "hms/spark" || "$build_project" == "spark/hms" ]]; then
  buildHive=0
  buildSpark=0
elif [[ "$build_project" == "all" || "$build_project" == "" ]]; then
  buildRanger=0
  buildHive=0
  if [ "$HIVE_VERSION" == "4" ]; then # Check the env variable.
    buildSpark=0
  fi
else
  echo "Invalid project parameter."
  echo "Try one of the following"
  echo "'ranger'        -> building just Ranger"
  echo "'hms'           -> building just HiveMetastore"
  echo "'spark'         -> building just Spark"
  echo "'ranger/hms'    -> building Ranger and HiveMetastore"
  echo "'hms/ranger'    -> building Ranger and HiveMetastore"
  echo "'ranger/spark'  -> building Ranger and Spark"
  echo "'spark/ranger'  -> building Ranger and Spark"
  echo "'hms/spark'     -> building Spark and HiveMetastore"
  echo "'spark/hms'     -> building Spark and HiveMetastore"
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

  # No ranger patching for Hive4 for now.
  if [ "$HIVE_VERSION" != "4" ]; then # Check the env variable.
    echo "Applying Ranger docker patch."
    patch -p1 < "$abs_path/$CURRENT_REPO/$SIMPLIFY_RANGER_DOCKER_PATCH"
    echo "Project successfully patched."
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

# Spark
if [ "$buildSpark" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_SPARK

  echo ""
  echo "Building '$PROJECT_SPARK' and creating dist."

  cd "$abs_path/$PROJECT_SPARK"

  # Default value, in case it's not set as an env variable.
  if [ "$JAVA_HOME" == "" ]; then
    export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
  fi
  export MAVEN_OPTS="-Xss64m -Xmx4g -XX:ReservedCodeCacheSize=1g"

  echo ""  
  echo "Checking for an available patch for the '$PROJECT_SPARK' project."
  if [ "$SPARK_PATCH" != "" ]; then
    # We have `set -e`. If this fails, the script will exit.
    patch -p1 < $SPARK_PATCH
    echo "Project successfully patched."
    echo ""
  else
    echo "There is no available patch. Proceeding with the project build."
    echo ""
  fi

  ./dev/make-distribution.sh --name custom-spark --pip -Phive -Phive-thriftserver -Pyarn 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"

  if grep -F "Finished: SUCCESS" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
    echo ""
    echo "'$PROJECT_SPARK' build succeeded."
    echo ""
  else
    echo ""
    echo "'$PROJECT_SPARK' build failed."

    if grep -q 'Failed to clean project: Failed to delete' "$abs_path/$CURRENT_REPO/$TMP_FILE"; then
      echo ""
      echo "The 'work' dir is mounted in the docker env and therefore any data written inside the container,"
      echo "will be persisted in the local storage and will be owned by the container user 'spark'."
      echo ""
      echo "To workaround it, run these commands manually: "
      echo "> cd $abs_path/$PROJECT_SPARK/dist/compose/spark/conf"
      echo "> sudo rm -rf work"
      echo ""
      echo "After it succeeds, rerun this script for the rest of the projects that you need to build, start from '$PROJECT_SPARK'."
    fi
    exit 1
  fi
fi

echo ""
echo ""
echo "**Reminder: "
echo "Hive version has been set to '3.1.3-with-backport'."
echo "Ranger is using that custom version."
echo "For that reason, Hive always needs to be built before Ranger."
echo "If you are building just Ranger, make sure that Hive has already been built."

