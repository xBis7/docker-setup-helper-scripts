#!/bin/bash

# Policy names and URIs.
HDFS_ALL_POLICY_NAME="all - path"
HDFS_ALL_POLICY_URI_NAME="all%20-%20path"
HIVE_ALL_DB_POLICY_NAME="all - database, table, column"
HIVE_ALL_DB_POLICY_URI_NAME="all%20-%20database,%20table,%20column"
HIVE_DEFAULTDB_POLICY_NAME="default database tables columns"
HIVE_DEFAULTDB_POLICY_URI_NAME="default%20database%20tables%20columns"
HIVE_URL_POLICY_NAME="all - url"
HIVE_URL_POLICY_URI_NAME="all%20-%20url"

# Service names.
HADOOP_RANGER_SERVICE="hadoopdev"
HIVE_RANGER_SERVICE="hivedev"

# Ranger ui variables.
RANGER_UI_USERNAME="admin"
RANGER_UI_PASSWORD="rangerR0cks!"
RANGER_UI_HOSTNAME="http://localhost"
RANGER_UI_PORT="6080"

DEBUG="false"
