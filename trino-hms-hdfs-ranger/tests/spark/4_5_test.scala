try {
  spark.sql("truncate table sports")
  println("Test failed. Table altered successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [ALTER] privilege on [default/sports]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
