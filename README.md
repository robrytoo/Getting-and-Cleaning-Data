# Course Project - Getting and Cleaning Data

This project downloads data from the UCI Machine Learning Repository, assembles the data into a data frame, extracts a subset of the features from the dataset, and calculates an average of the extracted feature for each activity for each subject.  A complete description of the input data and output variables is in **CodeBook.md**.

The R script **run_analysis.R** accomplishes this in the following steps, detailed below.
- Download data and read data files.
- Assemble data files into a data frame.
- Select a subset of the features in the data frame.
- Sort the selected features by activity and subject and calculate averages.
- Convert activities from numerical categories to meaningful names.
- Write out file with the summary data frame.

## Download data and read data files.
Data is downloaded from the UCI Machine Learning Repository at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and is unzipped into a subdirectory of the working directory.  (The date and time of the download is saved to the file **DataDownloadDate.RData**.  This is followed by reading each of the required data files into the R workspace 

## Assemble data files into a data frame
The original downloaded used for input to the **run_analysis.R** file  consists of eight files that reside in the subdirectory **UCI HAR Dataset** of the working directory.

Feature files
- UCI HAR Dataset/train/X_train.txt  (7352 observations of 561 features)
- UCI HAR Dataset/test/X_test.txt (2947 observations of 561 features)

These features are normalized measurements in the time and frequency domain derived from the raw data collected by the Samsung accelerometers and each observation corresponds to a derived feature for an individual subject engaged in a single activity.  (Raw data that was used to derive these features is in a train or test subdirectory named **Inertial Signals** and is not used in this script.)  See web site for http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for description of how training and testing features were derived.

The files
- UCI HAR Dataset/train/subject_train.txt (7352 coded subjects (categorical values 1 to 30))
- UCI HAR Dataset/test/subject_test.txt (2947 coded subjects (categorical values 1 to 30)) 

indicate the subject who generated the data.  Thirty total subjects participated in data collection and were randomly assigned to training or testing, but not both.  There are 21 subjects in the training set and 9 in the testing set.

The files 
- UCI HAR Dataset/train/y_train.txt (7352 coded activities (categorical values 1 to 6)) 	
- UCI HAR Dataset/test/y_test.txt (2947 coded activities (categorical values 1 to 6))

indicate the activity occurring during each observation.   Given 30 subjects each engaged in six activities there are on average 57 observations of each activity for each subject to give the total of 10299 observations in the two feature files. 

The file 
- UCI HAR Dataset/features.txt 

indicates the name of the 561 feature in training and testing feature files.

The file 
- UCI HAR Dataset/activity_labels.txt 

defines the six categorical coded activities in the y training and testing files. 

## Select a subset of the features in the data frame

All of the 561 features that represent a mean or standard deviation of any of the derived data from the repository are selected.  Total of 86 features columns are selected plus the Activity and SubjectID columns.

## Sort the selected features by activity and subject and calculate averages

The data data frame above is aggregated by SubjectID and activity with the average of each group calculated.  (The Activity and SubjectID are duplicated by this operation so the first two columns are discarded.)

## Convert activities from numerical categories to meaningful names

Activities are changed from a numerical representation to meaningful character names.  The feature names are improved by removing extraneous parenthesis. 

## Write out file with the summary data frame

The final tidy data frame is written to file **AverageFeature.txt** using the prescribed function **write_table** with parameter **row.name** set to FALSE. 
