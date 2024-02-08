## Basic Instructions

`run_all.sh` executes all scripts in the following order

1. get_or_update_projects.sh
2. build_projects.sh
3. setup_docker_env.sh
4. start_docker_env.sh

### get_or_update_projects.sh

Clones the projects in a specified directory. If projects exist, then it just updates their branches.

### build_projects.sh

Builds all projects. The user has the option to skip a project build.

### setup_docker_env.sh

Copies the necessary files from Ranger to HDFS and Hive and also makes any further modifications needed to prepare the docker environment.

### start_docker_env.sh

Starts all docker environments in a particular order

1. Ranger
2. Hadoop
3. Hive-metastore
4. Trino


