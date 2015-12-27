About
=====

+ This repo contains the course project for the Getting and Cleaning Data Course.

+ The course project involve creating a tidy data set based on the data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .


Contents:
=========
+ README.md : This file containing description of the analysis. 
+ run_analysis.R : R source code for creating a tidy data set.
+ CodeBook.md : The codebook describing the tidy data set.
+ tidydata.txt : The resulting file from run_analysis.R


Analysis
========

The run_analysis.R code peforms the following steps to obtain a tidy data set.
Code was developed on R version 3.2.3 on Linux (Ubuntu 14.04).

1. Merges the training and the test sets to create one data set.
----------------------------------------------------------------
The file expects the above UCI HAR Dataset.zip file to be unzip into the R working directory.
Script creates a training data set and a test data set.
A single merged data set is created using rbind on the training and test data sets.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
------------------------------------------------------------------------------------------
The merged data set from step 1 has the subject, activity, and 561 feature measurements as columns.
To extract the columns with mean and standard deviation, a grep is done on the column names.
Columns containing the text '-mean' and '-std' are kept along with first 2 columns (subject and activity).

3. Uses descriptive activity names to name the activities in the data set
--------------------------------------------------------------------------
The activity_labels.txt file contains the activity names.
To get the desciptive activity names into the data set, the activity label are read into a list and the activity name is used to index the list.

4. Appropriately labels the data set with descriptive variable names.
---------------------------------------------------------------------
The descriptive column names come from features.txt. A vector of column names is created by reading the table and transposing the second column.
The column names vector is used to assign the columns of the merged data set.
For convenience, this was done as part of step 2. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-------------------------------------------------------------------------------------------------------------------------------------------------
To create and average for each subject and activity, aggregate function was used. The formula passed to aggregate function specified the grouping activity by subject, and the mean is applied to the subsets.


