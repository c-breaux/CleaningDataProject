library(dplyr)

file_name<- "Project_Dataset.zip"

if(!file.exists(file_name)){
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, file_name)
}

if(!file.exists("UCI HAR Dataset")){
  unzip(file_name)
}

#read descriptive info
features<-read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#read test data
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test<-read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#read train data
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subject")
x_train<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train<-read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#merge all data
x_merged<-rbind(x_train, x_test)
y_merged<-rbind(y_train, y_test)
subject_merged<-rbind(subject_train, subject_test)
merged_complete<-cbind(subject_merged, y_merged, x_merged)

#tidy up the data, selecting relevant variables
cleaned_data<-select(merged_complete, subject, code, contains("mean"), contains("std"))

#apply activity names to the dataset
cleaned_data$code <- activity_labels[cleaned_data$code, 2]

#replace abbreviations with full variable names
names(cleaned_data)[2] = "activity"
names(cleaned_data)<-gsub("Acc", "Accelerometer", names(cleaned_data))
names(cleaned_data)<-gsub("Gyro", "Gyroscope", names(cleaned_data))
names(cleaned_data)<-gsub("BodyBody", "Body", names(cleaned_data))
names(cleaned_data)<-gsub("Mag", "Magnitude", names(cleaned_data))
names(cleaned_data)<-gsub("^t", "Time", names(cleaned_data))
names(cleaned_data)<-gsub("^f", "Frequency", names(cleaned_data))
names(cleaned_data)<-gsub("tBody", "TimeBody", names(cleaned_data))
names(cleaned_data)<-gsub("-mean()", "Mean", names(cleaned_data), ignore.case = TRUE)
names(cleaned_data)<-gsub("-std()", "STD", names(cleaned_data), ignore.case = TRUE)
names(cleaned_data)<-gsub("-freq()", "Frequency", names(cleaned_data), ignore.case = TRUE)
names(cleaned_data)<-gsub("angle", "Angle", names(cleaned_data))
names(cleaned_data)<-gsub("gravity", "Gravity", names(cleaned_data))

#create new dataset with average for each variable
final_data<- cleaned_data %>%
  group_by(subject, activity) %>%
  summarize_all(list(mean))
write.table(final_data, "FinalData.txt", row.names = FALSE)