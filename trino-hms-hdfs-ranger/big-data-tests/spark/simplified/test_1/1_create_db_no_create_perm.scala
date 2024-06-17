
val user = spark.conf.get("spark.user", "spark")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"

val expectedErrorMsg = s"Permission denied: user [$user] does not have [CREATE] privilege on [gross_test]"

val operation = "create database"

printf("\n\n")
println("Running command:")
println(s"""spark.sql("create database gross_test location '$dbLocation'")""")
println("\nExpecting it to fail.")
println("--------------------------")
printf("\n\n")

try {
  spark.sql("create database gross_test location '" + dbLocation + "'")
} catch {
  case e: Exception =>
    if (e.getMessage().contains(expectedErrorMsg)) {
      printf("\n\n")
      println("--------------------------")
      println(s"'$operation' failed with the expected error.")
      println("\nMessage: " + e.getMessage)
      println("--------------------------")
      printf("\n\n")
      sys.exit(0)
    } else {
      printf("\n\n")
      println("--------------------------")
      println(s"'$operation' failed with the wrong error.")
      println("\nExpected Message: " + expectedErrorMsg)
      println("\nActual Message: " + e.getMessage())
      println("--------------------------")
      printf("\n\n")
      sys.exit(1)
    }
}

printf("\n\n")
println("--------------------------")
println("Test finished without issues while it was expected to fail.")
println("--------------------------")
printf("\n\n")

sys.exit(1)