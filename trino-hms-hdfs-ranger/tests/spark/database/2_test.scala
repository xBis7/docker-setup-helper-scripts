try {
  spark.sql("create database poc_db location 'hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db'")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
