#This script assumes all data files from Samsung are present in the working directory (not in sub-
#directories as created when unzipping). It tidies the data and reports average values for each subject and
#activity.

library(dplyr)

#Read in relevant files to data frames. Note that subsequent steps are not in order of assignment's steps.
rawTestSet <- read.table("X_test.txt")
rawTrainSet <- read.table("X_train.txt")
colHeads <- read.table("features.txt")
testActivity <- read.table("y_test.txt")
trainActivity <- read.table("y_train.txt")
testIndex <- read.table("subject_test.txt")
trainIndex <- read.table("subject_train.txt")

#Step 1: Combine into one data frame. Makes sense to use rbind rather than merge or join since all
#column names are the same between the two sets.
rawSet <- rbind(rawTestSet, rawTrainSet)

#Step 2: Subset combined data frame (rawSet) into a new data frame containing information on only means
#and standard deviations. Prior to this subsetting, the variables are named using the features.txt file.
#This aids in subsetting by allowing partial matches to the given variable labels. In the case of std
#data this can be used as-is, but the mean data needs additional cleaning to eliminate the mean
#frequency entries.
colnames(rawSet) <- as.character(colHeads$V2)
rawMeanSet <- rawSet[grepl("mean", names(rawSet))]            #Subsets a new data frame containing means
cleanMeanSet <- rawMeanSet[!grepl("Freq", names(rawMeanSet))] #Cleans the mean df of "meanfreq" variables
stdSet <- rawSet[grepl("std", names(rawSet))]                 #Subsets a new data frame containing stds
index <- rbind(testIndex, trainIndex)
names(index)[names(index)=="V1"] <- "A1"                    #Temporary index label for alphabetizing
activity <- rbind(testActivity, trainActivity)
names(activity)[names(activity)=="V1"] <- "A2"              #Temporary activity label for alphabetizing
completeSet <- cbind(index, activity, cleanMeanSet, stdSet) #Stitch together relevant variables

#Step 3: Replace activity codes with actual activities.
completeSet$A2[completeSet$A2 == 1] <- "Walking"
completeSet$A2[completeSet$A2 == 2] <- "Walking Upstairs"
completeSet$A2[completeSet$A2 == 3] <- "Walking Downstairs"
completeSet$A2[completeSet$A2 == 4] <- "Sitting"
completeSet$A2[completeSet$A2 == 5] <- "Standing"
completeSet$A2[completeSet$A2 == 6] <- "Laying"

#Step 4: Labels the data set with appropriate variable names. Done by substituting existing names with
#expanded versions.
names(completeSet) <- gsub("^t", "Time", names(completeSet))
names(completeSet) <- gsub("^f", "Freq", names(completeSet))
names(completeSet) <- gsub("Acc", "Accelerometer", names(completeSet))
names(completeSet) <- gsub("Gyro", "Gyroscope", names(completeSet))
names(completeSet) <- gsub("Mag", "Magnitude", names(completeSet))
names(completeSet) <- gsub("BodyBody", "Body", names(completeSet))
names(completeSet) <- gsub("[[:punct:]]", "", names(completeSet))
names(completeSet) <- gsub("mean", "Mean", names(completeSet))
names(completeSet) <- gsub("X", "_X", names(completeSet))
names(completeSet) <- gsub("Y", "_Y", names(completeSet))
names(completeSet) <- gsub("Z", "_Z", names(completeSet))
names(completeSet) <- gsub("std", "StD", names(completeSet))
orderedSet <- completeSet[,order(names(completeSet))]                     #Alphabetize column names
names(orderedSet) <- gsub("A1", "Subject", names(orderedSet))
names(orderedSet) <- gsub("A2", "Activity", names(orderedSet))

#Step 5: Finish organizing data frame and report mean values indexed by subject and activity codes. 
tidySet <- orderedSet %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))
write.table(tidySet, file = "TidySamsungData.txt", row.names = FALSE, sep="\t")
