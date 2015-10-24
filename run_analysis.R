## Getting and Cleaning Data - Course Project
## Required data is from
## "https://d396qusza40orc.cloudfront.net/
##             getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## this program will download the zip file to the working directory and then unzip it
## into a subdirectory of the working directory.
##


###### Download data and read data files  ######
# Source URL
file.url <- 
  'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Data source file
zip.file <- 'Dataset.zip'

# Download zip file if not present
if(!file.exists(zip.file)) {
  download.file(file.url, destfile=zip.file)
  ddd = date()
  save(ddd,file="DataDownloadDate.RData")
}  

# Read unzipped data files.
dataDir = "UCI HAR Dataset"
if(!file.exists(dataDir)) 
  unzip(zip.file, overwrite = TRUE)

# Fuction to read data files
dataIn <- function(fileName) {
  read.table(paste(dataDir, fileName, sep="/"), sep="", header=F)
}

# Read in data files
testFeat = dataIn("test/X_test.txt")
trainFeat = dataIn("train/X_train.txt")
yTest = dataIn("test/y_test.txt")
yTrain = dataIn("train/y_train.txt")
featureNames = dataIn("features.txt")
activityLabels = dataIn("activity_labels.txt")
subjectTest = dataIn("test/subject_test.txt")
subjectTrain = dataIn("train/subject_train.txt")


###### Assemble data files into a data frame  ######
# Combine test/train y values and label column. 
ally <- rbind(yTest,yTrain)
names(ally) <- "Activity"

# Combine test/train subject IDs and label column.
allsubject <- rbind(subjectTest, subjectTrain)
names(allsubject) <- "SubjectID"

# Combine test/train features and label columns
features <- rbind(testFeat, trainFeat)
names(features) <- featureNames$V2

# Assemble data frame
df  <- cbind(ally,allsubject,features)


###### Select a subset of the features in the data frame  ######
# Select features representing means or standard deviations
indMean <- grep("mean", names(df), ignore.case=T)
indSTD <- grep("STD", names(df), ignore.case=T)

# Reestablish original order of to bring selected 
# mean and std columns to adjacent positions
inds <- sort(c(indMean,indSTD))  

# Select Activiy, SubjectID, and selected features and place in a Tidy Data Frame (TDF) 
TDF <- df[,c(1,2,inds)]


######  Sort the selected features by activity and subject and calculate averages  ######
AVES <- aggregate(TDF, by=list(TDF$SubjectID, TDF$Activity), 
                  FUN = mean, na.rm=T)
AVES <- AVES[,3:(dim(AVES)[2])]


###### Convert activities from numerical categories to meaningful names  ######
# Replace activity as a code with a descriptive activity name.
AVES$Activity <- as.factor(AVES$Activity)
levels(AVES$Activity) <- as.character(activityLabels$V2)
# Remove extraneous '()' from column names
names(AVES) <- gsub("()", "", names(AVES), fixed=T)  


######  Write out file with the summary data frame  ######
# Write output of averages from Step 5 of assignment.
write.table(AVES, file = 'AverageFeature.txt', row.name=FALSE)  
