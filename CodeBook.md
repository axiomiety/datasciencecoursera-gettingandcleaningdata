# Code book

The aim of this document is to describe the raw data and the transformations applied to generate the resulting `tidy_data.txt` set according to the tidy data principles.

## Raw Data

Taken from the data set's README:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Once extract, the data has following structure:

 * `test/` - stores the test data
 * `train/` - stores the training data
 * `activity_labels.txt` - maps the numerical representation of each activity to an activity type
 * `features.txt` - column headers for the `X_train` and `X_test` data set
 * `features_info.txt` - details about features

### Variables

The below is taken from `features_info.txt`.

he features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 * tBodyAcc-XYZ
 * tGravityAcc-XYZ
 * tBodyAccJerk-XYZ
 * tBodyGyro-XYZ
 * tBodyGyroJerk-XYZ
 * tBodyAccMag
 * tGravityAccMag
 * tBodyAccJerkMag
 * tBodyGyroMag
 * tBodyGyroJerkMag
 * fBodyAcc-XYZ
 * fBodyAccJerk-XYZ
 * fBodyGyro-XYZ
 * fBodyAccMag
 * fBodyAccJerkMag
 * fBodyGyroMag
 * fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

 * mean(): Mean value
 * std(): Standard deviation
 * mad(): Median absolute deviation 
 * max(): Largest value in array
 * min(): Smallest value in array
 * sma(): Signal magnitude area
 * energy(): Energy measure. Sum of the squares divided by the number of values. 
 * iqr(): Interquartile range 
 * entropy(): Signal entropy
 * arCoeff(): Autorregresion coefficients with Burg order equal to 4
 * correlation(): correlation coefficient between two signals
 * maxInds(): index of the frequency component with largest magnitude
 * meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 * skewness(): skewness of the frequency domain signal 
 * kurtosis(): kurtosis of the frequency domain signal 
 * bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
 * angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

 * gravityMean
 * tBodyAccMean
 * tBodyAccJerkMean
 * tBodyGyroMean
 * tBodyGyroJerkMean


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

The output is stored as `tidy_data.txt` in the current working directory.
