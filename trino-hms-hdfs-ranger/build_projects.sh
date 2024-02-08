#!/bin/bash

source "./testlib.sh"

abs_path=$1
starting_step=$2
java_8_home=$3
java_21_home=$4

if [ "$java_8_home" == "" ]; then
  java_8_home="/usr/lib/jvm/java-8-openjdk-amd64"
fi

if [ "$java_21_home" == "" ]; then
  java_21_home="/usr/lib/jvm/java-21-openjdk-amd64"
fi

exitIfProjectNotExist $abs_path $PROJECT_RANGER

exitIfProjectNotExist $abs_path $PROJECT_HADOOP

exitIfProjectNotExist $abs_path $PROJECT_HIVE

exitIfProjectNotExist $abs_path $PROJECT_TRINO

buildRanger=1
buildHadoop=1
buildHive=1
buildTrino=1

if [ "$starting_step" == "1" ]; then
  buildHadoop=0
  buildHive=0
  buildTrino=0
elif [ "$starting_step" == "2" ]; then
  buildHive=0
  buildTrino=0
elif [ "$starting_step" == "3" ]; then
  buildTrino=0
else
  buildRanger=0
  buildHadoop=0
  buildHive=0
  buildTrino=0
fi


# Ranger
if [ "$buildRanger" == 0 ]; then
  echo "Building '$PROJECT_RANGER'"

  cd "$abs_path/$PROJECT_RANGER"
  export JAVA_HOME="$java_8_home"

  if mvn clean compile package install -DskipTests -DskipShade; then
    echo "'$PROJECT_RANGER' build succeeded."
  else
    echo "'$PROJECT_RANGER' build failed."
    mvn clean compile package install -DskipTests -DskipShade -rf :ranger-distro
  fi
fi

# Hadoop
if [ "$buildHadoop" == 0 ]; then
  echo "Building '$PROJECT_HADOOP'"

  cd "$abs_path/$PROJECT_HADOOP"
  export JAVA_HOME="$java_8_home"

  if mvn clean install -Dmaven.javadoc.skip=true -DskipTests -DskipShade -Pdist,src; then
    echo "'$PROJECT_HADOOP' build succeeded."
  else
    echo "'$PROJECT_HADOOP' build failed."
  fi
fi

# Hive
if [ "$buildHive" == 0 ]; then
  echo "Building '$PROJECT_HIVE'"

  cd "$abs_path/$PROJECT_HIVE"
  export JAVA_HOME="$java_8_home"

  if mvn clean install package -DskipTests -Pdist; then
    echo "'$PROJECT_HIVE' build succeeded."
  else
    echo "'$PROJECT_HIVE' build failed."
  fi
fi

# Trino
if [ "$buildTrino" == 0 ]; then
  echo "Building '$PROJECT_TRINO'"

  cd "$abs_path/$PROJECT_TRINO"
  export JAVA_HOME="$java_21_home"

  if mvn clean install -DskipTests; then
    echo "'$PROJECT_TRINO' build succeeded."
  else
    echo "'$PROJECT_TRINO' build failed."
  fi
fi
