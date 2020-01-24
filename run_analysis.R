#run_analysis
#merge traning and test datasets
#extract mean and stdev
#calculate mean value for each column by subject/activity pair

downloadData=function(){
  if(!file.exists("UCI_HAR_Dataset.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip")
    unzip("UCI_HAR_Dataset.zip")}}

Analyze=function(){
  downloadData()
  
  xTest = read.table("UCI HAR Dataset/test/X_test.txt") #read in all data
  xTrain = read.table("UCI HAR Dataset/train/X_train.txt")
  yTest = read.table("UCI HAR Dataset/test/y_test.txt")
  yTrain = read.table("UCI HAR Dataset/train/y_train.txt")
  subjectTest = read.table("UCI HAR Dataset/test/subject_test.txt")
  subjectTrain = read.table("UCI HAR Dataset/train/subject_train.txt")
  activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")
  features = read.table("UCI HAR Dataset/features.txt")  
  
  subjectFull=rbind(subjectTest,subjectTrain)#combine  test and train data
  yFull=rbind(yTest,yTrain) 
  xFull=rbind(xTest,xTrain)
  
  mean_and_stdev=grep("mean\\(|std",features[,2])
  xFull=xFull[,mean_and_stdev] #remove columns that don't contain mean() or std()
  
  fullFull=cbind(subjectFull,yFull,xFull) #bind subjects, activities, and data together
  names(fullFull)=c("Subject","Activity",as.character(features[mean_and_stdev,2])) #name columns
  
  #melt and cast for average value for each subject/activity 
  meltFull=melt(fullFull,id=c("Subject","Activity"))
  castFull=dcast(meltFull,Subject + Activity ~ variable, mean)
  
  #rename activity code number to the associated activity
  castFull$Activity=sapply(castFull$Activity,function(rename_acti){tolower(activityLabels[rename_acti,2])})
  
  write.table(castFull,file="Getting_and_Cleaning_Data_Project.txt",row.name=FALSE)
  castFull
}