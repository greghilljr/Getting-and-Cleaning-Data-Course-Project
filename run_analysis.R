# 00 PREPARE WORKSPACE ---------------------------------------------------------------

# Clean up workspace
rm(list = ls(all.names = TRUE))

# Load packages
library(tidyverse)
library(here)

# Download and unzip UCI HAR dataset
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(URL,'ext/Dataset.zip')
unzip('ext/Dataset.zip', files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "ext", unzip = "internal",
      setTimes = FALSE)

# Cleanup files
file.remove('ext/Dataset.zip')
rm(URL)

# 01 MERGE TEST AND TRAINING DATA ---------------------------------------------------------------
# 01a Create Training Dataset
## 01a.1 Import Training Data
X_train <-
    read.delim(
        here("ext/UCI HAR Dataset/train", "X_train.txt"),
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'value',
        strip.white = TRUE
    )

## 01a.2 Import Training Labels Data
y_train <-
    read.delim(
        here("ext/UCI HAR Dataset/train", "y_train.txt"),
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'activity_id'
    )
## 01a.3 Import Training Subject Data
subject_train <-
    read.delim(
        here("ext/UCI HAR Dataset/train", "subject_train.txt") ,
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'subject'
    )

## 01a.4 Combine Training Sets into Dataframe
train_dt <- cbind(subject_train,y_train,X_train) %>% as_tibble()

## 01a.5 Add column indicating dataset (i.e., training or test)
train_dt <- train_dt %>% mutate(
    dataset = 'train'
)
## 01a.6 Remove source files from environment
rm(subject_train,y_train,X_train)


# 01b Create Testing Dataset
## 01b.1 Import Testing Data
X_test <-
    read.delim(
        here("ext/UCI HAR Dataset/test", "X_test.txt"),
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'value',
        strip.white = TRUE
    )

## 01b.2 Import Testing Labels Data
y_test <-
    read.delim(
        here("ext/UCI HAR Dataset/test", "y_test.txt"),
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'activity_id'
    )
## 01b.3 Import testing Subject Data
subject_test <-
    read.delim(
        here("ext/UCI HAR Dataset/test", "subject_test.txt") ,
        header = FALSE,
        stringsAsFactors = FALSE,
        col.names = 'subject'
    )

## 01b.4 Combine Testing Sets into Dataframe
test_dt <- cbind(subject_test,y_test,X_test) %>% as_tibble()

## 01b.5 Add column indicating dataset (i.e., train or test)
test_dt <- test_dt %>% mutate(
    dataset = 'test'
)
## 01b.6 Remove source files
rm(subject_test,y_test,X_test)

# 01c Combine Test and Training Sets
data <- rbind(train_dt,test_dt)

# Clean up workspace
rm(train_dt,test_dt)

# 02 EXTRACT MEASUREMENTS ON MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT ---------------------------------------------------------------
# 02a Import features data
features <-
    read.delim(
        here("ext/UCI HAR Dataset", "features.txt"),
        sep = " ",
        header = FALSE,
        col.names = c('id', 'name'),
        strip.white = TRUE
    ) %>% as_tibble()

# Extract the measurements taken on the mean and standard deviation for each measurement
fid <- features$id[features$name %>% str_detect('angle',negate = TRUE) & features$name %>% str_detect("(mean)|(Mean)") | features$name %>% str_detect("(std)|(Std)")]

data_sub <- data %>%
    separate(value,
             into = paste0("V", features$id),
             sep = "\\s{1,}") %>% select(dataset,
                                         subject,
                                         activity_id,
                                         sprintf("V%s", fid))

rm(data,fid)
# 03 ADD DESCRIPTIVE ACTIVITY NAMES TO DATASET ####
data_sub <- data_sub %>% mutate(
    activity = case_when(
        activity_id == 1 ~ 'WALKING',
        activity_id == 2 ~ 'WALKING_UPSTAIRS',
        activity_id == 3 ~ 'WALKING_DOWNSTAIRS',
        activity_id == 4 ~ 'SITTING',
        activity_id == 5 ~ 'STANDING',
        activity_id == 6 ~ 'LAYING'
    )
) %>% select(dataset,subject,activity,starts_with("V"))

# 04 LABEL DATA WITH DESCRIPTIVE VARIABLE NAMES ####
data_sub <- data_sub %>%
    gather(key = "feature_id", value = "value", -c(dataset, subject, activity)) %>%
    mutate(feature_id = str_remove(feature_id, "V") %>% as.numeric()) %>%
    merge(features,by.x = 'feature_id', by.y = 'id') %>%
    mutate(feature = as.character(name),
           value = as.double(value)) %>%
    select(dataset,subject,activity,feature,value) %>%
    as_tibble()
rm(features)

# Appropriately labels the data set with descriptive variable names
data_sub <- data_sub %>% mutate(
    feature = str_replace(feature, "BodyBody", "Body"),
    feature = str_replace(feature, "Acc","Accl_"),
    feature = str_replace(feature, "Gyro","Gyro_"),
    feature = str_replace(feature, "Gravity","Grav"),
    feature = str_replace(feature, "\\-",""),
    feature = str_replace(feature, "mean","Mean"),
    feature = str_replace(feature, "std","Stdv"),
    feature = str_remove(feature, "\\("),
    feature = str_remove(feature, "\\)"),
    subject = as.factor(subject),
    activity = as.factor(activity)
) %>% as_tibble()

# 05 CREATE A SECOND INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND SUBJECT ####

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data <- data_sub %>% group_by(
    subject,activity,variable = feature
) %>% summarize(mean = mean(value))
rm(data_sub)
write_excel_csv(data,'data.csv')


