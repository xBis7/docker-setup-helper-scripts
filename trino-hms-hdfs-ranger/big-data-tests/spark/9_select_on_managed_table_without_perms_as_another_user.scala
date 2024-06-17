
val user = spark.conf.get("spark.user", "spark")

val dbName = "gross_test"
val tableName = "test"

val expectedError = s"Permission denied: user [$user] does not have [SELECT] privilege on [$dbName]"

val selectResult = CommonUtils.selectTableWithException(dbName = dbName, tableName = tableName, showResults = false, expectedErrorMsg = expectedError)

if (selectResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}