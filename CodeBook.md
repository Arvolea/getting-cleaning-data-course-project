# CodeBook - Getting Cleaning Data Course Project

The purpose of this Code book is describe the variables, data and any transformations or work that I performed to clean up the data during this course project.

# Data source

Data of project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Dataset description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Set Information 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

# Data - Details

The dataset includes:

1. 'README.txt' file
2. 'features_info.txt': information about the variables used on the feature vector.
3. 'features.txt': list of all features.
4. 'activity_labels.txt': links the class labels with their activity name.
5. 'train/X_train.txt': training set.
6. 'train/y_train.txt': training labels.
7. 'test/X_test.txt': Test set.
8. 'test/y_test.txt': Test labels.

The following files are available for the training and test data. 

1. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
2. 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
3. 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
4. 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Variables

1. x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
2. x_data, y_data and subject_data merge the previous datasets to further analysis.
3. features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
4. A similar approach is taken with activity names through the activities variable.
5. all_data merges x_data, y_data and subject_data in a big dataset.
6. Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.


# Transformations 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Script run_analysis.R - details:

The script run_analysis.R performs the 5 steps described in the course project's definition.

1. All the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
2. Only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
3. As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
4. On the whole dataset, those columns with vague column names are corrected.
5. Generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

# Requiriments

1. Libraries: reshapre2 and data.table.

