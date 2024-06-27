import scala.reflect.runtime.currentMirror
import scala.tools.reflect.ToolBox
import java.util.Base64

object CommonUtils {

  def printUnexpectedExceptionMsg(e: Exception): Boolean = {
    printf("\n\n")
    println("--------------------------")
    println(s"Command failed while it was expected to succeed.")
    println("\nMessage: " + e.getMessage)
    println("--------------------------")
    printf("\n\n")
    return false
  }

  def hasFailedWithTheExceptionAndMsg(expectedErrorMsg: String, e: Exception): Boolean = {
    if (e.getMessage().contains(expectedErrorMsg)) {
      printf("\n\n")
      println("--------------------------")
      println(s"Command failed with the expected error.")
      println("\nMessage: " + e.getMessage)
      println("--------------------------")
      printf("\n\n")
      return true
    } else {
      printf("\n\n")
      println("--------------------------")
      println(s"Command failed with the wrong error.")
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

  def printSuccessMsg(): Any = {
    printf("\n\n")
    println("--------------------------")
    println(s"Command succeeded as expected.")
    println("--------------------------")
    printf("\n\n")
  }

  def runCommandWithException(encodedCommandStr: String, encodedExpectedErrorMsg: String): Boolean = {    
    // Decode the base64 encoded command.
    val decodedCmdBytes = Base64.getDecoder.decode(encodedCommandStr)
    val decodedCommandStr = new String(decodedCmdBytes)

    // Decode the base64 encoded error message.
    val decodedErrorBytes = Base64.getDecoder.decode(encodedExpectedErrorMsg)
    val decodedErrorStr = new String(decodedErrorBytes)

    printf("\n\n")
    println("Running command:")
    println(decodedCommandStr)
    println("\nExpecting it to fail.")
    println("--------------------------")
    printf("\n\n")

    try {
      // Using Scala reflection, we can execute the String as scala code.
      val mkToolBox = currentMirror.mkToolBox()
      // This command is running in a new context and we need to make the spark object available.
      // In case the cmd contains `toDF`, we need to add 'import spark.implicits._',
      // after the spark object has been created.
      val wrappedCommand = s"""
        |import org.apache.spark.sql.SparkSession
        |val spark = SparkSession.builder().getOrCreate()
        |import spark.implicits._
        |try {
        |   $decodedCommandStr
        |} catch {
        |   case e: Exception =>
        | // Sometimes the exception isn't propagated properly.
        | // Rethrow it to make sure that the outer catch gets it.
        |     throw e
        |}
      """.stripMargin
      mkToolBox.eval(mkToolBox.parse(wrappedCommand))
    } catch {
      case e: Exception =>
        // Because the command is run using Scala reflection,
        // the expected exception is wrapped and thrown as 'java.lang.reflect.InvocationTargetException'
        // The actual exception can be found in the cause. We have to check the cause and test it.
        e.getCause match {
          case cause: Exception =>
            println(s"\nRoot cause of thrown exception: \n${cause.getMessage}")
            return CommonUtils.hasFailedWithTheExceptionAndMsg(expectedErrorMsg = decodedErrorStr, e = cause)
          case _ =>
            println("No root cause found on the thrown exception.")
            e.printStackTrace()
            return false
        }
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def runCommandNoException(encodedCommandStr: String): Boolean = {
    // Decode the base64 encoded command.
    val decodedCmdBytes = Base64.getDecoder.decode(encodedCommandStr)
    val decodedCommandStr = new String(decodedCmdBytes)

    printf("\n\n")
    println("Running command:")
    println(decodedCommandStr)
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    try {
      // Using Scala reflection, we can execute the String as scala code.
      val mkToolBox = currentMirror.mkToolBox()
      // This command is running in a new context and we need to make the spark object available.
      // In case the cmd contains `toDF`, we need to add 'import spark.implicits._',
      // after the spark object has been created.
      val wrappedCommand = s"""
        |import org.apache.spark.sql.SparkSession
        |val spark = SparkSession.builder().appName("Spark SQL").master("local").getOrCreate()
        |import spark.implicits._
        |try {
        |   $decodedCommandStr
        |} catch {
        |   case e: Exception =>
        | // Sometimes the exception isn't propagated properly.
        | // Rethrow it to make sure that the outer catch gets it.
        |     throw e
        |}
      """.stripMargin
      mkToolBox.eval(mkToolBox.parse(wrappedCommand))
    } catch {
      case e: Exception =>
        // Because the command is run using Scala reflection,
        // the expected exception is wrapped and thrown as 'java.lang.reflect.InvocationTargetException'
        // The actual exception can be found in the cause. We have to check the cause and test it.
        e.getCause match {
          case cause: Exception =>
            println(s"\nRoot cause of thrown exception: \n${cause.getMessage}")
            return CommonUtils.printUnexpectedExceptionMsg(e = cause)
          case _ =>
            println("No root cause found on the thrown exception.")
            e.printStackTrace()
            return false
        }
    }

    CommonUtils.printSuccessMsg

    true
  }

}

