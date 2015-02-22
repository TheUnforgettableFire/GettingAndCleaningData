### Explanation and steps to execute run_analysis.R code

## Prerequisite
	1. Download the zip file from the following URL using the download.file function
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

	2. Uncompress the zip file in the working directory.

## Explanation and steps

There are three training and test data files.

* The x_train  and x_test file contain the data for all the subjects and all the activitites.
* The subject_train and subject_test files are vectors of the subject ID.
* The y_train and y_test files are vectors of activities.

	1. Load the reshape2 library. The melt and dcast functions will be used to create the tidy data set.

	2. Read into data frames all the training and test data files using read.csv. Since there is no header, we will indicate header = FALSE. Note, also, separator for x files is "".

	3. Add the column names to the X_train and X_test files, using the labels in the features.txt file.

	4. The factor levels of the activities are included in the activity_labels.txt file. Extract the values from this file and assign the values to the factor levels.

	5. To tabulate the mean and standard deviation, use grep to search/index mean() or std(). The \\ will ensure that the parentheses are treated as parentheses.

	6. Use Cbind to merge the three training data sets and three test data sets. Use rbind to merge training data and test data.

	7. Next step is to melt and cast the data. The melt function ensures that Subject and Activity are ID variables and mean and std variable are measures.

	8. Cast (dcast) the dataset by using Subject + Activity, to make sure that averages are calculated for each activity for each subject.

	9. Finally, as instructed, write the tidy data set to a text file (comma separated) with no row names.