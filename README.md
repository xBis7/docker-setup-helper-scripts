# docker-setup-helper-scripts

Helper scripts for setting up docker environments. Check each individual directory.

It is considered that each script is run from trino-hms-hdfs-ranger as current working directory.

## Hive version
This project is compatible with both Hive 3 and 4 versions. Scripts look for `HIVE_VERSION` environment variable. If it is present and has value 4, project will be setup for Hive 4. Otherwise, Hive 3 setup will take place. At the moment Hive 4 works only with Trino. Further changes are needed for it to work with Spark.

Before changing `HIVE_VERSION` in is important to bring Docker services down so that build step can clean target directories and fies. `get_or_update_projects.sh` and `build_projects.sh` scripts should be run afterward to prepare project. At the moment only Ranger and Hive need to be rebuild.

## Ranger API
For Ranger API to work, set variable RANGER\_UI\_PASSWORD=\<password>

## Load tests
Load tests are considering that there is clean state in HDFS/HMS. If there is not, there is a possibility that objects with the same names as in tests need to be removed beforehand.
Run `./big-data-c3-tests/setup.sh ~` script before running tests for policies to be set up. Run each load test in it's own terminal. Before running, be sure to specify Kerberos ticket cache location, because by default terminal sessions share credentials. To do so, run `export KRB5CCNAME=/tmp/krb5cc_sessionX` for each terminal, chaning the value for X, so that each terminal has different location. Command for running a test `./big-data-c3-tests/load-testing/run_test.sh ~ <test_number> <iteration_number> <background_run>`.

## Big Data team tests
Before running tests, be sure to export next variables:
- RANGER\_UI\_PASSWORD=\<password>
- HDFS\_USER=\<c3\_user>

### Spark
Spark tests are supposed to be run first, from the HDFS node.
Run Spark tests with `./big-data-c3-tests/trino-spark-tests/test_spark.sh ~`.

### Trino
Before running Trino tests, be sure to install sshpass and export next variables:
- SSHPASS=\<c3\_credentials>

Tests reqire multiple users. Because of that export next variables: (when first access token variable is exported, be sure to go to login page via browser and logout so that login is required for second. After that no longer logins are necessary)
- SIGNIN\_PROFILE\_USER\_ACCESS\_TOKEN\_BASE64=$(signin access-token trino001-s-vgis -p user | base64 -w 0)
- SIGNIN\_PROFILE\_SVC\_ACCESS\_TOKEN\_BASE64=$(signin access-token trino001-s-vgis -p svc | base64 -w 0)
- SIGNIN\_PROFILE\_USER=\<c3\_user>
- TRINO\_USER2=\<c3\_user>

It seems that Trino has different default Hive warehouse dir than Spark.
For some reason `hive` catalog cannot be used  directly and it seems that `oss_hive` is its synonym? It might happen that access is denied to it. In that case modify /etc/trino/rules.json by adding `oss_hive` to catalogs.

Trino tests are supposed to be run second, from Devpod.
After running Spark tests, cleanup is needed. To do so, run `./big-data-c3-tests/trino-spark-tests/trino/cleanup.sh`.
Run Trino tests with `./bin-data-c3-tests/trino-spark-tests/test_trino.sh`.
