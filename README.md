# Course Project of Getting and Cleaning Data
The script "run_analysis.R" automatically download the UCI HAR Dataset 
and unzip it in the local directory for follow-up processing. The 
processed tidy data set is stored in a file named "tidydata.txt".

It contains five main steps:
* Merges the training and the test variable sets,  (x_train,x_test), 
label sets (y_train,y_test), and subject sets (s_train,s_test) in data 
sets "x", "y", and "s", using rbind(), respectively.
* Extracts only the measurements on the mean and std deviation for the 
variable set.
* Merges the variable set, lable set and subject set in data set "data", 
where the numerics in the lable set "y" has been changed to the 
corresponding descriptive activity names.
* Labels data set "data" with descriptive variable names by editting 
names(data).
* Using data set "data" calculate the average of each variable for each 
activity and each subject, and store the results in a new data set 
"data_new", which is the final output of the script. 
