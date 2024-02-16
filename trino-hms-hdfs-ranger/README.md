## Basic Instructions

You can execute `run_all.sh` to execute all scripts or just run each one of them.

### run_all.sh

Executes all scripts in the following order

1. get_or_update_projects.sh
2. build_projects.sh
3. setup_docker_env.sh
4. test_all.sh
    1. start_docker_env.sh
    2. test_hdfs_data_creation.sh
    3. test_hive_no_hdfs_perm.sh
    4. test_hive_no_perms.sh
    5. test_hive_all_perms.sh
    6. test_hive_only_select_perm.sh
    7. test_hive_select_alter_perm.sh
    8. stop_docker_env.sh 

Parameters:
1. Absolute path to the parent directory of the projects
2. Current github user
3. Github user who owns the remote fork, to use to update the local repo
4. Step to start building from, to skip building a project (1, 2, 3, ...)
5. Path to JAVA_HOME for JDK 8 (there is a default if left empty)
6. Path to JAVA_HOME for JDK 21 (there is a default if left empty)

### get_or_update_projects.sh

Clones the projects in a specified directory. If projects exist, then it just updates their branches.

Parameters:
1. Absolute path to the parent directory of the projects
2. Current github user
3. Github user who owns the remote fork, to use to update the local repo

### build_projects.sh

Builds all projects. The user has the option to skip a project build.

Parameters:
1. Absolute path to the parent directory of the projects
2. Step to start building from, to skip building a project (1, 2, 3, ...)
3. Path to JAVA_HOME for JDK 8 (there is a default if left empty)
4. Path to JAVA_HOME for JDK 21 (there is a default if left empty)

### setup_docker_env.sh

Copies the necessary files from Ranger to HDFS and Hive and also makes any further modifications needed to prepare the docker environment.

Parameters:
1. Absolute path to the parent directory of the projects

### start_docker_env.sh

Starts all docker environments in a particular order

1. Ranger
2. Hadoop
3. Hive-metastore
4. Trino

Parameters:
1. Absolute path to the parent directory of the projects

### stop_docker_env.sh

Stops all docker environments in reverse order from the one used for starting them.
This is done to make sure all docker networks are properly removed.

Parameters:
1. Absolute path to the parent directory of the projects

### ranger_dumps

This directory contains dump files from the ranger postgres DB.

Currently the following dumps exist:

* `1_defaults`, default policies, hadoopdev and hivedev
* `2_defaults_no_hive_perm_defaultdb`, defaults + all access has been removed for hive defaultdb
* `3_hdfs_all`, 2_defaults_no_hive_perm_defaultdb + allowing all HDFS access to user postges
* `4_hive_defaultdb_all`, 3_hdfs_all + all access to hive defaultdb for user postgres
* `5_hive_defaultdb_select`, 3_postgres_hdfs + user postgres has only select access to defaultdb
* `6_hive_defaultdb_select_alter`, 3_postgres_hdfs + user postgres has select, alter access to defaultdb

### test_hdfs_data_creation.sh

Updates the Ranger policies using `2_defaults_no_hive_perm_defaultdb.sql` dump file and then tries to create some data in HDFS. Operation is expected to succeed.

### test_hive_no_hdfs_perm.sh

This is expected to be run after `test_hdfs_data_creation.sh` and reuse the existing Ranger policies and due to that there are no Ranger changes.
It tries to create a table in Trino. The user doesn't have HDFS permissions and therefore the operation is expected to fail.

### test_hive_no_perms.sh

Updates the Ranger policies using `3_postgres_hdfs.sql` dump file and then tries to create a table in Trino. The user has access to the HDFS path but has no access to the metadata. Operation is expected to fail.

### test_hive_all_perms.sh
 
Updates the Ranger policies using `4_hive_defaultdb_all.sql` dump file and then tries to create a table in Trino. User has access to the HDFS path and also has the privileges to create the table. Operation is expected to succeed.

### test_hive_only_select_perm.sh / test_hive_select_alter_perm.sh

Both of these scripts are expected to be run after `test_hive_all_perms.sh` so that the Trino table has been successfully created. A new script has been added for setting up the environment in case these scripts need to be run independently. 

Run `setup_for_testing_hms_policies.sh` first and then proceed with the scripts. This will 
* start the docker env
* set the Ranger policies
* create the HDFS data
* create a Trino table

#### test_hive_only_select_perm.sh

Updates the Ranger policies using `5_hive_defaultdb_select.sql` dump file and then tries to run [select] and [alter] on the Trino table. [select] should succeed and [alter] fail.

#### test_hive_select_alter_perm.sh

Updates the Ranger policies using `6_hive_defaultdb_select_alter.sq` dump file and then tries to run [select] and [alter] on the Trino table. Both operations should succeed.
