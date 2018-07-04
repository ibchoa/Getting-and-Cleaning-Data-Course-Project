Code book describing the variables

Data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Full description of the project from the website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

README.txt
features_info.txt: variables used on the feature vector
features.txt: all features
activity_labels.txt: class labels with their activity name
test/X_test.txt: test set
test/y_test.txt: test labels
train/X_train.txt: training set
train/y_train.txt: training label

Use of the following libraries: 
data.table
dplyr

Load the features and activity labels
Load the testing and training data set
Extract mean and standard deviation
Label data
Combine data
