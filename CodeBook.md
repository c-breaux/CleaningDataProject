The run_analysis script does the following, to prepare the raw data according to the course project's requirements:

1) Downloads the dataset (if not already present), and extracts it to a folder named "UCI HAR Dataset" (again, if not already created).

2) Reads the data into R, creating the following variables:
	-features
	-activity_labels
	-subject_test
	-x_test
	-y_test
	-subject_train
	-x_train
	-y_train

3) Merges the data:
	a) first merging together x, y, and subject data into 3 tables
	b) then merging the three tables into one

4) Selects only the required data (subject, code, mean and standard deviation).

5) Uses the activity_labels data to rename the values in the code column of the merged dataset.

6) Updates labels with more descriptive variable names using gsub.
	i.e.: Gyro becomes Gyroscope, Acc becomes Accelerometer, etc.
	
7) Creates a second summary dataset from the first dataset, which contains the mean of each variable for each activity and subject.
	a) Exports this dataset to a file named FinalData.txt
