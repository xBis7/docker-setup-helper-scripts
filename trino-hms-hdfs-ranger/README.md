## Basic Instructions

You can execute `run_all.sh` to execute all scripts or just run each one of them.

### run_all.sh

Executes all scripts in the following order

1. get_or_update_projects.sh
2. build_projects.sh
3. setup_docker_env.sh
4. start_docker_env.sh

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

This is an explanation of the files names

* `defaults`, contains only the default `hadoopdev` and `hivedev` policies
* `postres_added_to_hdfs`, this is the `defaults` + granted all access to all HDFS paths to user `postgres`
* `postgres_hive_defaultdb_select`, this is the `postgres_added_to_hdfs` + `select` access to the default hive db for user `postgres`
* `postgres_hive_defaultdb_select_alter`, this is the `postgres_hive_defaultdb_select` + `alter` access to the default hive db for user `postgres`
