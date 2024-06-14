
object CommonUtils {

  def printUnexpectedExceptionMsg(operation: String, e: Exception): Any = {
    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' failed while it was expected to succeed.")
    println("\nMessage: " + e.getMessage)
    println("--------------------------")
    printf("\n\n")
    sys.exit(1)
  }

  def handleExpectedExceptionWithMsg(operation: String, expectedErrorMsg: String, e: Exception): Any = {
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

// Create DB.
  def createDBwithException(isManaged: Boolean, expectedErrorMsg: String, dbName: String, dbLocation: Option[String]): Any = {

    if (isManaged && dbLocation.isDefined) {
      throw new IllegalArgumentException("'dbLocation' shouldn't be specified for a managed DB.")
    }

    // In case of non-managed DB, check that the dbLocation isn't empty.
    if (!isManaged) {
      dbLocation match {
        case Some(location) => // Do nothing. This is just for the Scala compiler.
        case None => throw new IllegalArgumentException("'dbLocation' must be specified for a non-managed DB.")
      }
    }

    // Because 'dbLocation' is Option[String] and not String, when there is a value, it will be Some("/path/to/db").
    // We need to unwrap it and get just the String value "/path/to/db".
    val location: String = dbLocation.getOrElse("")

    val operation = "create database"

    printf("\n\n")
    println("Running command:")

    if (isManaged) {
      println(s"""spark.sql("create database $dbName")""")
    } else {
      println(s"""spark.sql("create database $dbName location '$location'")""")
    }

    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      if (isManaged) {
        spark.sql("create database " + dbName)
      } else {
        spark.sql("create database " + dbName + " location '" + location + "'")
      }
    } catch {
      case e: Exception =>
        CommonUtils.handleExpectedExceptionWithMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println("Test finished without issues while it was expected to fail.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(1)
  }

  def createDBNoException(isManaged: Boolean, dbName: String, dbLocation: Option[String]): Any = {

    if (isManaged && dbLocation.isDefined) {
      throw new IllegalArgumentException("'dbLocation' shouldn't be specified for a managed DB.")
    }

    // In case of non-managed DB, check that the dbLocation isn't empty.
    if (!isManaged) {
      dbLocation match {
        case Some(location) => // Do nothing. This is just for the Scala compiler.
        case None => throw new IllegalArgumentException("'dbLocation' must be specified for a non-managed DB.")
      }
    }

    // Because 'dbLocation' is Option[String] and not String, when there is a value, it will be Some("/path/to/db").
    // We need to unwrap it and get just the String value "/path/to/db".
    val location: String = dbLocation.getOrElse("")

    val operation = "create database"

    printf("\n\n")
    println("Running command:")

    if (isManaged) {
      println(s"""spark.sql("create database $dbName")""")
    } else {
      println(s"""spark.sql("create database $dbName location '$location'")""")
    }

    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      if (isManaged) {
        spark.sql("create database " + dbName)
      } else {
        spark.sql("create database " + dbName + " location '" + location + "'")
      }
    } catch {
      case e: Exception =>
        CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' succeeded as expected.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(0)
  }

// Drop DB.
  def dropDBwithException(dbName: String, expectedErrorMsg: String): Any = {
    val operation = "drop database"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("drop database $dbName")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("drop database " + dbName)
    } catch {
      case e: Exception =>
        CommonUtils.handleExpectedExceptionWithMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println("Test finished without issues while it was expected to fail.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(1)
  }

  def dropDBNoException(dbName: String): Any = {
    val operation = "drop database"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("drop database $dbName")""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("drop database " + dbName)
    } catch {
      case e: Exception =>
        CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' succeeded as expected.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(0)
  }

// Drop table.
  def dropTableWithException(dbName: String, tableName: String, expectedErrorMsg: String): Any = {
    val operation = "drop table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("drop table $dbName.$tableName")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("drop table " + dbName + "." + tableName)
    } catch {
      case e: Exception =>
        CommonUtils.handleExpectedExceptionWithMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println("Test finished without issues while it was expected to fail.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(1)
  }

  def dropTableNoException(dbName: String, tableName: String): Any = {
    val operation = "drop table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("drop table $dbName.$tableName")""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("drop table " + dbName + "." + tableName)
    } catch {
      case e: Exception =>
        CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' succeeded as expected.")
    println("--------------------------")
    printf("\n\n")

    sys.exit(0)
  } 

  
}

