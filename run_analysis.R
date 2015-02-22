## Code for creating an independent tidy data set with the average of each variable
## for each activity and each subject 

## libraries used (reshape2) for melt and dcast functions 

library(reshape2)

## data is already downloaded using download.file and unzipped in working directory
## Read training and test data into dataframes

## Training data stored in dataframes
X.Training <- read.csv("./train/X_Train.txt", sep = "", header = FALSE)
Y.Training <- read.csv("./train/Y_Train.txt", header = FALSE)
Subject.Training <- read.csv("./train/Subject_Train.txt", header = FALSE)

## Test data stored in dataframes
X.Test <- read.csv("./test/X_Test.txt", sep = "", header = FALSE)
Y.Test <- read.csv("./test/Y_Test.txt", header = FALSE)
Subject.Test <- read.csv("./test/Subject_Test.txt", header = FALSE)

## Extract column names for X.Training & X.Test
X.Column.Names <- read.csv("features.txt", sep = "", header = FALSE)
X.Column.Names <- X.Column.Names[, 2]

## Insert column names for X.Training & X.Test

## Column names on X Training data
colnames(X.Training) <- X.Column.Names

## Column names on X Test data
colnames(X.Test) <- X.Column.Names

## Extract factor level labels for Y.Training & Y.Test
Activity.Labels <- read.csv("activity_labels.txt", sep = "", header = FALSE)
Activity.Labels <- Activity.Labels[, 2]

## Add factor level labels for Y.Training & X.Test

## Add factor level labels on Y Training data

## Change column to a factor
colnames(Y.Training) <- c("Activity")
Y.Training$Activity <- as.factor(Y.Training$Activity)
## Insert factor level names
levels(Y.Training$Activity) <- Activity.Labels

## Add factor level labels on Y Test data

## Change column to a factor
colnames(Y.Test) <- c("Activity")
Y.Test$Activity <- as.factor(Y.Test$Activity)
## Assign factor level names
levels(Y.Test$Activity) <- Activity.Labels

## Assign column name in subject data sets "Subject"
colnames(Subject.Training) <- c("Subject")
colnames(Subject.Test) <- c("Subject")

## Extract only the measurements on the mean and standard deviation for each measurement

## Identify indices of mean and std column names usin grep 
## \\ will ensure that grep looks for the "(" and ")"
## | is OR operator
indices <- grep("mean\\(\\)|std\\(\\)", names(X.Training))

## Train data
X.Training.Subset <- X.Training[, indices]

## Test data
X.Test.Subset <- X.Test[, indices]

## Merge train and test data

## Merging training data using Cbind
Train.Data <- cbind(Subject.Training, Y.Training, X.Training.Subset)

## Merging test data using Cbind
Test.Data <- cbind(Subject.Test, Y.Test, X.Test.Subset)

## Merging training & test data
Final.Data <- rbind(Train.Data, Test.Data)

## Create tidy data set from Final.Data

## Convert Subject variables to factors
Final.Data$Subject <- as.factor(Final.Data$Subject)

## Assign measure variables to melt data
measures <- names(Final.Data)
measures <- measures[3:68]

## Melt Final.Data (make sure reshape2 is in library)
Final.Melt <- melt(Final.Data, id = c("Subject", "Activity"), measure.vars = measures)

## Dcast Final.Melt (make sure reshape2 is in library)
Final.Cast <- dcast(Final.Melt, Subject + Activity ~ variable, mean)

## Result saved as a txt file created with write.table() using row.name=FALSE
write.table(Final.Cast, "tidy_data_set.txt", row.names=FALSE, sep=",")