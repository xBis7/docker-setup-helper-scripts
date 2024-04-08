When running Spark tests, it is important not to be connected to Spark shell. 

Otherwise, warning such as: `24/04/05 10:15:16 WARN TaskSchedulerImpl: Initial job has not accepted any resources; check your cluster UI to ensure that workers are registered and have sufficient resources` might occur and test will slip into infinite loop until Spark shell is disconnected from.