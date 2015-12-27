## Raw Data Description
The raw data used in this script was gathered by Smartlab. Thirty people were asked to participate in six different activities while wearing their cell phones, and embedded accelerometers and gyroscopes collected data regarding position and time. These data were then pre-processed through noise filters and divided into time-domain and frequency-domain variables. Many of these variables are actually various statistical measures of observations. Each variable has been normalized and its value is between -1 and 1.

## Brief Script Description
This script takes the original full [10299 x 561] data frame and retains only those variables that are means or standard deviations. The output is a tidied wide-form [180 x 68] data frame with the averages of those variables indexed by subject ID and activity type. For a full description, please see the README.md file.

##Codes
Subject is an integer from 1-30 describing which subject performed the activity.  
Activity is a character describing one of six activities: Laying, Sitting, Standing, Walking, Walking_Upstairs, Walking_Downstairs.  
The rest of the variables are coded in the following way:  
&nbsp;&nbsp;&nbsp;"Time" indicates the variable is in the time domain.  
&nbsp;&nbsp;&nbsp;"Freq" indicates the variable is in the frequency domain.  
&nbsp;&nbsp;&nbsp;"Accelerometer" indicates the data were obtained from the accelerometer (measured in units of g's).  
&nbsp;&nbsp;&nbsp;"Gyroscope" indicates the data were obtained from the gyroscope (measured in units of rad/seg).  
&nbsp;&nbsp;&nbsp;Signals from the devices were measured in the x,y,z coordinate frame. This allowed the de-convolution of data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;corresponding to the subject from that of gravity. The variables are labeled as "Body" or "Gravity" to indicate as much.  
&nbsp;&nbsp;&nbsp;"Magnitude" indicates the total magnitude of the observation (no direction specified).  
&nbsp;&nbsp;&nbsp;"Jerk" indicates the variable corresponds to a jerk signal derived in time from the body linear acceleration and angular  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;velocity.  
&nbsp;&nbsp;&nbsp;"Mean" indicates the variable is a mean. (For clarification: the value reported is thus an average of means)  
&nbsp;&nbsp;&nbsp;"StD" indicates the variable is a standard deviation. (For clarification: the value reported is thus an average of standard  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;deviations)  
&nbsp;&nbsp;&nbsp;"_X", "_Y", "_Z" indicates the variable was recorded in the x, y, or z direction, respectively.

##Sources
Original data set has been published here:  
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  
And can be found at this link:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Full documentation can be found here:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
