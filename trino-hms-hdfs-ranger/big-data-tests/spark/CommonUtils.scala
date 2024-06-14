
object CommonUtils {

  def createDBwithException(dbName: String, dbLocation: String, expectedErrorMsg: String): Any = {
    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("create database $dbName location '$dbLocation'")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("create database " + dbName + " location '" + dbLocation + "'")
    } catch {
      case e: Exception =>
        if (e.getMessage().contains(expectedErrorMsg)) {
          printf("\n\n")
          println("--------------------------")
          println("'create database' failed with the expected error.")
          println("\nMessage: " + e.getMessage)
          println("--------------------------")
          printf("\n\n")
          sys.exit(0)
        } else {
          printf("\n\n")
          println("--------------------------")
          println("'create database' failed with the wrong error.")
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
  }

  def createDBNoException(dbName: String, dbLocation: String): Any = {
    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("create database $dbName location '$dbLocation'")""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("create database " + dbName + " location '" + dbLocation + "'")
    } catch {
      case e: Exception =>
        printf("\n\n")
        println("--------------------------")
        println("'create database' failed while it was expected to succeed.")
        println("\nMessage: " + e.getMessage)
        println("--------------------------")
        printf("\n\n")
        sys.exit(1)
    }

    printf("\n\n")
    println("--------------------------")
    println("'create database' succeeded as expected.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(0)
  }
}

