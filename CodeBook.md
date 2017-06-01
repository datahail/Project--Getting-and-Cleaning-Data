---
title: "CodeBook.md"
author: "Hailu Teju"
date: "May 28, 2017"
output:
  pdf_document: default
  html_document: default
---


### The data for the project

The data for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data as well 
as the data set itself are available here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

### Derived data set
* ```features``` - a data frame consisting of the 561 measured variables in the original data set. It is obtained from the ```features.txt``` file 
in the original data set.

* ```xTest``` - a data frame that consists of 2947 observations and 79 of the 561 variables (measurements) mentioned above. This data frame is 
derived from the ```X_test.txt``` data in the original data set.

* ```yTest``` - is obtained from the ```y_test.txt``` file in the original data set that consists of multiple instances of the six 
activities coded using numbers 1 through 6. It has 2947 observations and one variable.

* ```subjTest``` - a data frame with 2947 observations and one variable, and it is obtained from the ```subject_test.txt``` in the original 
data set. It consists of multiple instances of the codes for the 30 subjects that participated in the experiment. 

* ```xysTest``` - is a data frame with 2947 observations and 81 variables obtained by merging ```yTest, subjTest & xTest``` column-wise.

* ```xTrain, yTrain, subjTrain``` - are similarly obtained from their corresponding data in the ```train``` data set in the original data source.
They all 7352 observations and the same number of variables as their corresponding counterparts above that were obtained from the ```test```
data set. These three data frames are also merged column-wise to obtain the ```xysTrainData``` data frame that has 7352 observations and the 
same 81 variables as ```xysTestData``` in the same order.

* ```TestTrainData``` - is a data frame with 10299 observations and 81 variables that is obtained by merging the ```xysTestData```
and the ```xysTrainData``` row-wise.

### Transformation of the data and analysis
* The ```features.txt ``` file consists of all the 561 measurements that were calculated for the data set. 
After the ```features.txt``` file and the ```X_test.txt``` data are read using R scripts, the measurement types in ```features``` are assigned 
to the ```xTest``` data frame as variable names: ```names(xTest) <- features$V2,```  where 
```features & xTest``` represent the names assigned to the  ```features.txt & X_test.txt ``` data sets, 
respectively, when they are read using R scripts.

* Among all the 561 variables in this data set, only the ones on the mean and standard deviation are extracted using a sequence of 
R scripts: ```logik <- grepl("mean", features$V2) | grepl("std", features$V2)``` followed by ```xTest <- xTest[,logik]. ```

* The ```subject_test.txt``` file consists of the 30 volunteers who participated in the experiment by performing six different
activities ```Walking, Walking_upstairs, Walking_downstairs, Sitting, Standing, & Laying.``` The 30 subjects are coded using numbers
1 through 30 and the six activities are coded using numbers 1 through 6. The ```y_test.txt``` file consists of these activities.
After they are read as ```subjTest & yTest,``` respectively, these data frames are named using descriptive names:
```names(subjTest) <- "Subject"``` and ```names(yTest) <- "Activity".```

* The actual activity names are assigned to the corresponding values of the ```yTest``` data frame using: 
```yTest[yTest == 1] <- "Walking"; ```
```yTest[yTest == 2] <- "WalkingUpStairs";```
```yTest[yTest == 3] <- "WalkingDownStairs";```
```yTest[yTest == 4] <- "Sitting";```
```yTest[yTest == 5] <- "Standing";```
```yTest[yTest == 6] <- "Laying". ```

* The activity, subject, and measurements data are merged together using the ```cbind()``` function: 
```xysTestData <- cbind(subjTest, yTest, xTest).```

* Similar transformations are carried out on all of the corresponding ```train``` data sets to get the ```xysTrainData,``` that has 
exactly the same variables.

* The ```xysTestData``` and the ```xysTrainData``` are merged together using the ```rbind()``` function to obtain a new larger data
called ```TestTrainData.``` 

* Finally, a tidy data set with the average of each variable for each activity and each subject is created using the 
```aggregate()``` function: ```aggregate(.~ Activity + Subject, TestTrainData, mean, na.action=na.pass,na.rm=TRUE).```