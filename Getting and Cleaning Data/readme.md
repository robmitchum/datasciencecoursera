run_analysis.r is a script for creating a new tidy dataset of the average mean and standard deviation for the features in the "UCI HAR Dataset" by activity and subject.

1) The script first grabs the three relevant datasets for the Test and Training sets and merges them into one dataTest set and one dataTrain set.

2) It then merges dataTest and dataTrain into one dataset, called mergedData

3) Column names are added to mergedData using the features.txt file, with the addition of "activity" and "subject" columns added in step 1. 

4) The desired columns are extracted by searching for column names that contain the phrases stored in WantedVar, and creating a vector of desired columns with grep.
5) A new data set, data, is created using the wanted vector.

6) Numbers in the activity column are replaced with the corresponding activity names. (There's probably a way to do this substitution in less than six steps, but I couldn't figure it out in time)

7) The data is melted into dataMelt by the activity and subject columns.

8) dcast (from the reshape2 library) is used to calculate the means of the variables for each subject and activity.

9) The subject and activity sets are merged into tidyData