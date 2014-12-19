library(data.table)

DATA_PATH = 'UCI HAR Dataset'

read.data <- function(fname, ..., data_path = DATA_PATH){
    read.table(paste(DATA_PATH, fname, sep = "/"), ...)
}

raw_test <- read.data('test/X_test.txt')
raw_train <- read.data('train/X_train.txt')
raw_subj_test <- read.data('test/subject_test.txt')
raw_subj_train <- read.data('train/subject_train.txt')
raw_labels_test <- read.data('test/y_test.txt')
raw_labels_train <- read.data('train/y_train.txt')
raw_labels_name <- read.data('activity_labels.txt', col.names = c('id', 'name'))

# activity name by label id
actv_name <- function(id){
    raw_labels_name$name[raw_labels_name$id[id]]
}

raw_total <- rbind(cbind(subject_id = raw_subj_test[, 1], is_train = 0,
                         activity = actv_name(raw_labels_test[, 1]),
                         raw_test), 
                   cbind(subject_id = raw_subj_train[, 1], is_train = 1,
                         activity = actv_name(raw_labels_train[, 1]),
                         raw_train))
# free unused objects
rm(raw_test, raw_train, raw_subj_test, raw_subj_train, 
   raw_labels_test, raw_labels_train)

# read features (columns) names from file
raw_features <- read.data('features.txt', col.names = c('id', 'name'))
features_filter <- raw_features$name %like% '.*(mean|std)\\(\\)'

prep_total <- raw_total[, c(TRUE, TRUE, TRUE, features_filter)]
rm (raw_total)

feature_name <- function(code){
    gsub('[,-]', "_", gsub('[\\(\\)]', "", code))
}
features <- feature_name(raw_features$name[features_filter])
colnames(prep_total) <- c(colnames(prep_total)[1:3], features)

# create tidy data set.
# group by subject_id, activity
tidy_data <- aggregate(x = prep_total[, features], 
                by = list(subject_id = prep_total$subject_id, 
                          activity = prep_total$activity), 
                FUN = "mean")

# write out result
write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE)
