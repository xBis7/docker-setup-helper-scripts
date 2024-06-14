
val user = spark.conf.get("spark.user", "spark")
val namenode = spark.conf.get("spark.namenode", "namenode")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

// Drop DB.
CommonUtils.dropDBNoException(dbName = dbName)

val dbLocation = dbBaseDir + "/gross_test.db"
val hdfsLocation: String = s"hdfs://$namenode$dbLocation"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

// Create the DB again but this time as managed.
CommonUtils.createDBwithException(isManaged = true, expectedErrorMsg = expectedErrorMsg, dbName = dbName, dbLocation = None)
