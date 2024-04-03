try {
  spark.sql("alter table default.spark_test_table rename to default.new_spark_test_table")
  println("Test failed. Table altered successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [ALTER] privilege on [default/spark_test_table]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
