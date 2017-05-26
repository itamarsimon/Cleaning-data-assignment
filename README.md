# Cleaning-data-assignment

The scrip run_analysis takes data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* The data is broken into two separate datasets "test and "train" which are in the X_test.txt and X_train.txt files
* The experiment was made with 30 volunteers who which their corresponding measurements are presented in the "test" and "train" datasets in the subject_test.txt and subject_train.txt files.
* The volunteers went through 6 types of activities which are presented in the activity_labels.txt file.
* the corresponding activities measurements are presented in the corresponding "test and "train" datasets in the y_test.txt and y_train.txt files


## In the run_analysis script, the following takes place
### Load libraries
* Load libraries for R script ("dplyr", "tidyr")

### Download files
* Download and unzip the files

### Read activities for later use
* Read the different activities into a table which will be used later for merging the datasets

### Read variables for later use
* Read the variables into a table which will be used later for merging the datasets

### "test" dataset
* Merge test activity and subject and replace values of activity with descriptive measures
* Read test dataset and change variable names to match features dataset
* Bind test dataset with activity and subject
* Eliminate first column to avoid error
* Filter only necessary columns

### "train" dataset
* Merge train activity and subject and replace values of activity with descriptive measures
* Read train dataset and change variable names to match features dataset
* Bind train dataset with activity and subject
* Eliminate first column to avoid error
* Filter only necessary columns

### Combined dataset
* Bind the clean test and train datasets

### Tidy dataset
* tidy the clean dataset
* Write a new text dataset
* verify file - should have 180 rows (6 activities times 30 subjects) with 88 variables

