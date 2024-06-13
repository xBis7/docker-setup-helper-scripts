val user = spark.conf.get("spark.user", "spark")
val db_base_dir = spark.conf.get("spark.db_base_dir", "/data/projects")

val db_location = db_base_dir + "/gross_test/gross_test.db"

val expectedErrorMsg = "Permission denied: user [" + user + "] does not have [CREATE] privilege on [gross_test]"

try {
  spark.sql("create database gross_test location '" + db_location + "'")
} catch {
  case e: Exception =>
    if (e.getMessage().contains(expectedErrorMsg)) {
      println("'create database' failed with the expected error.")
      println("Message: " + e.getMessage())
      sys.exit(0)
    } else {
      println("'create database' failed with the wrong error.")
      println("Message: " + e.getMessage())
      sys.exit(1)
    }
}

println("Test finished without issues while it was expected to fail.")
sys.exit(1)
