##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Rodrigo Ansanello Arvolea
## 2015-04-21

##########################################################################################################


######################################################################################################
# Step 1 - Merge datasets (training and test) to create one data set.
######################################################################################################

# Set working directory 
setwd('C:/A5-Learning/Coursera/Data Science/3-Getting and Cleaning Data/Course Project/UCI HAR Dataset');

# Read tables and assign columns (Training Data)
tbFeatures     = read.table('./features.txt',header=FALSE); 
tbActivityType = read.table('./activity_labels.txt',header=FALSE); 
tbSubjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
tbXTrain       = read.table('./train/x_train.txt',header=FALSE);
tbYTrain       = read.table('./train/y_train.txt',header=FALSE); 

colnames(tbActivityType)  = c('activityId','activityType');
colnames(tbSubjectTrain)  = "subjectId";
colnames(tbXTrain)        = tbFeatures[,2]; 
colnames(tbYTrain)        = "activityId";

# Create Training Dataset 
trainingData = cbind(tbYTrain,tbSubjectTrain,tbXTrain);

# Read tables and assign columns (Test Data)
tbSubjectTest = read.table('./test/subject_test.txt',header=FALSE); 
tbXTest       = read.table('./test/x_test.txt',header=FALSE);
tbYTest       = read.table('./test/y_test.txt',header=FALSE);

colnames(tbSubjectTest) = "subjectId";
colnames(tbXTest)       = tbFeatures[,2]; 
colnames(tbYTest)       = "activityId";

# Create Test Dataset
testData = cbind(tbYTest,tbSubjectTest,tbXTest);

# Create Merged Dataset (Training and Test) 
mergedData = rbind(trainingData,testData);

# Column names vector
colNames  = colnames(mergedData); 

######################################################################################################
# Set 2  Extractmeasurements 
######################################################################################################

# Create a logicalVector 
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# mergedData subset
mergedData = mergedData[logicalVector==TRUE];

######################################################################################################
# Step 3. Use descriptive activity names to name the activities in the data set
######################################################################################################

mergedData = merge(mergedData,tbActivityType,by='activityId',all.x=TRUE);

# Updating olNames vector
colNames  = colnames(mergedData); 

######################################################################################################
# Step 4. Set dataset label with activity names. 
######################################################################################################

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(mergedData) = colNames;

######################################################################################################
# Step 5. Create tidy data set with the average of each variable for each activity and each subject. 
######################################################################################################

mergedSubSet  = mergedData[,names(mergedData) != 'activityType'];

# Summarizing 
tidyData    = aggregate(mergedSubSet[,names(mergedSubSet) != c('activityId','subjectId')],by=list(activityId=mergedSubSet$activityId,subjectId = mergedSubSet$subjectId),mean);

# Merging 
tidyData    = merge(tidyData,tbActivityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');