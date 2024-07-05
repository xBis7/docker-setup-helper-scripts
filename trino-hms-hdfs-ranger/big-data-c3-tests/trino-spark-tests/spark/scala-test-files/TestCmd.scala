import java.io.{ByteArrayOutputStream, PrintStream}
import scala.reflect.runtime.currentMirror
import scala.tools.reflect.ToolBox
import java.util.Base64
import java.io.File

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
            println("\nNo root cause found on the thrown exception.")
            e.printStackTrace()
            return false
        }
    }

    CommonUtils.printUnexpectedSuccessMsg

    false
  }

  def runCommandNoException(encodedCommandStr: String, encodedExpectedOutput: Option[String] = None): Boolean = {
    // Decode the base64 encoded command.
    val decodedCmdBytes = Base64.getDecoder.decode(encodedCommandStr)
    val decodedCommandStr = new String(decodedCmdBytes)

    printf("\n\n")
    println("Running command:")
    println(decodedCommandStr)
    println("\nExpecting it to succeed.")
    println("--------------------------")
    printf("\n\n")

    // Get the original streams, so that we can later restore 'System.out' and 'System.err'.
    // Setup new streams to capture the output.
    val originalOut = System.out
    val originalErr = System.err
    val outStream = new ByteArrayOutputStream()
    val errStream = new ByteArrayOutputStream()
    val printOutStream = new PrintStream(outStream)
    val printErrStream = new PrintStream(errStream)
    System.setOut(printOutStream)
    System.setErr(printErrStream)

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
      // The command and it's output are both run within the mkToolBox context.
      // Use 'Console.withOut' to redirect the output from within the context to the stream.
      // 'Console.withOut' is generally used to redirect output and it can also be used to redirect the output to a file.
      Console.withOut(printOutStream) {
        Console.withErr(printErrStream) {
          mkToolBox.eval(mkToolBox.parse(wrappedCommand))
        }
      }
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
            println("\nNo root cause found on the thrown exception.")
            e.printStackTrace()
            return false
        }
    } finally {
      // Restore 'System.out' and 'System.err' to the original streams.
      printOutStream.flush()
      printErrStream.flush()
      System.setOut(originalOut)
      System.setErr(originalErr)
    }

    // Check the captured output.
    val outputString = outStream.toString
    // We can get standard error with 'errStream.toString'.
    // Checking for error here is redundant due to the above try-catch.
    // But regardless of that, we need to set the err stream.

    // Check if an expected output string has been provided.
    val encodedExpectedStr = encodedExpectedOutput.getOrElse("")
    if (encodedExpectedStr.nonEmpty) {
      // Decode the base64 encoded expected output.
      val decodedOutputBytes = Base64.getDecoder.decode(encodedExpectedStr)
      val decodedOutputStr = new String(decodedOutputBytes)

      if (!outputString.contains(decodedOutputStr)) {
        println(s"\nFAILURE: Expected output '$decodedOutputStr' was NOT found in the command output.")
        return false
      } else {
        println(s"\nThe command output contains the expected output '$decodedOutputStr'.")
      }
    }

    CommonUtils.printSuccessMsg

    true
  }

  def initExternalCatalogObjAndSendSignal(signalFileNameToUpdateSelect: String, signalFileNameThatUpdateIsDone: String, updateInterval: Int): Any = {
    // Signal Files.
    val updateSelectSignalFile = new File(s"/tmp/$signalFileNameToUpdateSelect")
    val updateDoneSignalFile = new File(s"/tmp/$signalFileNameThatUpdateIsDone")

    // Increment 'updateInterval' by 5 secs just to be sure that enough time has passed.
    // Method parameters are immutable.
    val sleepTime = updateInterval + 5

    // Assuming that the shell script has provided select access, we need to wait here
    // to make sure that the policy update has taken place.
    // 'sleepTime' is in seconds and we need to change it to milliseconds.
    println("\nscala - Waiting to get a policy update from Ranger.")
    Thread.sleep(sleepTime * 1000)

    println("\nscala - Running command: 'spark.sql(\"show databases\")'")
    println("\nscala - To initialize the 'externalCatalog' object.")
    println("--------------------------")
    printf("\n\n")

    // Run the command.
    spark.sql("show databases")

    println("scala - Creating the update select signal file.")

    // The command finished, create the signal file so that the shell script will remove the select access.
    updateSelectSignalFile.createNewFile()

    println("scala - Waiting for the signal file that the select update has been made.")

    while (!updateDoneSignalFile.exists()) {
      Thread.sleep(1000)
    }
    
    println("scala - The signal file has been found.")

    println("\nscala - Waiting to get a policy update from Ranger.")
    Thread.sleep(sleepTime * 1000)
  } 
}

val command = spark.conf.get("spark.encoded.command", "default.spark.sql")
val expectException = spark.conf.get("spark.expect_exception", "false")

var updateSelectSignalFile: String = ""
var updateDoneSignalFile: String = ""
var policiesUpdateInterval: Option[Int] = None

// If there are values, then we should perform some actions to initialize the 'externalCatalog' object.
try {
  updateSelectSignalFile = spark.conf.get("spark.signal.file_name.update_select")
  updateDoneSignalFile = spark.conf.get("spark.signal.file_name.update_done")
  policiesUpdateInterval = Some(spark.conf.get("spark.policies_update_interval").toInt)
} catch {
  case e: NoSuchElementException => {
    updateSelectSignalFile = ""
    updateDoneSignalFile = ""
    policiesUpdateInterval = None
  }
}

// If one of them has a value, then all of them will.
if (updateSelectSignalFile.nonEmpty) {
  // This method will block until it finds the signal file.
  CommonUtils.initExternalCatalogObjAndSendSignal(
    signalFileNameToUpdateSelect = updateSelectSignalFile, 
    signalFileNameThatUpdateIsDone = updateDoneSignalFile, 
    updateInterval = policiesUpdateInterval.getOrElse(0))
}

var expectedOutput: String = ""
try {
  // It throws an exception if there is no value.
  // If it's empty and throws the exception, then initialize the string to empty.
  expectedOutput = spark.conf.get("spark.encoded.expected_output")
} catch {
  case e: NoSuchElementException => expectedOutput = ""
}

var result = false

if (expectException.toBoolean) {
  result = CommonUtils.runCommandWithException(encodedCommandStr = command, encodedExpectedErrorMsg = expectedOutput)
} else {
  if (expectedOutput.nonEmpty) {
    result = CommonUtils.runCommandNoException(encodedCommandStr = command, encodedExpectedOutput = Some(expectedOutput))
  } else {
    result = CommonUtils.runCommandNoException(encodedCommandStr = command)
  }
}

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}

