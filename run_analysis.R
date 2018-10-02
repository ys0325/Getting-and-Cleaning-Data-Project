library(reshape2)
filename <- "getdata_dataset.zip"
## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

##Load Activity Labels and Features
ActLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
ActLabels[,2]<- as.character(ActLabels[,2])##change label names to character
Features <- read.table("UCI HAR Dataset/features.txt")
Features[,2]<- as.character(Features[,2])##change featuress names to character

##Load features with mean and standard deviation only
FeaturesNeeded<-grep(".*mean.*|.*std.*", Features[,2])
FeaturesNeeded.names <- Features[FeaturesNeeded,2]
FeaturesNeeded.names = gsub('-mean', 'Mean', FeaturesNeeded.names)
FeaturesNeeded.names = gsub('-std', 'Std', FeaturesNeeded.names)
FeaturesNeeded.names <- gsub('[-()]', '', FeaturesNeeded.names)

##Load train dataset
train_X <- read.table("UCI HAR Dataset/train/X_train.txt")[FeaturesNeeded]
train_Y <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_Subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(train_Subject, train_Y, train_X)

##Load test dataset
test_X <- read.table("UCI HAR Dataset/test/X_test.txt")[FeaturesNeeded]
test_Y <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_Subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_Subject, test_Y, test_X)

All <- rbind(train, test)
colnames(All) <- c("subject", "activity", FeaturesNeeded.names)
All$activity <- factor(All$activity, levels = ActLabels[,1], labels = ActLabels[,2])
All$subject <- as.factor(All$subject)
All.melted <- melt(All, id = c("subject", "activity"))
All.mean <- dcast(All.melted, subject + activity ~ variable, mean)
write.table(All.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
