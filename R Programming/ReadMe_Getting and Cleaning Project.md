## Pre Analysis
This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## 1. Read data and Merge

* Read all the data tables except readme and features txt files
* gross_dataset : bind of X_train and X_test

## 2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset gross_dataset.
* MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
* gross_dataset : at the end of this step, gross_dataset will only contain mean and std variables

## 3. Changing Column label of gross_dataset
Create a vector of "clean" feature names by getting rid of "()" at the end. Then, will apply that to the gross_dataset to rename column labels.
* CleanFeatureNames : a vector of "clean" feature names 

## 4. Adding Subject and Activity to the gross_dataset
Combine test data and train data of subject and activity, then give descriptive lables. Finally, bind with gross_dataset. At the end of this step, gross_dataset has 2 additonal columns 'subject' and 'activity' in the left side.
* subject : bind of subject_train and subject_test
* activity : bind of y_train and y_test

## 5. Rename ID to activity name
Group the activity column of gross_dataset as "act_group", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "act_group" to gross_dataset's activity column.
* act_group : factored activity column of gross_dataset 

## 6. Output tidy data
In this part, gross_dataset is melted to create tidy data. It will also add [mean of] to each column labels for better description. Finally output the data as "tidy_data.txt"
* baseData : melted tall and skinny gross_dataset
* secondgross_dataset : casete baseData which has means of each variables

## 7. Further work
Read tables can be optimizes by code improvements to catche the tables 
