library(dplyr)

run_analysis <- function(){
        
        features <- read.table("./data/UCI HAR Dataset/features.txt")
        features$V2 <- as.character(features$V2)

        logik1 <- grepl("mean", features$V2)
        logik2 <- grepl("std", features$V2)
        logik <- logik1 | logik2
      
        xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
        names(xTest) <- features$V2
        xTest <- xTest[ ,logik]   #extracts only the measures on the mean and std

        yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

        yTest[yTest == 1] <- "Walking"
        yTest[yTest == 2] <- "WalkingUpStairs"
        yTest[yTest == 3] <- "WalkingDownStairs"
        yTest[yTest == 4] <- "Sitting"
        yTest[yTest == 5] <- "Standing"
        yTest[yTest == 6] <- "Laying"

        names(yTest) <- "Activity"

        subjTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
        names(subjTest) <- "Subject"

     
        xysTestData <- cbind(subjTest, yTest, xTest)

        xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
        names(xTrain) <- features$V2
        xTrain <- xTrain[ ,logik]   #extracts only the measures on the mean and std

        yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

        yTrain[yTrain == 1] <- "Walking"
        yTrain[yTrain == 2] <- "WalkingUpStairs"
        yTrain[yTrain == 3] <- "WalkingDownStairs"
        yTrain[yTrain == 4] <- "Sitting"
        yTrain[yTrain == 5] <- "Standing"
        yTrain[yTrain == 6] <- "Laying"

        names(yTrain) <- "Activity"

        subjTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
        names(subjTrain) <- "Subject"


        xysTrainData <- cbind(subjTrain, yTrain, xTrain)

        TestTrainData <- rbind(xysTestData, xysTrainData)
       # print(dim(TestTrainData))
        
        tidyData <- aggregate(.~ Activity + Subject, TestTrainData, mean, na.action=na.pass, na.rm=TRUE)
        
        write.table(tidyData, "tidyData.txt", sep="\t", row.names=FALSE)
        
}
