try {
  spark.sql("create table animals (id int, name string) using parquet partitioned by (name)")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
