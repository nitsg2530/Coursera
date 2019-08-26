##run_analysis.R

#Downloading the zipfile and extracting it into the working directory 

fileName <- "UCIMLdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb")
}

# If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
  unzip(fileName, files = NULL, exdir=".")
}


# The file extract has bunch of txt files, need to extract out the data 
# I am using read.table() function it would reads a txt file into data frame in table format.

# Which table file to read ? I am goint toread all for now except readme and features.txt
# code improvements can be done to catche the tables and optimise the below read operation


activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")






# Task 1 - Merges the training and the test sets to create one data set.
gross_dataset <- rbind(X_train,X_test)

# Task 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

MeanStdOnly <- grep("mean()|std()", features[, 2]) 
gross_dataset <- gross_dataset[,MeanStdOnly]


# Task 4- Appropriately labels the data set with descriptive activity names.
# Create vector of "Clean" feature names by getting rid of "()" apply to the dataSet to rename labels.
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(gross_dataset) <- CleanFeatureNames[MeanStdOnly]

# combine test and train of subject data and activity data, give descriptive lables
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'

# combine subject, activity, and mean and std only data set to create final data set.
gross_dataset <- cbind(subject,activity, gross_dataset)


# Task 3- Uses descriptive activity names to name the activities in the data set
# group the activity column of gross_dataset, re-name lable of levels with activity_levels, and apply it to gross_dataset
act_group <- factor(gross_dataset$activity)
levels(act_group) <- activity_labels[,2]
gross_dataset$activity <- act_group


# Task 5- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")

# melt data to tall skinny data and cast means. Finally write the tidy data to the working directory as "tidy_data.txt"
baseData <- melt(gross_dataset,(id.vars=c("subject","activity")))
secondDataSet <- dcast(baseData, subject + activity ~ variable, mean)
names(secondDataSet)[-c(1:2)] <- paste("[mean of]" , names(secondDataSet)[-c(1:2)] )
write.table(secondDataSet, "tidy_data.txt", sep = ",")
