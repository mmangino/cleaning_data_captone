
library("plyr")

#Download the data and record when it was downloaded
zip_file <- "data.zip"
if (!file.exists(zip_file)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zip_file)
  write(Sys.time(),"downloaded.txt")
}

#Appropriately labels the data set with descriptive variable names.


data <- read.table(unz("data.zip","UCI HAR Dataset/features.txt"), col.names=c("num","name"))
x_names <- unlist(lapply(as.character(data[,"name"]), function(x) {tolower(gsub("[-(),]","",x))}))
y_names <- c("activityid")
subject_names <- c("subjectid")
# Load y data
y_train <- read.table(unz("data.zip","UCI HAR Dataset/train/y_train.txt"), col.names=y_names)
y_test <- read.table(unz("data.zip","UCI HAR Dataset/test/y_test.txt"), col.names=y_names)

# Load X data
x_train <- read.table(unz("data.zip","UCI HAR Dataset/train/X_train.txt"),col.names=x_names)
x_test <- read.table(unz("data.zip","UCI HAR Dataset/test/X_test.txt"),col.names=x_names)

# Load subject data
subject_train <- read.table(unz("data.zip","UCI HAR Dataset/train/subject_train.txt"), col.names=subject_names)
subject_test <- read.table(unz("data.zip","UCI HAR Dataset/test/subject_test.txt"), col.names=subject_names)
#Merges the training and the test sets to create one data set.
y_combined <- rbind(y_train, y_test)
x_combined <- rbind(x_train, x_test)
subject_combined <- rbind(subject_train, subject_test)

x_combined$activityid <- y_combined$activityid
x_combined$subjectid <- subject_combined$subjectid
#Uses descriptive activity names to name the activities in the data set
activity_table <- read.table(unz("data.zip","UCI HAR Dataset/activity_labels.txt"), col.names=c("activityid","activityname"))

with_names <- merge(x_combined,activity_table, by.x="activityid",by.y="activityid")

#Extracts only the measurements on the mean and standard deviation for each measurement.

to_keep <- grep("(mean|std|activityname|subjectid)$",names(with_names), value=TRUE)
limited <- select(with_names, one_of(to_keep))
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

by_subject_and_activity <- ddply(limited, c("subjectid", "activityname"), summarize,
      average_tbodyaccmagmean=mean(tbodyaccmagmean),
      average_tbodyaccmagstd=mean(tbodyaccmagstd),
      average_tgravityaccmagmean=mean(tgravityaccmagmean),
      average_tgravityaccmagstd=mean(tgravityaccmagstd),
      average_tbodyaccjerkmagmean=mean(tbodyaccjerkmagmean),
      average_tbodyaccjerkmagstd=mean(tbodyaccjerkmagstd),
      average_tbodygyrojerkmagmean=mean(tbodygyrojerkmagmean),
      average_tbodygyrojerkmagstd=mean(tbodygyrojerkmagstd),
      average_tbodygyrojerkmagmean=mean(tbodygyrojerkmagmean),
      average_tbodygyrojerkmagstd=mean(tbodygyrojerkmagstd),
      average_fbodyaccmagmean=mean(fbodyaccmagmean),
      average_fbodyaccmagstd=mean(fbodyaccmagstd),
      average_fbodybodyaccjerkmagmean=mean(fbodybodyaccjerkmagmean),
      average_fbodybodyaccjerkmagstd=mean(fbodybodyaccjerkmagstd),
      average_fbodybodygyromagmean=mean(fbodybodygyromagmean),
      average_fbodybodygyromagstd=mean(fbodybodygyromagstd),
      average_angletbodyaccjerkmeangravitymean=mean(angletbodyaccjerkmeangravitymean),
      average_angletbodygyromeangravitymean=mean(angletbodygyromeangravitymean),
      average_angletbodygyrojerkmeangravitymean=mean(angletbodygyrojerkmeangravitymean),
      average_anglexgravitymean=mean(anglexgravitymean),
      average_angleygravitymean=mean(angleygravitymean),
      average_anglezgravitymean=mean(anglezgravitymean))

write.table(by_subject_and_activity,file="output_data.txt",row.name=FALSE)
      