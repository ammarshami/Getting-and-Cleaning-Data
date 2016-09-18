
#Check if a directory named GettingData exists, if not, then create it
if(!file.exists("./GettingData")){dir.create("./GettingData")}
#set the data path
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download the file to GettingData
download.file(dataUrl,destfile="./GettingData/DataSet.zip")
#Unzip the file
unzip(zipfile="./GettingData/DataSet.zip")
#Data in UCI HAR Dataset

#Read the activity files into variables
testActivities  <- read.table(file.path("./UCI HAR Dataset", "test" , "y_test.txt" ),header = FALSE)
trainActivities  <- read.table(file.path("./UCI HAR Dataset", "train" , "y_train.txt" ),header = FALSE)

#Read the subject files
testSubject <- read.table(file.path("./UCI HAR Dataset", "test", "subject_test.txt"),header = FALSE)
trainSubject <- read.table(file.path("./UCI HAR Dataset", "train", "subject_train.txt"),header = FALSE)

#Read features
testFeatures  <- read.table(file.path("./UCI HAR Dataset", "test" , "x_test.txt" ),header = FALSE)
trainFeatures  <- read.table(file.path("./UCI HAR Dataset", "train" , "x_train.txt" ),header = FALSE)

#Merge the test & train sets (by rows) to create one data set
subjectData <- rbind(testSubject, trainSubject)
activityData<- rbind(testActivities, trainActivities)
featuresData<- rbind(testFeatures, trainFeatures)

#Use descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path("./UCI HAR Dataset", "activity_labels.txt"),header = FALSE)
activityLabels[, 2] = gsub("_", "", tolower(as.character(activityLabels[, 2])))
activityData[,1] = activityLabels[activityData[,1], 2]

#set column names
names(subjectData) <- c("subject")
names(activityData) <- c("activity")
featuresNames <- read.table(file.path("./UCI HAR Dataset", "features.txt"),head=FALSE)
names(featuresData)<- featuresNames$V2

#Merge the columns of the 3 sets above to get one data set for all
oneSet <- cbind(subjectData, activityData, featuresData)

#Extract only the measurements on the mean and standard deviation for each measurement 
#Select column names related to Mean and Standard Deviation
requiredFeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]

#Subset the oneSet table by the required features
selectedFeatures<-c("subject", "activity", as.character(requiredFeaturesNames))

#Set oneSet to have only the required columns
oneSet <- subset(oneSet,select=selectedFeatures)

#Appropriately label the data set with descriptive variable names
names(oneSet)<-gsub("^t", "time", names(oneSet))
names(oneSet)<-gsub("^f", "frequency", names(oneSet))
names(oneSet)<-gsub("Acc", "Accelerometer", names(oneSet))
names(oneSet)<-gsub("Gyro", "Gyroscope", names(oneSet))
names(oneSet)<-gsub("Mag", "Magnitude", names(oneSet))

library(reshape2)

#create a second, independent tidy data set with the average of each variable for each activity and each subject
oneSetMelted <- melt(oneSet, id = c("subject", "activity"))
oneSetMean <- dcast(oneSetMelted, subject + activity ~ variable, mean)
write.table(oneSetMean, "tidy.txt", row.names = FALSE, quote = FALSE)
