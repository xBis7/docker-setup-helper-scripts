// Create database / Drop database - 100 iterations.

val iterations = spark.conf.get("spark.iteration_num", "10").toInt

var counter = 0

while (counter < iterations) {

  val errorMsg = " failed during iteration '" + counter + "'"

  try {
    spark.sql("create database gross_test location '/opt/hive/data/gross_test/gross_test.db'")
  } catch {
    case e: Exception =>
      println("'create database' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  try {
    spark.sql("drop database gross_test").show()
  } catch {
    case e: Exception =>
      println("'drop database' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  println("--------------------------")
  println("Finished iteration '" + counter + "'.")
  println("--------------------------")
  printf("\n\n")

  counter += 1
}

println("Test finished without issues.")
sys.exit(0)
