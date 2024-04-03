try {
  spark.read.text("hdfs://namenode:8020/test").write.option("path", "hdfs://namenode/opt/hive/data").mode("overwrite").format("csv").saveAsTable("poc_db.spark_test_table")
  println("Test failed. Table created successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [CREATE] privilege on [poc_db/spark_test_table]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}