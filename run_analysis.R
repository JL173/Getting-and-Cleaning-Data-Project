run_analysis <- function(){

  library(tidyverse)

  # load name data
  full_names_df <- read.csv("features.txt", sep=" ", header = FALSE)

  # contains all mean/std feature_names with index
  mean_std_df <- full_names_df %>% filter(grepl("mean|std", V2))

  # replacement vectors for renaming the features
  name_find <- c("^f", "^t", "Acc", "Body",
                 "Gravity","Jerk","Gyro",
                 "Mag", "-mean\\(\\)",
                 "-std\\(\\)", "-meanFreq\\(\\)",
                 "\\-")

  name_replace <- c("frequency_", "time_", "acceleration_", "body_",
                    "gravity_","jerk_", "gyroscope_",
                    "magnitude_", "mean",
                    "standard_deviation", "mean_frequency",
                    "\\_")

  # clean list of mean/std feature names
  clean_mean_std_names <- mean_std_df

  for(index in 1:11){
    clean_mean_std_names$V2 <- gsub(name_find[index],
                                    name_replace[index],
                                    clean_mean_std_names$V2)
  }

  # load training data
  y_train_df <- read.csv("train/y_train.txt",
                         sep = " ", header = FALSE,
                         col.names = c("Activity"))

  subject_train_df <- read.csv("train/subject_train.txt",
                               sep = " ", header = FALSE,
                               col.names = c("ID"))

  X_train_df <- read.csv("train/X_train.txt",
                         sep="", header=FALSE,
                         col.names = full_names_df$V2)

  # select mean_std columns by name index
  train_mean_std <- X_train_df %>%
    select(mean_std_df$V1)

  # replace column names with clean names
  colnames(train_mean_std) <- clean_mean_std_names$V2

  # combine the three dataframes
  clean_train <- cbind(subject_train_df, y_train_df) %>%
    cbind(train_mean_std)


  # load testing data
  y_test_df <- read.csv("test/y_test.txt",
                        sep = " ", header = FALSE,
                        col.names = c("Activity"))

  subject_test_df <- read.csv("test/subject_test.txt",
                              sep = " ", header = FALSE,
                              col.names = c("ID"))

  X_test_df <- read.csv("test/X_test.txt",
                        sep="", header=FALSE,
                        col.names = full_names_df$V2)

  # select mean_std columns by name index
  test_mean_std <- X_test_df %>%
    select(mean_std_df$V1)

  # replace column names with clean names
  colnames(test_mean_std) <- clean_mean_std_names$V2

  # combine the three dataframes
  clean_test <- cbind(subject_test_df, y_test_df) %>%
    cbind(test_mean_std)

  # combine train and test dataframes
  clean_df <- rbind(clean_train, clean_test)

  clean_summary <- clean_df %>%
    group_by(Activity, ID) %>%
    summarise(across(everything(), mean))
  

  # remove temporary files, leaving only the two needed
  remove(test_mean_std, X_test_df, subject_test_df,
         y_test_df, clean_train, train_mean_std,
         X_train_df, subject_train_df, y_train_df,
         clean_test, full_names_df, index, mean_std_df,
         clean_mean_std_names, name_find, name_replace)
  
  # return the last dataframe
  clean_summary
  
}