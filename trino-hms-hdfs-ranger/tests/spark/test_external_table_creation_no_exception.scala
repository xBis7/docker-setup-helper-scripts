// HACK: sqlStr is used to store table name in this case.
val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")

try {
  spark.read.text("hdfs://namenode:8020/test").write.option("path", "hdfs://namenode/opt/hive/data").mode("overwrite").format("csv").saveAsTable(sqlStr)
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
