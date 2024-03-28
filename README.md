# docker-setup-helper-scripts

Helper scripts for setting up docker environments. Check each individual directory.

This project is compatible with both Hive 3 and 4 versions. Scripts look for `HIVE_VERSION` environment variable. If it is present and has value 4, project will be setup for Hive 4. Otherwise, Hive 3 setup will take place. At the moment Hive 4 works only with Trino. Further changes are needed for it to work with Spark.

Before changing `HIVE_VERSION` in is important to brind Docker services down so that build step can clean target directories and fies. `get_or_update_projects.sh` and `build_projects.sh` scripts should be run afterward to prepare project. At the moment only Ranger and Hive need to be rebuild.
