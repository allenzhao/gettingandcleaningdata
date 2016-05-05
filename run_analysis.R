# Load the reshape lib.
library(reshape2)
# Download the dataset
source("helper_method.R")
download.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file.name <- "dataset.zip"
folder.name <- "UCI HAR Dataset"

if (!file.exists(file.name)) {
        download.file(download.url, file.name, method = "curl")
}
if(!file.exists(folder.name)) {
        unzip(file.name)
}

# Load activities and features
activity.labels <- read.table(gen.fileName("activity_labels"), as.is = T)
features <- read.table(gen.fileName("features"), as.is = T)

# Load only the mean and std, then rename the feattures
features.tidyIndex <- grep("mean|std", features[,2])
features.tidy <- features[features.tidyIndex,2]
features.tidy <- gsub("-mean", "Mean", features.tidy)
features.tidy <- gsub("-std", "Std", features.tidy)
features.tidy <- gsub("[-()]", "", features.tidy)
# Load train set
train_set <- read.table(gen.fileName("train/X_train"))[features.tidyIndex]
train_activities <- read.table(gen.fileName("train/Y_train"))
train_subjects <- read.table(gen.fileName("train/subject_train"))
train_set <- cbind(train_subjects, train_activities, train_set)
# Load test set
test_set <- read.table(gen.fileName("test/X_test"))[features.tidyIndex]
test_activities <- read.table(gen.fileName("test/Y_test"))
test_subjects <- read.table(gen.fileName("test/subject_test"))
test_set <- cbind(test_subjects, test_activities, test_set)
# Merge to tidy set
tidy_set <- rbind(train_set, test_set)
colnames(tidy_set) <- c("Subject", "Activity", features.tidy)
# Turn activity to factors
tidy_set$Activity <- factor(tidy_set$Activity, levels= activity.labels[,1], labels = activity.labels[,2])
# Melt into variable
tidy_set.melted <- melt(tidy_set, id = c("Subject", "Activity"))
tidy_set.mean <- dcast(tidy_set.melted, Subject + Activity ~ variable, mean)
# Write to CSV file
write.csv(tidy_set.mean, "tidy_set.mean.csv")