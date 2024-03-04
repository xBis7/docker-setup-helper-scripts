#!/bin/bash

source "./testlib.sh"

abs_path=$1
build_project=$2
java_8_home=$3

if [ "$java_8_home" == "" ]; then
  java_8_home="/usr/lib/jvm/java-8-openjdk-amd64"
fi

mvn_success_msg="[INFO] BUILD SUCCESS"

buildRanger=1
buildHadoop=1
buildHive=1
buildSpark=1

if [ "$build_project" == "ranger" ]; then
  buildRanger=0
elif [ "$build_project" == "hadoop" ]; then
  buildHadoop=0
elif [ "$build_project" == "hms" ]; then
  buildHive=0
elif [ "$build_project" == "spark" ]; then
  buildSpark=0
elif [[ "$build_project" == "ranger/hadoop" || "$build_project" == "hadoop/ranger" ]]; then
  buildRanger=0
  buildHadoop=0
elif [[ "$build_project" == "hadoop/hms" || "$build_project" == "hms/hadoop" ]]; then
  buildHadoop=0
  buildHive=0
elif [[ "$build_project" == "ranger/hms" || "$build_project" == "hms/ranger" ]]; then
  buildRanger=0
  buildHive=0
elif [[ "$build_project" == "ranger/spark" || "$build_project" == "spark/ranger" ]]; then
  buildRanger=0
  buildSpark=0
elif [[ "$build_project" == "hadoop/spark" || "$build_project" == "spark/hadoop" ]]; then
  buildHadoop=0
  buildSpark=0
elif [[ "$build_project" == "hms/spark" || "$build_project" == "spark/hms" ]]; then
  buildHive=0
  buildSpark=0
elif [[ "$build_project" == "all" || "$build_project" == "" ]]; then
  buildRanger=0
  buildHadoop=0
  buildHive=0
  buildSpark=0
else
  echo "Invalid project parameter."
  echo "Try one of the following"
  echo "'ranger'        -> building just Ranger"
  echo "'hadoop'        -> building just Hadoop"
  echo "'hms'           -> building just HiveMetastore"
  echo "'spark'         -> building just Spark"
  echo "'ranger/hadoop' -> building Ranger and Hadoop"
  echo "'hadoop/ranger' -> building Ranger and Hadoop"
  echo "'hadoop/hms'    -> building Hadoop and HiveMetastore"
  echo "'hms/hadoop'    -> building Hadoop and HiveMetastore"
  echo "'ranger/hms'    -> building Ranger and HiveMetastore"
  echo "'hms/ranger'    -> building Ranger and HiveMetastore"
  echo "'ranger/spark'  -> building Ranger and Spark"
  echo "'spark/ranger'  -> building Ranger and Spark"
  echo "'hadoop/spark'  -> building Hadoop and Spark"
  echo "'spark/hadoop'  -> building Hadoop and Spark"
  echo "'hms/spark'     -> building Spark and HiveMetastore"
  echo "'spark/hms'     -> building Spark and HiveMetastore"
  echo "'all' or empty  -> building all projects"
  # exit 1
  # We don't need to exit. If we ended up in the else statement,
  # then all build project variables are left to 1.
  # No project will be built and the script will exit anyway.
fi

# Ranger
if [ "$buildRanger" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_RANGER

  echo ""
  echo "Building '$PROJECT_RANGER'"

  cd "$abs_path/$PROJECT_RANGER"
  export JAVA_HOME="$java_8_home"
  export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g"

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

# Hadoop
if [ "$buildHadoop" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_HADOOP

  echo ""
  echo "Building '$PROJECT_HADOOP'"

  cd "$abs_path/$PROJECT_HADOOP"
  export JAVA_HOME="$java_8_home"
  export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g"

  echo ""  
  echo "Checking for an available patch for the '$PROJECT_HADOOP' project."
  if [ "$HADOOP_PATCH" != "" ]; then
    # We have `set -e`. If this fails, the script will exit.
    patch -p1 < $HADOOP_PATCH
    echo "Project successfully patched."
    echo ""
  else
    echo "There is no available patch. Proceeding with the project build."
    echo ""
  fi

  mvn clean install --batch-mode -Dmaven.javadoc.skip=true -DskipTests -DskipShade -Pdist,src 2>&1 | tee "$abs_path/$CURRENT_REPO/$TMP_FILE"

  if grep -F "$mvn_success_msg" "$abs_path/$CURRENT_REPO/$TMP_FILE" > /dev/null; then
    echo ""
    echo "'$PROJECT_HADOOP' build succeeded."
    echo ""
  else
    echo ""
    echo "'$PROJECT_HADOOP' build failed."
    exit 1
  fi
fi

# Hive
if [ "$buildHive" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_HIVE

  echo ""
  echo "Building '$PROJECT_HIVE'"

  cd "$abs_path/$PROJECT_HIVE"
  export JAVA_HOME="$java_8_home"
  export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g"

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

# Spark
if [ "$buildSpark" == 0 ]; then
  exitIfProjectNotExist $abs_path $PROJECT_SPARK

  echo ""
  echo "Building '$PROJECT_SPARK' and creating dist."

  cd "$abs_path/$PROJECT_SPARK"
  export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g"

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
    exit 1
  fi
fi

