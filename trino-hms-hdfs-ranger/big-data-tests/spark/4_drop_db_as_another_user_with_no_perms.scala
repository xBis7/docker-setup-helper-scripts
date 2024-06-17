

val user = spark.conf.get("spark.user", "spark")

val dbName="gross_test"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [DROP] privilege on [$dbName]"

val result = CommonUtils.dropDBwithException(dbName = dbName, expectedErrorMsg = expectedErrorMsg)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
