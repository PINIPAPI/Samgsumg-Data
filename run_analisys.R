## pinillac@gmail.com 
## Create one R script called run_analysis.R that does the following:                                                     
## 1. Merges the training and the test sets to create one data set.                                                       
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.                             
## 3. Uses descriptive activity names to name the activities in the data set                                              
## 4. Appropriately labels the data set with descriptive activity names.                                                  
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.   

## Start setting up the libraries we need to execute all tasks
library(plyr)
library(dplyr)

## I suppose we has setting up the Working directory in the dir with the files of the project in the same three directory
## I added to the raw data the names of each variable from features file
rtrain <- read.table("./train/X_train.txt")
titles <- read.table("features.txt")
names(rtrain) <- titles$V2

## Added, based on the number of observation, the subject train and the activitie code to the principal group pf data train
## and I  give names to the new variables  
subject_train <- read.table("./train/subject_train.txt")
names(subject_train) <- c("Subject")
y_train <- read.table("./train/y_train.txt")
names(y_train) <- c("Activity_ID")
train <- cbind(cbind(subject_train,y_train),rtrain)

## same procedure with the test data
rtest <- read.table("./test/X_test.txt")
titles <- read.table("features.txt")
names(rtest) <- titles$V2
## Added, based on the number of observation, the subject test and the activitie code to the principal group of data test
## and I  give names to the new variables
subject_test <- read.table("./test/subject_test.txt")
names(subject_test) <- c("Subject")
y_test <- read.table("./test/y_test.txt")
names(y_test) <- c("Activity_ID")

test <- cbind(cbind(subject_test,y_test),rtest)

## 1. Merges the training and the test sets to create one data set. 
total <- rbind(train,test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## As we are asked to extract just the variables with means and std varibles, I get list of logicals that shoe when the variable contains 
## the word "mean" or "std"
narrow_total_col <- grepl("mean|std", titles$V2)

## create another element with asked information
total_narrow <- total[,narrow_total_col]

## 3. Uses descriptive activity names to name the activities in the data set
## Load the activitie codes form activity_labels.txt file
activity_labels <- read.table("activity_labels.txt")
activity_names <- c("Activity_ID","Activity_Descrip")
names(activity_labels) <- activity_names
## made a join between the tables and eliminate the first column
total1 <- join(activity_labels,total, by ="Activity_ID")
total1 <- total1[,-1]

## 4. Appropriately labels the data set with descriptive activity names.
## From the features_info take the real names of the variables and reasign the names
names(total1) <- gsub('mean()'," Mean value",names(total1))                                                                          
names(total1) <- gsub('std()'," Standard deviation",names(total1))                                                                   
names(total1) <- gsub('mad()'," Median absolute deviation",names(total1))                                                            
names(total1) <- gsub('max()'," Largest value in array",names(total1))                                                               
names(total1) <- gsub('min()'," Smallest value in array",names(total1))                                                              
names(total1) <- gsub('sma()'," Signal magnitude area",names(total1))                                                                
names(total1) <- gsub('energy()'," Energy measure",names(total1))
names(total1) <- gsub('iqr()'," Interquartile range",names(total1))                                                                  
names(total1) <- gsub('entropy()'," Signal entropy",names(total1))                                                                   
names(total1) <- gsub('arCoeff()'," Autorregresion coef",names(total1))             
names(total1) <- gsub('correlation()'," correlation coef ",names(total1))       
names(total1) <- gsub('Acc',"Acceleration",names(total1))
names(total1) <- gsub('GyroJerk',"AngularAcceleration",names(total1))
names(total1) <- gsub('Gyro',"AngularSpeed",names(total1))
names(total1) <- gsub('Mag',"Magnitude",names(total1))
names(total1) <- gsub('mad()',"Median absolute deviation",names(total1))
names(total1) <- gsub('std()',"Standard deviation",names(total1))
names(total1) <- gsub('^t',"time",names(total1))
names(total1) <- gsub('^f',"frequency",names(total1))
names(total1) <- gsub('\\.std',".StandardDeviation",names(total1))
names(total1) <- gsub('Freq\\.',"Frequency.",names(total1))
names(total1) <- gsub('Freq$',"Frequency",names(total1))

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- ddply(total1, c("Activity_Descrip","Subject"), numcolwise(mean))
write.table(tidy_data, file="Avg-subject-action.txt", row.name=FALSE)

