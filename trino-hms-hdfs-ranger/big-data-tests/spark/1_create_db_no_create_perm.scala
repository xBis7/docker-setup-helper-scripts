
val user = spark.conf.get("spark.user", "spark")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [CREATE] privilege on [$dbName]"

val result = CommonUtils.createDBwithException(isManaged = false, expectedErrorMsg = expectedErrorMsg, dbName = dbName, dbLocation = Some(dbLocation))

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
