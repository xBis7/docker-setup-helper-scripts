#!/bin/bash

source "./testlib.sh"

abs_path=$1
build_project=$2
java_8_home=$3

if [ "$java_8_home" == "" ]; then
  java_8_home="/usr/lib/jvm/java-8-openjdk-amd64"
fi

buildRanger=1
buildHadoop=1
buildHive=1

if [ "$build_project" == "ranger" ]; then
  buildRanger=0
elif [ "$build_project" == "hadoop" ]; then
  buildHadoop=0
elif [ "$build_project" == "hms" ]; then
  buildHive=0
elif [ "$build_project" == "ranger/hadoop" ]; then
  buildRanger=0
  buildHadoop=0
elif [ "$build_project" == "hadoop/hms" ]; then
  buildHadoop=0
  buildHive=0
elif [ "$build_project" == "ranger/hms" ]; then
  buildRanger=0
  buildHive=0
elif [[ "$build_project" == "all" || "$build_project" == "" ]]; then
  buildRanger=0
  buildHadoop=0
  buildHive=0
else
  echo "Invalid project parameter."
  echo "Try one of the following"
  echo "'ranger'        -> building just Ranger"
  echo "'hadoop'        -> building just Hadoop"
  echo "'hms'           -> building just HiveMetastore"
  echo "'ranger/hadoop' -> building Ranger and Hadoop"
  echo "'hadoop/hms'    -> building Hadoop and HiveMetastore"
  echo "'ranger/hms'    -> building Ranger and HiveMetastore"
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

  output=$(mvn clean compile package install -DskipTests -DskipShade)
  status=$?

  if [ "$status" == 0 ]; then
    echo ""
    echo "'$PROJECT_RANGER' build succeeded."
    echo ""
  else
    if [ "$output | grep -q 'JAVA_HOME'" ]; then
      echo ""
      echo "Error with JAVA_HOME. Printing some useful info for debugging."
      echo "Current JAVA_HOME is: $JAVA_HOME"
      echo "Path provided is: $java_8_home"
      echo "Exiting..."
      exit 1
    fi

    echo ""
    echo "'$PROJECT_RANGER' build failed."

    if [ "$output | grep -q 'on project ranger-distro: Failed'" ]; then
      echo ""
      echo "Project failure in 'ranger-distro', is a commmon failure, retry once and it will succeed."
      echo "Run these commands: "
      echo "> cd $abs_path/$PROJECT_RANGER"
      echo "> mvn clean compile package install -DskipTests -DskipShade -rf :ranger-distro"
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

  output=$(mvn clean install -Dmaven.javadoc.skip=true -DskipTests -DskipShade -Pdist,src)
  status=$?

  if [ "$status" == 0 ]; then
    echo ""
    echo "'$PROJECT_HADOOP' build succeeded."
    echo ""
  else
    if [ "$output | grep -q 'JAVA_HOME'" ]; then
      echo ""
      echo "Error with JAVA_HOME. Printing some useful info for debugging."
      echo "Current JAVA_HOME is: $JAVA_HOME"
      echo "Path provided is: $java_8_home"
      echo "Exiting..."
      exit 1
    fi
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

  output=$(mvn clean install package -DskipTests -Pdist)
  status=$?

  if [ "$status" == 0 ]; then
    echo ""
    echo "'$PROJECT_HIVE' build succeeded."
    echo ""
  else
    if [ "$output | grep -q 'JAVA_HOME'" ]; then
      echo ""
      echo "Error with JAVA_HOME. Printing some useful info for debugging."
      echo "Current JAVA_HOME is: $JAVA_HOME"
      echo "Path provided is: $java_8_home"
      echo "Exiting..."
      exit 1
    fi
    echo ""
    echo "'$PROJECT_HIVE' build failed."
    exit 1
  fi
fi
