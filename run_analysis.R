## File objectives:

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Begin script

# Load libraries
library(data.table)
library(reshape2)
library(dplyr)

# Establish URL shorthand and fileName shorthand
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "getdata_dataset.zip"

# Download, then unzip file
if (!file.exists(fileName)){
  download.file(URL, fileName, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}


# Read in the features.txt file, which lists the variable features
# Then ensure character data type for columns
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])


# Read in activity file
# Then ensure character data type for columns
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])


# Reduce features to only those with standard deviation or mean in the name
# Reformat names to be cleaner
featuresLimited <- grep(".*std.*|.*mean.*", features[,2])
featuresLimited.names <- features[featuresLimited.names,2]
featuresLimited.names = gsub('-std', 'Std', featuresLimited.names)
featuresLimited.names = gsub('-mean', 'Mean', featuresLimited.names)
featuresLimited.names <- gsub('[-()]', '', featuresLimited.names)


# Read in training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Read in test data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")




##### below is not updated yet! 
##### still working..



## Concatenate the subject data
subject <- rbind(subject_test, subject_train)

## Concatenate the activity data
activity <- rbind(x_test, y_train)

## Concatenate the training data
train <- rbind(x_test, y_train)

## Combine training and test data
complete_data <- rbind(test, train)

## In features table, use regex to simplify to only columns with 'std' or 'mean' in the name
features_mean_std <- grepl("mean\\(\\)|std\\(\\)", features$name)

## Incomplete project
## Next steps are:
# Use features_mean_std to simplify the features table to only columns with mean or std in the name
# Subset the complete_data table to only include objservations matching the features_mean_std row number
# Assign column names from features_mean_stf table to complete_data table
# Output tidy data



