### Cleaning Data Course ReadMe
run the script with the Analyze() function, will convert the dataset at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into a tidy dataset and store it as a text file.


run_analysis.R performs the following steps
1: run_analysis.R will download the and unzip the file from the above link.
2: the data from the file is read into the script
3: the script takes the mean() and std() data from the datasets
4: the tables are combined into one table
5: the script uses melt/cast to return mean value of each subject/activity pair
6: then renames the code numbers to their associated activities according to the activity labels file
7: saves result to a text file "tidy_data.txt"

