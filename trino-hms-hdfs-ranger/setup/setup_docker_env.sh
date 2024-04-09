#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# Ranger paths
ranger_common_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_COMMON_JAR"
ranger_audit_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_AUDIT_JAR"

# ranger_hdfs_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_HDFS_JAR"
ranger_hive_jar_path="$abs_path/$PROJECT_RANGER/$RANGER_HIVE_JAR"

# ranger_hdfs_audit_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-audit.xml"
# ranger_hdfs_security_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-security.xml"
# ranger_hdfs_policymgr_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-policymgr-ssl.xml"

# HDFS paths
# hdfs_jars_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/share/hadoop/hdfs/lib"
# hdfs_conf_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/etc/hadoop"

# Hive path
hive_jars_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD-bin/apache-hive-$HIVE_BUILD-bin/lib"

# Ranger - Hive setup
echo "Copying Ranger jars under Hive."
execCmdAndHandleErrorIfNeeded "cp $ranger_common_jar_path $hive_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_audit_jar_path $hive_jars_path"
execCmdAndHandleErrorIfNeeded "cp $ranger_hive_jar_path $hive_jars_path"
echo "Copy finished."

echo "Making hive 'entrypoint.sh' executable."
hive_generated_entrypoint_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-$HIVE_BUILD-bin/apache-hive-$HIVE_BUILD-bin/compose/hive-metastore-ranger"
execCmdAndHandleErrorIfNeeded "chmod u+x $hive_generated_entrypoint_path/entrypoint.sh"
echo "Permissions updated."

# hdfs_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6"
# if ls "$hdfs_path" | grep 'test.csv'; then
#   echo "Test file already exists under Hadoop."
# else
#   echo "Copying test file under Hadoop env."
#   if cp test.csv "$hdfs_path/test.csv"; then
#     echo "Copying test file under Hadoop env succeeded."
#   else
#     echo "Copying test file under Hadoop env failed. Exiting..."
#     exit 1
#   fi
# fi

