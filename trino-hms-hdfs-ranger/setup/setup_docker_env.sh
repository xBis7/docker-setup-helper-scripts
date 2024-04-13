#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# Ranger paths
ranger_common_uber_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_COMMON_UBER_JAR"
ranger_common_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_COMMON_JAR"
ranger_audit_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_AUDIT_JAR"

ranger_hdfs_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_HDFS_JAR"
ranger_hive_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_HIVE_JAR"

ranger_hdfs_audit_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-audit.xml"
ranger_hdfs_security_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-security.xml"
ranger_hdfs_policymgr_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-policymgr-ssl.xml"

ranger_docker_dist_path="$abs_path/$PROJECT_RANGER/dev-support/ranger-docker/dist"
ranger_tar_regex_prefix="ranger-*"

# HDFS paths
hdfs_jars_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-$HADOOP_BUILD_VERSION/share/hadoop/hdfs/lib"
hdfs_conf_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-$HADOOP_BUILD_VERSION/etc/hadoop"

# Hive path
hive_jars_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD_VERSION-bin/apache-hive-$HIVE_BUILD_VERSION-bin/lib"

# Delete Ranger tarball leftovers from other versions.
echo ""
echo "Checking tarballs in $ranger_docker_dist_path."
echo "Clean up the tarballs, if any belongs to a different version build."
echo ""

# Flag to track if any file does not contain $RANGER_BUILD_VERSION
delete_files=false

# Change the glob pattern to properly expand
shopt -s nullglob

for file in $ranger_docker_dist_path/$ranger_tar_regex_prefix.tar.gz; do
  echo "Checking file: $file"
  if [[ ! $file =~ $RANGER_BUILD_VERSION ]]; then
    echo "File '$file' doesn't match build version '$RANGER_BUILD_VERSION'."
    delete_files=true
    # Exit the loop on the first match. 
    # One file is enough to decide on deletion.
    break
  fi
done

if $delete_files; then
    echo "Tarballs found from a different version build. Deleting files..."
    rm -rf $ranger_docker_dist_path/$ranger_tar_regex_prefix
    echo "Files deleted."
    echo ""
else
    echo "All tarballs belong to the current version."
    echo ""
fi

# Revert nullglob back to its default state
shopt -u nullglob

# Ranger - HDFS setup
echo "Copying Ranger jars under HDFS."
execCmdAndHandleErrorIfNeeded "cp $ranger_common_uber_jar_path $hdfs_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_audit_jar_path $hdfs_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_hdfs_jar_path $hdfs_jars_path"
echo "Copy finished."

echo "Copying Ranger HDFS config files under HDFS."
execCmdAndHandleErrorIfNeeded "cp $ranger_hdfs_audit_conf_path $hdfs_conf_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_hdfs_security_conf_path $hdfs_conf_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_hdfs_policymgr_conf_path $hdfs_conf_path"
echo "Copy finished."

# Ranger - Hive setup
echo "Copying Ranger jars under Hive."
execCmdAndHandleErrorIfNeeded "cp $ranger_common_uber_jar_path $hive_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_audit_jar_path $hive_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_hive_jar_path $hive_jars_path"
echo "Copy finished."

echo "Making hive 'entrypoint.sh' executable."
hive_generated_entrypoint_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD_VERSION-bin/apache-hive-$HIVE_BUILD_VERSION-bin/compose/hive-metastore-ranger"
execCmdAndHandleErrorIfNeeded "chmod u+x $hive_generated_entrypoint_path/entrypoint.sh"
echo "Permissions updated."

hdfs_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-$HADOOP_BUILD_VERSION"
if ls "$hdfs_path" | grep 'test.csv'; then
  echo "Test file already exists under Hadoop."
else
  echo "Copying test file under Hadoop env."
  if cp test.csv "$hdfs_path/test.csv"; then
    echo "Copying test file under Hadoop env succeeded."
  else
    echo "Copying test file under Hadoop env failed. Exiting..."
    exit 1
  fi
fi

