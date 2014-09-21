# This is project work for gettgin and Claenaing data
# Here is what we project goals
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
#    activity and each subject.
#

library(dplyr)
library(tidyr)
library(reshape2)


# Loading all the files into tables
tblfeatures <- tbl_df(read.table("./features.txt"))
tblX_train <- tbl_df(read.table ("./train/X_train.txt"))
tblX_test <- tbl_df(read.table("./test/X_test.txt"))
tblsubtrain <- tbl_df(read.table("./train/subject_train.txt"))
tblsubtest <- tbl_df(read.table("./test/subject_test.txt"))
tbly_train <- tbl_df(read.table("./train/y_train.txt"))
tbly_test <- tbl_df(read.table("./test/y_test.txt"))



#Part 1-------------------------------------------------------
tblXtraintest <- rbind(tblX_train, tblX_test)

names(tblsubtrain)[1] <- "Subject"
names(tblsubtest)[1] <- "Subject"
tblsubtraintest <- rbind(tblsubtrain, tblsubtest)

names(tbly_train)[1] <- "Activity"
names(tbly_test)[1] <- "Activity"
tblytraintest <- rbind(tbly_train, tbly_test)
#Part4 Answer
cDescNames <- gsub("\\(", "", tblfeatures$V2)
cDescNames <- gsub("\\)", "", cDescNames)
cDescNames <- gsub("-", "", cDescNames)
colnames(tblXtraintest) <- cDescNames
#Part1 Answer
tbldata <- cbind(tblXtraintest, tblsubtraintest, tblytraintest)
#---------------------------------------------------------------

#Part 2----------------------------------------------------------------------
tblmeandata <- select(tbldata, num_range("V", grep('mean', tblfeatures$V2)))
tblstddata <- select(tbldata, num_range("V", grep('std', tblfeatures$V2)))
#Part 2 Answer
tblmeanNstd <- cbind(tblmeandata, tblstddata)
#------------------------------------------------------------------------------
#Part 3
names(tblActLabels)[1] <- "Activity"    
tblActmerge <- merge(tbldata, tblActLabels, by='Activity')
names(tblActmerge)[564] <- "ActDesc" 
#-----------------------------------------------------------------------------




