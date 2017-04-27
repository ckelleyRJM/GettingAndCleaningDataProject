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
featuresLimited.names <- features[featuresLimited,2]
featuresLimited.names = gsub('-std', 'Std', featuresLimited.names)
featuresLimited.names = gsub('-mean', 'Mean', featuresLimited.names)
featuresLimited.names <- gsub('[-()]', '', featuresLimited.names)


# Read in training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")


# Read in test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")


# Concatenate the training data
train <- cbind(subject_train, x_train, y_train)


# Concatenate the test data
test <- cbind(subject_test, x_test, y_test)


# Combine training and test data; add labels
complete_data <- rbind(train, test)
colnames(complete_data) <- c("subject", "activity", featuresLimited.names)


# Convert to factors, which is proper for this data set
complete_data$activity <- factor(complete_data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
complete_data$subject <- as.factor(complete_data$subject)

complete_data.melted <- melt(complete_data, id = c("subject", "activity"))
complete_data.mean <- dcast(complete_data.melted, subject + activity ~ variable, mean)

write.table(complete_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
