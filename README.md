# Project-Getting-and-Cleaning-Data
Firstly, all necessary data files and libraries were read in.
Since X_test and X_train do not have descriptive column names, their column names are replaces by the correct names found in the "features" file.
The column names of the y_train and y_test are changed to a more descriptive "activity"
In subject_test and subject_train data set, the column name is changed to "subject"
In "activity_labels" dataset the activity names are changed to lowercase
Next, we make two dataframes, one for "test", and one for "train" data, for which the columns are "subject", "activity" and "features"
We bind train_data and test_data into one table dataframe called all_data and get rid of duplicate column names in all_data
As per assignment specs, we extracts only the measurements on the mean and standard deviation for each measurement(feature) and store in mean_std_data data set
Next, we use activity_labels dataset to lookup values of activities in mean_std_data and replace with descriptive names
Finally, we arrange mean_std_data by subject and activity, group mean_std_data by subject and activity and calculate mean for every variable
The final dataset is saved as a .txt file
