try {
  spark.sql("drop table default.new_spark_test_table")
  println("Test failed. Table dropped successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [DROP] privilege on [default/new_spark_test_table]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
