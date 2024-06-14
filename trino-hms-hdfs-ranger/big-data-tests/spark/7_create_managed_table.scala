
val dbName = "gross_test"
val tableName = "test"

val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")

df.write.saveAsTable("gross_test.test")

spark.sql("select * from gross_test.test")

spark.sql("describe extended gross_test.test").show(false)

CommonUtils.dropTableWithException(dbName = dbName, tableName = tableName)
