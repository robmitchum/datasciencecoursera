run_analysis <- function() {
  # Prepare data sets for merging
  # Test Data
  testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
  testLabels <- read.table("./UCI HAR Dataset/test/Y_test.txt")
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = " ")
  testData["activity"] <- testLabels[,1]
  testData["subjects"] <- testSubjects[,1]
  # Training Data
  trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
  trainLabels <- read.table("./UCI HAR Dataset/train/Y_train.txt")
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = " ")
  testData["activity"] <- testLabels[,1]
  testData["subjects"] <- testSubjects[,1]
  # Merge data sets
  library(reshape2)
  mergedData <- merge(testData, trainData, all = TRUE)
  # Extracts wanted variables
  featureNames <- read.table("./UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = F)
  featureNames <- rbind(featureNames, c("562", "activity"))
  featureNames <- rbind(featureNames, c("563", "subject"))
  colnames(mergedData) <- featureNames[,2]
  wantedVar <- c("mean", "std", "activity", "subject")
  wanted <- grep(paste(wantedVar,collapse="|"), names(mergedData))
  data <- mergedData[,wanted]
  # Labels activities
  data$activity[data$activity == 1] <- "Walking"
  data$activity[data$activity == 2] <- "Walking Upstairs"
  data$activity[data$activity == 3] <- "Walking Downstairs"
  data$activity[data$activity == 4] <- "Sitting"
  data$activity[data$activity == 5] <- "Standing"
  data$activity[data$activity == 6] <- "Laying"
  # Creates second data set
  dataMelt <- melt(data, id=c("activity", "subject"),)
  activityData <- dcast(dataMelt, activity ~ variable, mean)
  subjectData <- dcast(dataMelt, subject ~ variable, mean)
  tidyData <- merge(activityData, subjectData, all = TRUE)
}