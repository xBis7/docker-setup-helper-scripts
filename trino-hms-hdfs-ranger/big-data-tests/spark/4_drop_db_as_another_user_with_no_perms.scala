

val user = spark.conf.get("spark.user", "spark")

val dbName="gross_test"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [DROP] privilege on [$dbName]"

CommonUtils.dropDBwithException(dbName = dbName, expectedErrorMsg = expectedErrorMsg)

