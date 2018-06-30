# Code book

The aim of this document is to describe the raw data and the transformations applied to generate the resulting `tidy_data.csv` set according to the tidy data principles.

## Raw Data

Taken from the data set's README:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Once extract, the data has following structure:

 * `test/` - stores the test data
 * `train/` - stores the training data
 * `activity_labels.txt` - maps the numerical representation of each activity to an activity type
 * `features.txt` - column headers for the `X_train` and `X_test` data set
 * `features_info.txt` - details about features

## Transformations

The transformations are defined by 5 distinct and ordered steps.

### 1. Merges the training and the test sets to create one data set.

The data is devided into 3 sections:

 * X - features derived from sensors
 * subject - defines which rows belong to which subject
 * y - the (observed) activity

And split into a training and testing set, for a total of 6 sets. We start by respectively merging the sets to end up with 3 - so one full `X` set, one full `subject` set and one full `y` set.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Following on from step 1 we apply the features labels (from `features.txt` described above) to the `X` data set. We then filter the labels so as to only retain those that directly contain `mean()` or `std()`. All other features are ignored.

### 3. Uses descriptive activity names to name the activities in the data set

We transform the `y` data set from numeric values to their corresponding textual represenation. For instance `1` is mapped to `WALKING` etc...

### 4. Appropriately labels the data set with descriptive variable names.

This step standardises the features labels on the `X` data set. Abbreviations such as `Acc` are expanded into their full names (`Acceleration`), hyphens are removed, ...

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

We start by concatenating the `subject`, `X` and `y` data set to give us a data table that links each subject to a set of measurements and corresponding activity.

We then take the mean of all the measurements.

### Saving the resulting data

The output is stored as `tidy_data.csv` in the current working directory.
