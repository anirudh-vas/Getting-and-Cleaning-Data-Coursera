##########################################################################################
# Author : Anirudh Vasudevan 
# Title : run_analysis.r
# Description : Getting and Cleaning Data Course Project
# Deadline: by April 24, 11:59 PM PDT
##########################################################################################

##########################################################################################
#          Data Import        #
##########################################################################################
tst_labels <- read.table("test/y_test.txt", col.names="label")
train_labels <- read.table("train/y_train.txt", col.names="label")
tst_subjects <- read.table("test/subject_test.txt", col.names="subject")
train_subjects <- read.table("train/subject_train.txt", col.names="subject")
tst_data <- read.table("test/X_test.txt")
train_data <- read.table("train/X_train.txt")

##########################################################################################
# putting the train and test data together and also the subjects and labels with the data #
##########################################################################################

data <- rbind(cbind(tst_subjects, tst_labels, tst_data ),
              cbind(train_subjects, train_labels, train_data))


##########################################################################################
#       reading all the features  and retaining the mean and SDev
##########################################################################################

features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# Extracting the mean and Standart Deviation
required_features <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select only the means and standard deviations from data

required_data <- data[, c(1, 2, required_features$V1+2)]

############ STEP 4 ######################################################################
#     Extrating the activity label information
##########################################################################################

# read the activity labels
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace labels in data with label names
required_data$label <- labels[required_data$label, 2]

##########################################################################################
#   Creating a DataFrame with required Columns and Data
##########################################################################################
# first make a list of the current column names and feature names
required_cols <- c("subject", "label", required_features$V2)
# then tidy that list
# by removing every non-alphabetic character and converting to lowercase
##required_cols <- tolower(gsub("[^[:alpha:]]", "", required_cols))
# then use the list as column names for data
colnames(required_data) <- required_cols

aggregateddata <- aggregate(required_data[, 3:ncol(required_data)],
                       by=list(subject = required_data$subject, 
                               label = required_data$label),mean)


##########################################################################################
#  Cleaning the Feature names and writing the data frame to a tidy Text File
##########################################################################################

# Remove parentheses
names(aggregateddata) <- gsub('\\(|\\)',"",names(aggregateddata), perl = TRUE)
# Make the names valid and understandable
names(aggregateddata) <- make.names(names(aggregateddata))

names(aggregateddata) <- gsub('Acc',"Acceleration",names(aggregateddata))
names(aggregateddata) <- gsub('GyroJerk',"AngularAcceleration",names(aggregateddata))
names(aggregateddata) <- gsub('Gyro',"AngularSpeed",names(aggregateddata))
names(aggregateddata) <- gsub('Mag',"Magnitude",names(aggregateddata))
names(aggregateddata) <- gsub('^t',"TimeDomain.",names(aggregateddata))
names(aggregateddata) <- gsub('^f',"FrequencyDomain.",names(aggregateddata))
names(aggregateddata) <- gsub('\\.mean',".Mean",names(aggregateddata))
names(aggregateddata) <- gsub('\\.std',".StandardDeviation",names(aggregateddata))
names(aggregateddata) <- gsub('Freq\\.',"Frequency.",names(aggregateddata))
names(aggregateddata) <- gsub('Freq$',"Frequency",names(aggregateddata))



write.table(format(aggregateddata, scientific=T), "UCI_HAR_Tidy_Data.txt",
            row.names=F)
