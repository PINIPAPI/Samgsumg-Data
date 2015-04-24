# Samgsumg-Data
This is my project off cleaning a tidy data
Readme.md
            
By Carlos pinilla pinillac@gmail.com
The code starts by making the assumption that the working folder was downloaded and unzipped.
Also assumes that it has set as working directory " %/UCI HAR Dataset/ " .
After analyzing the work to do , it was concluded that we should loaded  plyr and dplyr libraries .

1.To begin, I added the raw data, the study subjects and codes of activities for 
both the training data and to the test data.            to each table were given 
names to the variables separately and then joined together to form a single data 
set of training and of test. After doing that I merged the 2 groups in one 
data.frame called total

2. As we were asked to extracts only the measurements on the mean and standard 
deviation for each measurement, all that measurement already    were in the 
data.frame so I use the command grepl because is usefull to recognize parts of 
the name in the variables

   narrow_total_col <- grepl("mean|std", titles$V2)

   in that way I get the logical in the positions where the information I needed 
   was    so I use the command total_narrow <- total[,narrow_total_col] to have 
   the information that I was interested in

3. To use descriptive activity names to name the activities in the data set, I
   loaded the activitie codes form activity_labels.txt file and give that new data.frame logical names to the variables
   in order to excecute a join between the original total and the activiti_labels and remove the column of codes.
   
4. To appropriately labels the data set with descriptive activity names, I loaded the traduction of the short phrases
   From the features_info and take the real names of the variables and reasign the names 

5. For create a second, independent tidy data set with the average of each variable for each activity and each subject, I used a ddply
   function to split the groups where I needed (activity and subject) and calculate the average of each varible
   tidy_data <- ddply(total1, c("Activity_Descrip","Subject"), numcolwise(mean))
   
   and at the end export the data by "write.table(tidy_data, file="Avg-subject-action.txt", row.name=FALSE)"
   
