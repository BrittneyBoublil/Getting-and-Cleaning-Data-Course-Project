library(dplyr)

filename <- "FinalProject.zip"

# LOAD IN THE DATA SETS

# checking if data has been downloaded already
if (!file.exists(filename)){
  url_name <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url_name, filename, method="curl")
}  

# checking if folder exists already
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# ORGANIZE DATASETS
features <- read.table('UCI HAR Dataset/features.txt', 
                       col.names = c('n','functions'))
activities <- read.table('UCI HAR Dataset/activity_labels.txt', 
                         col.names = c('code', 'activity'))
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt',
                           col.names = 'subject')
x_test <- read.table('UCI HAR Dataset/test/X_test.txt',
                     col.names = features$functions)
y_test <- read.table('UCI HAR Dataset/test/y_test.txt',
                     col.names = 'code')
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt',
                            col.names = 'subject')
x_train <- read.table('UCI HAR Dataset/train/X_train.txt',
                      col.names = features$functions)
y_train <- read.table('UCI HAR Dataset/train/y_train.txt',
                      col.names = 'code')

# STEP 1: MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_data, x_data, y_data)

# STEP 2: EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD 
# DEVIATION FOR EACH MEASUREMENT
merged_data_tidy <- merged_data %>% select(subject, code, 
                                           contains('mean'),
                                           contains('std'))

# STEP 3: USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE 
# DATA SET
merged_data_tidy$code <- activities[merged_data_tidy$code, 2]

# STEP 4: APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE 
# NAMES
names(merged_data_tidy)[1] = 'Subject'
names(merged_data_tidy)[2] = 'Activity'
names(merged_data_tidy)<-gsub('Acc', 'Accelerometer', 
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('Gyro', 'Gyroscope',
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('BodyBody', 'Body',
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('Mag', 'Magnitude',
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('^t', 'Time', 
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('^f', 'Frequency',
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('tBody', 'TimeBody', 
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('-mean()', 'Mean', 
                              names(merged_data_tidy),
                              ignore.case = TRUE)
names(merged_data_tidy)<-gsub('-std()', 'STD', 
                              names(merged_data_tidy),
                              ignore.case = TRUE)
names(merged_data_tidy)<-gsub('-freq()', 'Frequency', 
                              names(merged_data_tidy), 
                              ignore.case = TRUE)
names(merged_data_tidy)<-gsub('angle', 'Angle', 
                              names(merged_data_tidy))
names(merged_data_tidy)<-gsub('gravity', 'Gravity', 
                              names(merged_data_tidy))


# STEP 5: FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT
# TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY
# AND EACH SUBJECT
TidyData <- merged_data_tidy %>%
  group_by(Subject, Activity) %>%
  summarize_all(funs(mean))
write.table(TidyData, 'TidyData.txt', row.name = FALSE)
