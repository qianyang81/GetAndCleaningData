# Cousera Course - Getting And Cleaning Data - Course Project

## How to use "run_analysis.R" script to get tidy data set.
1. Download data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the file and it creates a folder "UCI HAR Dataset" by default
3. Run run_analysis.R:
   * source("run_analysis.R")
   * getandcleandata() or getandcleandata(path_dataset, outfile)
   * It takes 2 parameters: 
      * path to the data set (default: UCI HAR Dataset)
      * name of the output file (default: tidyData.txt)
4. The tidy data set is generated in your working directory.

## "run_analysis.R" does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
