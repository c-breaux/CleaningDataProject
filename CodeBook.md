The run_analysis script does the following, to prepare the raw data according to the course project's requirements:

1) Downloads the dataset (if not already present), and extracts it to a folder named "UCI HAR Dataset" (again, if not already created).

2) Reads the data into R, creating the following variables:
	-features from features.txt (561 rows, 2 columns)
		-features are selected from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
	-activity_labels from activity_labels.txt (6 rows, 2 columns)
		-activities performed when the associated measurements were taken
	-subject_test from subject_test.txt (2947 rows, 1 column)
		-subject identifying data for testing set
	-x_test (2947 rows, 561 columns)
		-recorded features for testing data
	-y_test (2947 rows, 1 column)
		-labels for testing data
	-subject_train (7352 rows, 1 column)
		-subject identifying data fro training set
	-x_train (7352 rows, 561 column)
		-recorded features for training data
	-y_train (7352 rows, 1 column)
		-labels for training data

3) Merges the data:
	a) first merging together x (10299R, 561C), y (10299R, 1C), and subject (10299C, 1C) data into 3 tables
	b) then merging the three tables into one (10299R, 563C)

4) Selects only the required data (subject, code, mean and standard deviation).

5) Uses the activity_labels data to rename the values in the code column of the merged dataset.

6) Updates labels with more descriptive variable names using gsub.
	i.e.: Gyro becomes Gyroscope, Acc becomes Accelerometer, etc.
	
7) Creates a second summary dataset from the first dataset, which contains the mean of each variable for each activity and subject.
	a) Exports this dataset to a file named FinalData.txt (180R, 88C)
