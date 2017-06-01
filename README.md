---
title: "README.md"
author: "Hailu Teju"
date: "June 1, 2017"
output:
  pdf_document: default
  html_document: default
---


### The data for the project

The data for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data as well 
as the data set itself are available here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

### R script and analysis files
The accompanied R script performs the following tasks to produce the indicated data files.

* It reads the ```features.txt ``` and ```X_test.txt``` files in the original data sets into the files ```features``` and  ```xTest,``` 
respectively. Then it names the variables in the ```xTest```data frame appropriately using: ```names(xTest) <- features$V2.``` 

* Among the 561 variables (types of measurements of ```acceleration - and its components in the 3D space, angular velocity, etc,```
including their corresponding ```mean``` and ```standard deviation, ``` among other things), the R script extracts only the ones 
on the mean and standard deviation using a sequence of R scripts: ```logik <- grepl("mean", features$V2) | grepl("std", features$V2)``` 
followed by ```xTest <- xTest[,logik]. ```

* It reads the ```subject_test.txt``` file into the file named ```subjTest,``` and the ```y_test.txt``` file into ```yTest.```
```subjTest``` consists of the 30 volunteers, who participated in the experiment by performing six different activities and these 30
subjects are coded using numbers 1 through 30. 

* ```yTest``` consists of the six different activities: ```Walking, Walking_upstairs, Walking_downstairs, Sitting, Standing, & Laying,``` 
which are coded using numbers 1 through 6.

* After it creates the files```subjTest & yTest,``` the R script appropriately names these data frames using descriptive names:
```names(subjTest) <- "Subject"``` and ```names(yTest) <- "Activity".```

* Then it assigns the actual activity names to the corresponding values of the ```yTest``` data frame using: 
```yTest[yTest == 1] <- "Walking"; ```
```yTest[yTest == 2] <- "WalkingUpStairs";```
```yTest[yTest == 3] <- "WalkingDownStairs";```
```yTest[yTest == 4] <- "Sitting";```
```yTest[yTest == 5] <- "Standing";```
```yTest[yTest == 6] <- "Laying". ```

* The R script then merges the Activity, Subject, and measurements data using the ```cbind()``` function to obtain the new data frame: 
```xysTestData <- cbind(subjTest, yTest, xTest).```

* It carries out similar transformations on all of the corresponding ```train``` data sets to eventually get the ```xysTrainData,``` that has 
exactly the same variables in the same order as the ```xysTestData.```

* Then it merges the ```xysTestData``` and ```xysTrainData``` data frames using the ```rbind()``` function to obtain a new larger data
called ```TestTrainData.``` 

* Finally, a tidy data set with the average of each variable for each activity and each subject is created using the 
```aggregate()``` function: ```aggregate(.~ Activity + Subject, TestTrainData, mean, na.action=na.pass,na.rm=TRUE).```