
val user = spark.conf.get("spark.user", "spark")
val namenode = spark.conf.get("spark.namenode", "namenode")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"
val hdfsLocation: String = s"hdfs://$namenode$dbLocation"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

CommonUtils.createDBwithException(dbName, dbLocation, expectedErrorMsg)

