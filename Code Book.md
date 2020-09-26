Code Book for Peer-Graded Project
Author: Brittney Boublil
Date: September 26, 2020

# Project Description: 
The run_analysis.R script loads and prepares the data, followed by additional steps for analysis as described in the peer-graded course project prompt. 

# Step 1:
Loads in and unzips data into a folder called "UCI HAR Dataset"

# Step 2: 
Organizes the data into respective their respective variables 

- features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. More information can be found in 'features_info.txt', with the complete list of variables of each feature vector in 'features.txt'.

- activities <- activity_labels.txt : 6 rows, 2 columns
Links the class labels with their activity name.

- subject_test <- test/subject_test.txt : 2947 rows, 1 column
Contains test data of 9/30 subjects.

- x_test <- test/X_test.txt : 2947 rows, 561 columns
Contains recorded test data

- y_test <- test/y_test.txt : 2947 rows, 1 columns
Contains activity codes for respective test data

- subject_train <- test/subject_train.txt : 7352 rows, 1 column
Contains train data of 21/30 subjects. 

- x_train <- test/X_train.txt : 7352 rows, 561 columns
Contains recorded train data

- y_train <- test/y_train.txt : 7352 rows, 1 columns
Contains activity codes for respective train data

# Step 3:
Merges the training and testing data sets to create one data set

- x_data (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
- y_data (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
- subject_data (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
- merged_data (10299 rows, 563 column) is created by merging subject_data, x_data, and y_data using cbind() function

# Step 4:
Extracts only the measurements on the mean and standard deviation for each measurement in the data set

- merged_data_tidy (10299 rows, 88 columns) is created by subsetting merged_data, selecting only the subject and code columns, as well as the measurements on the mean and standard deviation (std) for each measurement

# Step 5:
Uses descriptive activity names from the activities variable to rename the activities column in the merged_data_tidy

# Step 6: 
Appropriately labels the data set with descriptive variable names

- subject column in merged_data_tidy renamed to 'Subject'
- code column in merged_data_tidy renamed to 'Activities'
- Using gsub, variables were renamed as the following:
  - All instances of 'Acc' in column names were replaced by 'Accelerometer'
  - All instances of 'Gyro' in column names were replaced by 'Gyroscope'
  - All instances of 'BodyBody' in column names were replaced by 'Body'
  - All instances of 'Mag' in column names were replaced by 'Magnitude'
  - All instances where a column name started with character 'f' were replaced by 'Frequency'
  - All instances where a column name started with character 't' were replaced by 'Time'
  - All instances of 'mean' and 'std' were replaced with 'Mean' and 'STD', respectively 
  - All instances of 'angle' in column names were replaced by 'Angle'
  - All instacnes of 'gravitiy' in column names were replaced by 'Gravity'

# Step 7:
Using the data set from step #6, creates a second, independent tidy data det with the average of each variable for each activity and each subject 

- TidyData (180 rows, 88 columns) is created by summarizing merged_tidy_data and grouping by subject and activity. Next, the means of each variable for each activity and each subject are calculated. TidyData is then exported into a 'TidyData.txt' file. 

