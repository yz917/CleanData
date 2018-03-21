# Getting and Cleaning Data Course Project.

# 0.Download and read data.
if (!file.exists("Dataset.zip")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl,destfile="Dataset.zip")
}
if (!file.exists("UCI HAR Dataset")) {
	unzip("Dataset.zip")
}
features<-read.table("UCI HAR Dataset\\features.txt")
activity_labels<-read.table("UCI HAR Dataset\\activity_labels.txt")
x_train<-read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt")
s_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt")
x_test<-read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt")
s_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt")

# 1.Merges the training and the test sets to create one data set.
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
s<-rbind(s_train,s_test)

# 2.Extracts only the measurements on the mean and standard deviation
# for each measurement.
x_extract<-x[grep("-mean|std",as.character(features$V2))]
col_x <- ncol(x_extract)

# 3.Uses descriptive activity names to name the activities in the data set
data<-cbind(x_extract,activity_labels$V2[y$V1],s)

# 4.Appropriately labels the data set with descriptive variable names.
names(data)<-c(as.character(features$V2[grep("-mean|std",as.character(features$V2))]),"activity","subject")

# 5.From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
data_activity <- as.data.frame(colMeans(data[data$activity==activity_labels$V2[1],1:col_x]))
for ( i in 2:nrow(activity_labels) ) {
	data_activity <- cbind(data_activity,as.data.frame(colMeans(data[data$activity==activity_labels$V2[i],1:79])))
}
names(data_activity)<-as.character(activity_labels$V2)
data_subject <- as.data.frame(colMeans(data[data$subject==1,1:col_x]))
for ( i in 2:max(s) ) {
	data_subject <- cbind(data_subject,as.data.frame(colMeans(data[data$subject==i,1:col_x])))
}
names(data_subject)<-as.character(c(1:max(s)))
data_new <- cbind(as.data.frame(rownames(data_activity)),data_activity,data_subject)
names(data_new)[1] <- "measurements"
write.table(data_new,file="tidydata.txt",quote=FALSE,row.name=FALSE)
