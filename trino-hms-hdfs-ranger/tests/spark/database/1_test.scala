try {
  spark.sql("create database poc_db location 'hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db'")
  println("Test failed. Database created successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
