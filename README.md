## Getting and Cleaning Data Course Project 

This is the repository for getting and cleaning data's course project. 
The `run_analysis.R` does the following steps:
1. Download the dataset and load the data
2. Load the datasets and load labels, then process and extract the proper labels (mean and std).
3. Load train sets and test sets seperately, and merge data with activities and subjects
4. Merges the training and the test sets to create one data set.
5. Rename colnames with the merged dataset and use descriptive activity names to name the activities in the data set
6. From the data set in step 5, creates a second, independent tidy data set (`tidy_set.mean.csv`) with the average of each variable for each activity and each subject.