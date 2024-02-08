#!/bin/bash

source "./testlib.sh"

abs_path=$1

# Ranger paths
ranger_common_jar_path="$abs_path/$PROJECT_RANGER/agents-common/target/ranger-plugins-common-3.0.0-SNAPSHOT-jar-with-dependencies.jar"
ranger_audit_jar_path="$abs_path/$PROJECT_RANGER/agents-audit/target/ranger-plugins-audit-3.0.0-SNAPSHOT.jar"

ranger_hdfs_jar_path="$abs_path/$PROJECT_RANGER/hdfs-agent/target/ranger-hdfs-plugin-3.0.0-SNAPSHOT.jar"
ranger_hive_jar_path="$abs_path/$PROJECT_RANGER/hive-agent/target/ranger-hive-plugin-3.0.0-SNAPSHOT.jar"

ranger_hdfs_audit_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-audit.xml"
ranger_hdfs_security_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-hdfs-security.xml"
ranger_hdfs_policymgr_conf_path="$abs_path/$PROJECT_RANGER/hdfs-agent/conf/ranger-policymgr-ssl.xml"

# HDFS paths
hdfs_jars_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/share/hadoop/hdfs/lib"
hdfs_conf_path="$abs_path/$PROJECT_HADOOP/hadoop-dist/target/hadoop-3.3.6/etc/hadoop"

# Hive path
hive_jars_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-3.1.3-bin/apache-hive-3.1.3-bin/lib"

# Ranger - HDFS setup
echo "Copying Ranger jars under HDFS."
cp "$ranger_common_jar_path" "$hdfs_jars_path"
cp "$ranger_audit_jar_path" "$hdfs_jars_path"
cp "$ranger_hdfs_jar_path" "$hdfs_jars_path"
echo "Copy finished."

echo "Copying Ranger HDFS config files under HDFS."
cp "$ranger_hdfs_audit_conf_path" "$hdfs_conf_path"
cp "$ranger_hdfs_security_conf_path" "$hdfs_conf_path"
cp "$ranger_hdfs_policymgr_conf_path" "$hdfs_conf_path"
echo "Copy finished."

# Ranger - Hive setup
echo "Copying Ranger jars under Hive."
cp "$ranger_common_jar_path" "$hive_jars_path"
cp "$ranger_audit_jar_path" "$hive_jars_path"
cp "$ranger_hive_jar_path" "$hive_jars_path"
echo "Copy finished."

echo "Making hive 'entrypoint.sh' executable."
hive_generated_entrypoint_path="$abs_path/$PROJECT_HIVE/packaging/target/apache-hive-3.1.3-bin/apache-hive-3.1.3-bin/compose/hive-metastore-ranger"
chmod u+x "$hive_generated_entrypoint_path/entrypoint.sh"
echo "Permissions updated."

