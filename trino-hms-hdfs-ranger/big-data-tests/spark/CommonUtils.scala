
object CommonUtils {

  def printUnexpectedExceptionMsg(operation: String, e: Exception): Boolean = {
    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' failed while it was expected to succeed.")
    println("\nMessage: " + e.getMessage)
    println("--------------------------")
    printf("\n\n")
    return false
  }

  def hasFailedWithTheExceptionAndMsg(operation: String, expectedErrorMsg: String, e: Exception): Boolean = {
    if (e.getMessage().contains(expectedErrorMsg)) {
      printf("\n\n")
      println("--------------------------")
      println(s"'$operation' failed with the expected error.")
      println("\nMessage: " + e.getMessage)
      println("--------------------------")
      printf("\n\n")
      return true
    } else {
      printf("\n\n")
      println("--------------------------")
      println(s"'$operation' failed with the wrong error.")
      println("\nExpected Message: " + expectedErrorMsg)
      println("\nActual Message: " + e.getMessage())
      println("--------------------------")
      printf("\n\n")
      return false
    }
  }

  def printUnexpectedSuccessMsg(): Any = {
    printf("\n\n")
    println("--------------------------")
    println("Test finished without issues while it was expected to fail.")
    println("--------------------------")
    printf("\n\n")
  }

  def printSuccessMsg(operation: String): Any = {
    printf("\n\n")
    println("--------------------------")
    println(s"'$operation' succeeded as expected.")
    println("--------------------------")
    printf("\n\n")
  }

// Create DB.
  def createDBwithException(isManaged: Boolean, expectedErrorMsg: String, dbName: String, dbLocation: Option[String]): Boolean = {

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
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def createDBNoException(isManaged: Boolean, dbName: String, dbLocation: Option[String]): Boolean = {

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
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

// Drop DB.
  def dropDBwithException(dbName: String, expectedErrorMsg: String): Boolean = {
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
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def dropDBNoException(dbName: String): Boolean = {
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
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

// Drop table.
  def dropTableWithException(dbName: String, tableName: String, expectedErrorMsg: String): Boolean = {
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
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def dropTableNoException(dbName: String, tableName: String): Boolean = {
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
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  } 

// Create table.
  def createTableWithDfAndNoException(dbName: String, tableName: String, tablePath: Option[String]): Boolean = {
    // Unwrap the Option variable. If it's not defined then 'path' will be empty.
    val path = tablePath.getOrElse("")

    val operation = "create table with df"

    printf("\n\n")
    println("Running commands:")
    println(s"""val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")""")

    if (path.nonEmpty) {
      println(s"""df.write.option("path", "$path").saveAsTable("$dbName.$tableName")""")
    } else {
      println(s"""df.write.saveAsTable("$dbName.$tableName")""")
    }

    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")

    try {
      if (path.nonEmpty) {
        df.write.option("path", path).saveAsTable(dbName + "." + tableName)
      } else {
        df.write.saveAsTable(dbName + "." + tableName)
      }

    } catch {
      case e: Exception =>
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

  def createTableWithException(dbName: String, tableName: String, expectedErrorMsg: String): Boolean = {
    val operation = "create table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("create table $dbName.$tableName (id int, greeting string)")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("create table " + dbName + "." + tableName + " (id int, greeting string)")
    } catch {
      case e: Exception =>
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

// Select table.
  def selectTableWithException(dbName: String, tableName: String, showResults: Boolean, expectedErrorMsg: String): Boolean = {
    val operation = "select table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("select * from $dbName.$tableName").show($showResults)""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("select * from " + dbName + "." + tableName).show(showResults)
    } catch {
      case e: Exception =>
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def selectTableNoException(dbName: String, tableName: String, showResults: Boolean): Boolean = {
    val operation = "select table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("select * from $dbName.$tableName").show($showResults)""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("select * from " + dbName + "." + tableName).show(showResults)
    } catch {
      case e: Exception =>
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

// Describe table.
  def describeTableNoException(dbName: String, tableName: String, showResults: Boolean): Boolean = {
    val operation = "describe table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("describe $dbName.$tableName").show($showResults)""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("describe " + dbName + "." + tableName).show(showResults)
    } catch {
      case e: Exception =>
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

// Show databases.
  def showDatabasesNoException(showResults: Boolean): Boolean = {
    val operation = "show databases"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("show databases").show($showResults)""")
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("show databases").show(showResults)
    } catch {
      case e: Exception =>
        return CommonUtils.printUnexpectedExceptionMsg(operation = operation, e = e)
    }

    CommonUtils.printSuccessMsg(operation = operation)

    true
  }

// Insert into.
  def insertIntoTableWithException(dbName: String, tableName: String, expectedErrorMsg: String): Boolean = {
    val operation = "insert into table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("insert into $dbName.$tableName values (4, 'Austin')")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("insert into " + dbName + "." + tableName + "values (4, 'Austin')")
    } catch {
      case e: Exception =>
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

// Alter table.
  def alterTableWithException(dbName: String, oldTableName: String, newTableName: String, expectedErrorMsg: String): Boolean = {
    val operation = "alter table"

    printf("\n\n")
    println("Running command:")
    println(s"""spark.sql("alter table $dbName.$oldTableName rename to $dbName.$newTableName")""")
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      spark.sql("alter table " + dbName + "." + oldTableName + " rename to " + dbName + "." + newTableName)
    } catch {
      case e: Exception =>
        return CommonUtils.hasFailedWithTheExceptionAndMsg(operation = operation, expectedErrorMsg = expectedErrorMsg, e = e)
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }


}

