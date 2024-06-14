
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"

CommonUtils.createDBNoException(dbName, dbLocation)
