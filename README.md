# GettingAndCleaningDataProject

## Course Project Requirements

You will be required to submit: 

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Purpose of this README.md file

This file is intended to explain how the scripts in this repo work together.

* CodeBook.md describes the variables and the data. The transformations performed to clean the data are in the `run_analysis.R` script.
* run_analysis.R is the final script required for the project.
* Data provided by Coursera for this project can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  * It was already on my desktop when writing `run_analysis.R`.
