##Assignment: Getting and Cleaning Data Course Project

##Author: Jonathan Wharton
##Date:   14APR2016

##The below script completes the following steps:
##1)Merges the training and the test sets to create one data set.
##2)Extracts only the measurements on the mean and standard deviation for each measurement.
##3)Uses descriptive activity names to name the activities in the data set
##4)Appropriately labels the data set with descriptive variable names.
##5)From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.

##STEP 1) Read in and merge training and test files
##        Assumes that imported zip file has been extracted into working directory

##headers are read into V2 of headers table
##  Parentheses in header name will automatically be replaced by '.' when applying to data frame
headers<-read.table('./UCI HAR Dataset/features.txt')

test.ds<-read.table('./UCI HAR Dataset/test/X_test.txt',col.names=headers$V2)
test.subject<-read.table('./UCI HAR Dataset/test/subject_test.txt')
test.y<-read.table('./UCI HAR Dataset/test/y_test.txt')
test.ds$subject<-test.subject$V1
test.ds$activity.n<-test.y$V1

train.ds<-read.table('./UCI HAR Dataset/train/X_train.txt',col.names=headers$V2)
train.subject<-read.table('./UCI HAR Dataset/train/subject_train.txt')
train.y<-read.table('./UCI HAR Dataset/train/y_train.txt')
train.ds$subject<-train.subject$V1
train.ds$activity.n<-train.y$V1

combined<-rbind(test.ds,train.ds)

##STEP 2)Extract only the measurements on the mean and standard deviation for each measurement.
##       Dont forget at the prevous step added subject and activity.

keep.cols<-grep("mean[.]{2}|std|(^subject$)|(^activity[.]n$)",names(combined))
combined2<-combined[,keep.cols]

##STEP 3)Use descriptive activity names to name the activities in the data set
activity.labels<-read.table('./UCI HAR Dataset/activity_labels.txt')
combined2$activity<-sapply(combined2$activity.n,function(x) activity.labels$V2[x])

##STEP 4)Appropriately labels the data set with descriptive variable names.
##         Most of this was done at input step, but remove excess '.' and lower case.
names(combined2)<-tolower(gsub("[.]{2}",'',names(combined2)))

##STEP 5)From the data set in step 4, creates a second, independent tidy data set with the average 
##         of each variable for each activity and each subject.
combined2$subject<-as.factor(combined2$subject)
##remove subject and activity from data frame for summaries
combined3<-combined2[,1:66]

##Produce a list with each element having the name of the summary value
## and containing the two by variables as well as the mean values
summary<-lapply(combined3,function(x) aggregate(x,list(combined2$subject, combined2$activity),FUN=mean))

##Collect the mean value of each item by running sapply on a custom function.
##Include subject and activity in final clean dataset. Order by these two variables.
thirdElement<-function(x) {x[[3]]}
summary2<-sapply(summary,thirdElement)
summary3<-data.frame(summary[[1]][1],summary[[1]][2])
names(summary3)<-c("subject","activity")
TidyDataSet<-cbind(summary3,summary2)
TidyDataSet<-TidyDataSet[order(TidyDataSet$subject, TidyDataSet$activity),]

##Output tidy dataset
write.table(TidyDataSet,file="TidyDataSet.txt",row.names=FALSE)

