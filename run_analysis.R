# Homework 4

# Requires dplyr
# library(dplyr)

# Read the Training Data
trainingMeasurements <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingActivities   <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSubjects     <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read the Test Data
testMeasurements <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivities   <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects     <- read.table("UCI HAR Dataset/test/subject_test.txt")

# STEP1: Merges the training and the test sets to create one data set.
# First created a training set
# By concatenating the activity and measurement to the trainging subject 
trainingDataSet <- trainingSubjects
trainingDataSet <- cbind(trainingDataSet, trainingActivities)
trainingDataSet <- cbind(trainingDataSet, trainingMeasurements)

# Second do the same the test subjects
testDataSet <- testSubjects
testDataSet <- cbind(testDataSet, testActivities)
testDataSet <- cbind(testDataSet, testMeasurements)

# Merge the Trainging and Test data sets
mergedDataSet <- rbind( trainingDataSet, testDataSet)

# STEP2: Extracts only the measurements on the mean and standard deviation
#        for each measurement. 
# Read the list of features
theMeasurements <- read.table("UCI HAR Dataset/features.txt",
		               col.names = c('id', 'measurementName'))
theMeasurementsList <- as.vector( t( theMeasurements$measurementName ) )

# Append the column names to the mergedDataSet
# Columns will have: subject, activity, and 561 feature measurements
theMeasurementsList <- c("subject", "activity", theMeasurementsList)
colnames(mergedDataSet) <- theMeasurementsList
   
# List of measurement that is a mean or std deviation
# Columns will have: subject, activity, and feature measurements that contain -std or -mean
theMeasurementsList <- grepl( pattern = "-std|-mean|subject|activity", theMeasurementsList)
extractedDataSet <- mergedDataSet[,theMeasurementsList]

# STEP3: Uses descriptive activity names to name the activities in the data set
# Read the list of activities
activitiesTable <- read.table("UCI HAR Dataset/activity_labels.txt")
activitiesList <- activitiesTable[,2]
# Replace activity number with activity name
extractedDataSet$activity <- activitiesList[extractedDataSet$activity]

# STEP4: Appropriately labels the data set with descriptive variable names.
# Column names were labeled in step2 using the descriptive names provided in features.txt

# STEP5: From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
# Group subject and activity on extractedDataSet and apply mean to subsets
tidyDataSet <- aggregate(formula=. ~subject + activity, data=extractedDataSet, FUN=mean)
write.table(tidyDataSet, file = "tidydata.txt", row.names = FALSE)

