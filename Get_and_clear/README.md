Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization.
What follows first are my notes on the original data.

About the raw data
------------------
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The features are unlabeled and can be found in the X_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.

About the script and the tidy dataset
-------------------------------------
I created a script called run_analysis.R which will merge the test and training sets together. It requires plyr package.

After merging testing and training, labels are added and only columns (66) that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity.

This tidy dataset will be written to file called dtidy.txt, which can also be found in this repository.

About the Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.
