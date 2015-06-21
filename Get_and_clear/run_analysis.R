# Load raw data
# This code can be run as long as the Samsung data is in your working directory.

setwd("~/datasciencecoursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")

X.test <- read.table("./test/X_test.txt")
y.test <- read.table("./test/y_test.txt")
subject.test <- read.table("./test/subject_test.txt")

X.train <- read.table("./train/X_train.txt")
y.train <- read.table("./train/y_train.txt")
subject.train <- read.table("./train/subject_train.txt")

activity.labels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./features.txt")

# 1. Merges the training and the test sets to create one data set.

X.data <- rbind(X.train,X.test)  
y.data <- rbind(y.train,y.test) 
subject <- rbind(subject.train, subject.test) 


# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 

idx <- grep("mean\\(\\)|std\\(\\)", features[, 2])
X.data <- X.data[,idx]

names_features <- as.character(features[idx,2])
names(X.data) <- names_features
names(X.data) <- gsub("\\(\\)", "", names(X.data)) 
names(X.data) <- gsub("mean", "Mean", names(X.data)) 
names(X.data) <- gsub("std", "Std", names(X.data))
names(X.data) <- gsub("-", ".", names(X.data)) 

# 3. Uses descriptive activity names to name the activities in 
# the data set

activity.labels[2,2] <- sub(substr(activity.labels[2, 2],8,10),"_UP_",
                             activity.labels[2, 2],8,10)
activity.labels[3,2] <- sub(substr(activity.labels[3, 2],8,12),"_DOWN_",
                             activity.labels[3, 2],8,12)
activity.labels[, 2] <- tolower(activity.labels[, 2])

activity <- activity.labels[y.data[,1],2]

# 4. Appropriately labels the data set with descriptive variable names. 

cleaned <- cbind(subject,activity,X.data)
colnames(cleaned)[1] <- "subject"


# 5. From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.

# Check for installed packages before running install.packages()

if(!require(plyr)){
    install.packages("plyr")
    library(plyr)
}

dtidy <- ddply(cleaned, .(subject,activity), numcolwise(mean))
write.table(dtidy, "dtidy.txt", row.names = FALSE) 
