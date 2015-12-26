# Project Overview
The course project for Getting and Cleaning Data involves taking a raw data set (in this case, some cell phone data from Samsung), subsetting it into only certain desired variables, and tidying it through an R script called run_analysis.R.

## Source Data Description
In an experiment designed by Smartlab, thirty people were asked to engage in six different activities while wearing their Samsung Galaxy II cell phones. The embedded accelerometer and gyroscope on each cell phone captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. These signals were pre-processed by Smartlab using various noise filters. Some data are provided in the time domain, while others are provided in the frequency domain. The resultant data set has 561 separate variables and is split into a "train" data set and a "test" data set based on a random selection of the thirty people. 

## Script Description
An R script called run_analysis.R was developed to process the raw data by retaining only those variables containing a mean or standard deviation of an observation and then returning the average of those variables. The resultant data frame can be considered "tidied" because each column has only one variable, each row has only one observation value, and the column names are descriptive and not actually part of the data. The data frame is wide-form with dimensions [180 x 68]. The output of run_analysis.R is a .txt file called "TidySamsungData.txt" which is intended to be read back into R using read.table() with header=TRUE. The script is split into five separate annotated sections:  

####Step 1. Combines both train and test data into one large data set with data from all thirty subjects.  
The test raw data and train raw data are read into two data frames, rawTestData and rawTrainData. This assumes that the "X_test.txt" and "X_train.txt" files are in the working directory. Using cbind(), these two data frames are then combined into a new data frame called rawSet.

####Step 2. Subsets data set into those variables containing only means and standard deviations, then indexes these variables according to subject and activity code.  
When created, the rawSet data frame has very generic "V##" column (variable) names. For subsetting, it is useful to attach the real variable names to these values. The real variable names are contained in the "features.txt" file, which is assumed to be in the working directory. This file is read into a data frame called colHeads, which is then used to rename the columns in rawSet. rawSet is then pared down to contain only variables with "mean" or "std" in their name. (Many observations had several statistical variables attached to them, but the means and standard deviations are the only ones retained by this script). Finally, these variables are indexed by the subject ID (a number between 1 and 30) and the activity ID (a number between 1 and 6). The subject IDs are contained within the "subject_test.txt" and "subject_train.txt" files, which are assumed to be in the working directory. The activity IDs are contained within the "y_test.txt" and "y_train.txt" files, which are also assumed to be in the working directory.

####3. Renames activity codes to descriptive activities.  
The activity ID codes are replaced with the actual activity performed: 1 = Walking, 2 = Walking_Upstairs, 3 = Walking_Downstairs, 4 = Sitting, 5 = Standing, 6 = Laying.

####4. Gives variable names better descriptions.
The variable names originally assigned are short codes for what they describe and are not easily understood at first glance. This section of the script uses gsub() to replace individual sections of text with clearer descriptions (for example, "Acc" with "Accelerometer" to denote that the data was taken from the Accelerometer feature of the phone). This step also alphabetizes the column names but leaves the Subject and Activity columns at the front. The resultant data frame is named orderedSet.

####5. Organizes data by subject and activity. Returns the average values of the variables.
The data frame, orderedSet, is then processed by group_by() and summarize_each() to return only the average value of each variable while leaving the index variables (Subject and Activity) alone. This step requires the loading of the dplyr package. While the loading of the dplyr library is contained within the script, the actual installation of the package is not and should be accomplished before running the script. Lastly, the tidied data set is exported to a text file called "TidySamsungData.txt" with the write.table() function.

## Sources
The original data is available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
A full description of the raw data is available from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
This data has been published here:  
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


