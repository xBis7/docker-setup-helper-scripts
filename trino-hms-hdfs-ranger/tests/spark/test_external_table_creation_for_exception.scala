// HACK: sqlStr is used to store table name in this case.
val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")
val msgStr = spark.conf.get("spark.app.msg", "default_msg_value")

try {
  spark.read.text("hdfs://namenode:8020/test").write.option("path", "hdfs://namenode/opt/hive/data").mode("overwrite").format("csv").saveAsTable(sqlStr)
  println("Test failed. Table created successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains(msgStr) =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
