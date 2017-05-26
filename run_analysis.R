# Load libraries for R script 

library(dplyr)
library(tidyr)

# Download and unzip the files
if(!file.exists("./assignment_data")){dir.create("./assignment_data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="./assignment_data/Dataset.zip")
unzip(zipfile = "./assignment_data/Dataset.zip", exdir="./assignment_data")


# Read the different activitys into a table which will be used later on for merging the datsets
activity <- read.table("./assignment_data/UCI HAR Dataset/activity_labels.txt", quote="\"") %>% 
  rename(activity = V2) 

# Read the variables into a table which will be used later on for merging the datsets
variables <- read.table("./assignment_data/UCI HAR Dataset/features.txt", quote = "") %>% 
  rename(variable = V2) %>% 
  select(variable)

# Merge test activity and subject and replace values of activity with descriptive measures 
test_subject_df <- read.table("./assignment_data/UCI HAR Dataset/test/subject_test.txt", quote="\"") %>% 
  rename(subject = V1)
test_activity_df <- read.table("./assignment_data/UCI HAR Dataset/test/y_test.txt", quote="\"") %>% 
  rename(activity = V1) 
test_subject_activity <- bind_cols(test_activity_df,test_subject_df) %>% 
  rename(V1 = activity)
merge_test_subject_activity <- inner_join(test_subject_activity, activity, by = "V1") 

# Read test dataset and change variable names to match features dataset 
test_df <- read.table("./assignment_data/UCI HAR Dataset/test/X_test.txt", quote="\"")
colnames(test_df) <- variables$variable

# Bind test dataset with activity and subject
test_bind <- bind_cols(merge_test_subject_activity, test_df) 

# Eliminate first column to avoid error
eliminate_test <- test_bind[,-1]

# Filter only necesary columns
test_final <- select(eliminate_test, contains("subject"), contains("activity"), contains("mean"), contains("std"))

# Merge train activity and subject and replace values of activity with descriptive measures 
train_subject_df <- read.table("./assignment_data/UCI HAR Dataset/train/subject_train.txt", quote="\"") %>% 
  rename(subject = V1)
train_activity_df <- read.table("./assignment_data/UCI HAR Dataset/train/y_train.txt", quote="\"") %>% 
  rename(activity = V1)
train_subject_activity <- bind_cols(train_activity_df,train_subject_df) %>% 
  rename(V1 = activity)
merge_train_subject_activity <- inner_join(train_subject_activity, activity, by = "V1") 

# Read train dataset and change variable names to match features dataset 
train_df <- read.table("./assignment_data/UCI HAR Dataset/train/X_train.txt", quote="\"")
colnames(train_df) <- variables$variable

# Bind train dataset with activity and subject
train_bind <- bind_cols(merge_train_subject_activity, train_df) 

# Eliminate first column to avoid error
eliminate_train <- train_bind[,-1]

# Filter only necesary columns
train_final <- select(eliminate_train, contains("subject"), contains("activity"), contains("mean"), contains("std"))

# Bind the clean test and train datasets
test_train_final <- bind_rows(train_final, test_final) %>% tbl_df()

# tidy the clean dataset
tidy_data <- group_by(test_train_final, subject, activity) %>% 
  summarise_each(funs(mean)) 
  names(tidy_data) <- gsub("\\()-", "", names(tidy_data)) 
  names(tidy_data) <- gsub("\\-", "", names(tidy_data)) 
  names(tidy_data) <- gsub("\\()","", names(tidy_data))
  

# Write a new text dataset
write.table(tidy_data, "final_tidy.txt", row.names = FALSE) 
  

# verify file - should have 180 rows (6 activities times 30 subjects) with 88 variables
verify <- read.table("./final_tidy.txt", quote = "\"", header = TRUE)

