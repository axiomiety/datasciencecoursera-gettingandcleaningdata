#
# This script can be used to download the UCI HAR Dataset
# and perform some ruidmentary data clean-up and streamlining.
#
# The resulting data will be stored in tidy_data.csv
# 
# No user input is required but if you want to change the location
# of where scratch files and the output are created, update the `init`
# function

###
# we first define the functions that will perform the transformation steps
###

# this function is responsible for downloading and extracting the data
init <- function() {
  # uncomment the below with your preferred location
  setwd("c:/shared/datasciencecoursera-gettingandcleaningdata/")
  dirname = "scratch"
  if (!dir.exists(dirname)) {dir.create(dirname)}
  fname <- "data.zip"
  setwd(dirname)
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  if (!file.exists(fname)) {
    download.file(url, fname, mode="wb")
    unzip(fname)
  }
}

# loads the raw training and testing data
# adds xtrain, ytrain, xtest, ytest to the given environment
loadData <- function(e) {
  fname_xtrain = "UCI HAR Dataset/train/X_train.txt"
  fname_ytrain = "UCI HAR Dataset/train/y_train.txt"
  fname_subtrain = "UCI HAR Dataset/train/subject_train.txt"
  fname_xtest = "UCI HAR Dataset/test/X_test.txt"
  fname_ytest = "UCI HAR Dataset/test/y_test.txt"
  fname_subtest = "UCI HAR Dataset/test/subject_test.txt"
  
  e$xtrain <- fread(fname_xtrain)
  e$ytrain <- fread(fname_ytrain)
  e$subtrain <- fread(fname_subtrain, col.names = c("subject"))
  e$xtest <- fread(fname_xtest)
  e$ytest <- fread(fname_ytest)
  e$subtest <- fread(fname_subtest, col.names = c("subject"))
}

# merges the training and testing data - note we're keeping x and y separate for now
mergeData <- function(e) {
  e$x <- rbind(e$xtrain, e$xtest)
  e$y <- rbind(e$ytrain, e$ytest)
  e$subject <- rbind(e$subtrain, e$subtest)
}

# we only want a subset of the measurements
extractMeasurements <- function(e) {
  measurement_labels <- fread("UCI HAR Dataset/features.txt", col.names = c("code","name"))
  names(e$x) <- measurement_labels$name
  # only measurements with mean() and std() and their names are included, excluding the likes of meanFreq()
  columns_of_interest <- grep('mean\\(\\)|std\\(\\)', measurement_labels$name)
  e$data <- e$x[,..columns_of_interest] # this is how you reference a variable inside a data.table (vs data.frame)
}

# convert the 1, 2, ... labels into proper activities - such as WALKING
addActivityLabels <- function(e) {
  activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
  m <- inner_join(e$y, activity_labels, by="V1")
  names(m) <- c("activity_code", "activity")
  e$activity <- select(m, activity) # we only care about the activity column
}

# make labels more explicit
cleanUpLabels <- function(e) {
  coln <- names(e$data)
  # change t and f prefixes to time and frequency respectively
  coln <- sub('^f([A-Z])', 'frequency\\1', coln)
  coln <- sub('^t([A-Z]{1})', 'time\\1', coln)
  # misc clean-up
  coln <- gsub('Acc', 'Acceleration', coln)
  coln <- gsub('Mag', 'Magnitude', coln)
  coln <- gsub('BodyBody','Body', coln)
  coln <- gsub('-mean', 'Mean', coln)
  coln <- gsub('-std', 'Std', coln)
  # replace mean()-X with meanX etc...
  coln <- gsub('\\(\\)-([X|Y|Z])$', '\\1', coln) 
  # remove ending parenthesis
  coln <- gsub('\\(\\)$', '', coln)
  # update our dataset with the more verbose column names
  names(e$data) <- coln
}

# groups the dataset by subject and activity, and compute the average of each variable
groupData <- function(e) {
  # we first concatenate all our data into one data set
  d <- cbind(e$subject, e$data, e$activity)
  e$tidy_data <- d %>%
                 group_by(activity, subject) %>%
                 summarise_all(mean)
}

###
# main routine starts here
##

library(data.table)
library(dplyr)

# we're storing our data in a separate environment so as not to pollute the existing workspace
# we first check whether we have one defined so we don't override it and start from scratch
if (!('e' %in% ls(globalenv()))) {
  genv = globalenv()
  genv$e = new.env()
}

# 0. Start by download the data if it isn't present and loading it in a new environment
init()
loadData(e)

# 1. Merge the training and the test sets to create one data set
mergeData(e)
# 2. Extract only the measurements on the mean and standard deviation for each measurement
extractMeasurements(e)
# 3. Use descriptive activity names to name the activities in the data set
addActivityLabels(e)
# 4. Appropriately label the data set with descriptive variable names
cleanUpLabels(e)
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
groupData(e)
# write the data out
write.table(e$tidy_data, file = "tidy_data.txt", row.names=FALSE)