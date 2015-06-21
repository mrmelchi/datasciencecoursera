Getting and Cleaning Data Course Project CodeBook
=================================================

This file describes the variables, the data, and any transformations that it is necessary to perform to clean up the raw data. 

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The run_analysis.R script performs the following steps to clean the data: 

This code can be run as long as the Samsung data is in a working directory labeled "C:/Users/Mario/Documents/datasciencecoursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

 1. Read X_test.txt, y_test.txt and subject_test.txt from the "./test" folder and store them in X.test, y.test and subject_test data respectively.
 
 2. Read X_train.txt, y_train.txt and subject_train.txt from the "./train" folder and store them in X.train, y.train and subject_train data respectively.
  
 3. Read activity_labels.txt and y_features.txt from the "./" folder and store them in activity.labels and features data frame respectively.
 
 4. Concatenate X.train to X.test to generate a 10299x561 data frame, labeled X.data; 
concatenate y.train to y.test to generate a 10299x  1 data frame, labeled y.data;
concatenate subject.train to subject.test to generate a 10299x1 data frame, labeled subject.

  
 5. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a vector named idx with the 66 corresponding items.  
 
 6. Select the columns from X.data that match with idx.

 7. We remove the "()", change "-" by "." symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
   
 8. Clean the activity names in the second column of activity data frame. We change the names has an underscore between letters ("_") by point ("."). We make all names to lower cases.

 9. The values of the activity.labels data frame are store in activity variable.  
 
10. Combine the subject data frame, activity variable and X.data data frame by column to get a new cleaned 10299x68 data frame, cleaned. Properly name the first two columns, "subject" and "activity".
The "subject" column contains integers that range from 1 to 30 inclusive;the "activity" column contains
6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
  
11. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which esult in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. We get a 180x68 data frame labeled dtidy.

12. Write the dtidy dataframe to "dtidy.txt" file in current working directory. 
 
