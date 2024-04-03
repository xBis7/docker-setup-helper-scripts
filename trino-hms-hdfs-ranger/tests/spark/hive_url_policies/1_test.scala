try {
  spark.sql("create table persons (id int, name string)")
  println("Test failed. Table created successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/opt/hive/data/persons, hdfs://namenode/opt/hive/data/persons/]]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
