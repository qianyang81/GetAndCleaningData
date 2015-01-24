getandcleandata<-function(directory="UCI HAR Dataset", outfile="tidyData.txt"){

  # set the file names with "path name/file name"
  trainXFile <- paste(directory, "train/X_train.txt", sep="/")
  trainYFile <- paste(directory, "train/Y_train.txt", sep="/")
  trainSubFile <- paste(directory, "train/subject_train.txt", sep="/")
  testXFile <- paste(directory, "test/X_test.txt", sep="/")
  testYFile <- paste(directory, "test/Y_test.txt", sep="/")
  testSubFile <- paste(directory, "test/subject_test.txt", sep="/")
  labelFile <- paste(directory, "activity_labels.txt", sep="/")
  featureFile <- paste(directory, "features.txt", sep="/")
  
  # read the feature file and extract feature names
  features <- read.table(featureFile, sep=" ")
  features <- as.vector(features[,2])  
   
  # read activity labels file
  labels <- read.table(labelFile, col.names=c("activityID","activityName"), colClasses=rep("factor",2))

  # read train set, train label and subject files
  trainX <- read.table(trainXFile, header=FALSE)
  trainY <- read.table(trainYFile, col.names=c("activityID"), colClasses="factor")
  trainSub <- read.table(trainSubFile, col.names=c("subjectID"), colClasses="factor")
  
  # read test set, test label and subject files
  testX <- read.table(testXFile, header=FALSE)
  testY <- read.table(testYFile,col.names=c("activityID"), colClasses="factor")
  testSub <- read.table(testSubFile, col.names=c("subjectID"), colClasses="factor")
     
  # merge both train and test set into one table (STEP 1)
  allX <- rbind(trainX, testX)
  allY <- rbind(trainY, testY)
  allSub <- rbind(trainSub, testSub)  
  
  # fix the variable names
  features <- gsub("()", "", features, fixed=TRUE)
  features <- gsub("-", "_", features, fixed=TRUE)
  
  # label the data set with descriptive variable names (STEP 4)
  names(allX) <- features 
  
  # extracts only the measurements on the mean and standard deviation for each measurement (STEP 2)
  subX <- allX[,grep("std|mean",names(allX))]
  
  # column bind data, labels and subjects
  allData <- cbind(subX, allY, allSub)
     
  # name the activities with descriptive activity names (STEP 3)
  allData <- merge(allData, labels, all.x=TRUE)    

  # get the tidy data set (STEP 5)
  library(reshape2)
  varList <- names(subX)
  allDataMelt <- melt(allData, id=c("subjectID","activityName"), measure.vars=varList)
  allDataSummary <- dcast(allDataMelt, subjectID+activityName ~ variable, mean)
   
  # write the data summary to a text file with name outfile (default value is "tidyData.txt")
  write.table(allDataSummary, file=outfile, row.names=FALSE)
}