library(data.table)
library(dplyr)

setwd("C:/Users/Lalaine/Downloads/Module 3/UCI HAR Dataset")
FeatureNames <- read.table(file = "features.txt")
ActivityLabels <- read.table(file = "activity_labels.txt")

#loads the training data set
train_subject <- read.table(file = "train/subject_train.txt")
train_activity <- read.table(file = "train/y_train.txt")
train_features <- read.table(file = "train/X_train.txt")
 
#loads the testing data set
test_subject <- read.table(file = "test/subject_test.txt")
test_activity <- read.table(file = "test/y_test.txt")
test_features <- read.table(file = "test/X_test.txt")
 
 
#merges training and test data set to create one data set
Subject <- rbind(train_subject,test_subject)
Activity <- rbind(train_activity,test_activity)
Features <- rbind(train_features,test_features)
 
#names the columns 
colnames(Features) <- t(FeatureNames[2])
colnames(Activity) <- "ActivityID"
colnames(Subject) <- "SubjectID"
 
#creates a combined data frame
CompleteData 	<- cbind(Features,Activity,Subject)
 
#means and standard deviations
colMeanStd <- grep(".*Mean.*|.*Std.*",x = names(CompleteData), ignore.case=TRUE)
filteredCols <- c(colMeanStd,562:563)
pulledData <- CompleteData[,filteredCols]
 
pulledData$Activity <- as.character(pulledData$Activity)
for(i in 1:6) {
  pulledData$Activity[pulledData$Activity == i] <- as.character(ActivityLabels[,2])
}
pulledData$Activity <- as.factor(pulledData$Activity)
 
#with descriptive variable names
names(pulledData)<-gsub("Acc", "Accelerometer", names(pulledData))
names(pulledData)<-gsub("Gyro", "Gyroscope", names(pulledData))
names(pulledData)<-gsub("BodyBody", "Body", names(pulledData))
names(pulledData)<-gsub("Mag", "Magnitude", names(pulledData))
names(pulledData)<-gsub("^t", "Time", names(pulledData))
names(pulledData)<-gsub("^f", "Frequency", names(pulledData))
names(pulledData)<-gsub("tBody", "TimeBody", names(pulledData))
names(pulledData)<-gsub("-mean()", "Mean", names(pulledData), ignore.case = TRUE)
names(pulledData)<-gsub("-std()", "STD", names(pulledData), ignore.case = TRUE)
names(pulledData)<-gsub("-freq()", "Frequency", names(pulledData), ignore.case = TRUE)
names(pulledData)<-gsub("angle", "Angle", names(pulledData))
names(pulledData)<-gsub("gravity", "Gravity", names(pulledData))
 
pulledData$Subject <- as.factor(pulledData$Subject)
pulledData <- data.table(pulledData)
 
finaldata <- aggregate(. ~Subject+Activity,pulledData,mean) 
finaldata <- finaldata[order(finaldata$Subject,tidydata$Activity),]
write.table(x = finaldata,file = "tidy.txt",row.names = FALSE)
