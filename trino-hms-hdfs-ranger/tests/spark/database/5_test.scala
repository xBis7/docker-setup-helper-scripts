try {
  spark.read.text("hdfs://namenode:8020/test").write.option("path", "hdfs://namenode/opt/hive/data").mode("overwrite").format("csv").saveAsTable("poc_db.spark_test_table")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
