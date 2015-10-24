# CodeBook 

Introduction

This codebook has three sections.  

* VARIABLES describes the columns in the output file **AverageFeature.txt** that results from running **run_analysis.R** on the data set downloaded from the UCI Machine Learning Repository at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  This zip file should be unzipped in the working director containing the file **run_analysis.R**.

* DATA explains the data from the repository that is used as input to the **run_analysis.R** file.

* TRANSFORMATIONS explains calculations necessary to transform DATA to the VARIABLES



## VARIABLES

The output file **AverageFeature.txt** contains a data frame of 180 rows by 88 columns.  The output file reports the average of the column feature for each subject and activity (180=30*6 rows.)  Only feature columns from the source dataset that represents a mean or standard deviation of a training/testing set variable (i.e. contains the strings *STD* or *mean* (case insensitive)) are selected for evaluation.  There are 86 feature columns, with the addition of the activity and subjectID columns this accounts for the 88 total columns in the outputfile. 

The list of variables is in the header of the file **AverageFeature.txt**.   The variable names are the same as the selected features from the training and testing  dataset (see DATA below) after removal of extra pairs of parentheses.  They values are the average of all observations of a given activity for a given subject.  See the web site for http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and  its README file for a description of the feature variables.

## DATA

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

indicate the activity occurring during each observation.   Given 30 subjects each engaged in six activities there are on average 57 observations of each activity for each subject to give the total of 10299 observations in the two# feature files. 

The file 
- UCI HAR Dataset/features.txt 

indicates the name of the 561 feature in training and testing feature files.

The file 
- UCI HAR Dataset/activity_labels.txt 

defines the six categorical coded activities in the y training and testing files. 

## Transformations
A single data frame was assembled from the DATA files described above combining the training and testing data, labeling the features, and identifying the subject and activity type for the feature vectors.

An 86 feature subset of the 561 input features is selected.  A feature is selected if it represents the mean or standard deviation of any derived  data.  This is determined by inclusion of the case insensitive string of mean or STD in its name.  Selected features were then sorted by subject and activity and the average of that sorted group was calculated.  This resulted in a data frame of 180 rows (30 subjects x 6 activities) and 88 columns ( activity, subject,  and average value for the 86 selected features.)
 
