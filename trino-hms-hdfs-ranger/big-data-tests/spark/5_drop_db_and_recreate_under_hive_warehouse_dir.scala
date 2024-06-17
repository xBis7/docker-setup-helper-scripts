
val user = spark.conf.get("spark.user", "spark")
val namenode = spark.conf.get("spark.namenode", "namenode")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

// Drop DB.
val dropResult = CommonUtils.dropDBNoException(dbName = dbName)

// If the previous command didn't fail, then continue.
if (!dropResult) {
  sys.exit(1)
}

val dbLocation = dbBaseDir + "/gross_test.db"
val hdfsLocation: String = s"hdfs://$namenode$dbLocation"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

// Create the DB again but this time as managed.
val createResult = CommonUtils.createDBwithException(isManaged = true, expectedErrorMsg = expectedErrorMsg, dbName = dbName, dbLocation = None)

if (createResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}
