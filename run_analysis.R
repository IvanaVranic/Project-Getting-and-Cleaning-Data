#load libraries
library(dplyr)
library(qdapTools)

#Read all the data files
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#in X_test and X_train, set the names() to be the rows of the features dataset
names(X_test)<-features$V2
names(X_train)<-features$V2

#the column names of the y_train and y_test are changed to a more descriptive "activity"
names(y_train)<-"activity"
names(y_test)<-"activity"

#in subject_test and subject_train data set, the column name is changed to "subject"
names(subject_test)<-"subject"
names(subject_train)<-"subject"

#in "activity_labels" dataset the activity names are changed to lowercase
activity_labels$V2<-tolower(activity_labels$V2)

#make two dataframes, one for "test", and one for "train" data, for which the columns are "subject", "activity" and "features"
test_data<-cbind(subject_test, y_test, X_test)
train_data<-cbind(subject_train, y_train, X_train)

#bind train_data and test_data into one table dataframe called all_data
all_data<-rbind(train_data, test_data)

#get rid of duplicate column names in all_data
names(all_data)<-make.names(names(all_data), unique = TRUE)

#Extracts only the measurements on the mean and standard deviation for each measurement(feature) and store in mean_std_data data set
mean_std_data<-all_data[,c(1,2,grep("mean|Mean|std|Std", names(all_data)))]
#use activity_labels dataset to lookup values of activities in mean_std_data and replace with descriptive names
mean_std_data$activity<-lookup(mean_std_data$activity, activity_labels)

#arrange mean_std_data by subject and activity
mean_std_data<-arrange(mean_std_data, subject, activity)

#group mean_std_data by subject and activity and calculate mean for every variable
subject_activity_mean<-mean_std_data%>% group_by_("subject", "activity")%>%summarize_all(funs(mean=mean))
View(subject_activity_mean)

#create .txt file "runAnalysis.txt"
write.table(subject_activity_mean, "runAnalysis.txt", row.names = FALSE)