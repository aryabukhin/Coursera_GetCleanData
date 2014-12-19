Coursera. Getting and cleaning data. Course project
=====================

This repository contains instructions to prepare tidy data based on "Human Activity Recognition Using Smartphones Dataset Version 1"

## Instructions

Source dataset can be downloaded here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. It must be unpacked. 

For tiding this data run run_analysis.R within the same directory with unpacked data without any parameters.

The result will be stored in file "tidy_data.txt".

## run_analysis.R description

This script read files *test/X_test.txt, test/y_test.txt, test/subject_test.txt, train/X_train.txt, train/y_train.txt, train/subject_train.txt, activity_lalels.txt* and combine it in single dataset.

After this it is read features (columns) names from 'features.txt') and select only *mean()* and *std()* features. Apply this selected features list to total dataset.

At the last it aggreagate this dataset by *subject_id* and *activity* with *mean* function and store result in "tidy_data.txt"




