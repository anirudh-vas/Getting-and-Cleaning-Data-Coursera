# Getting-and-Cleaning-Data-Coursera
Coursera Course Project for getting and Cleaning Data

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Description of the project 
The task was to transform the original dataset into a clean and tidy dataset.
The test and train sets are merged into a single file and the indentifiers that specify the data identity such as  subject identifiers and activity labels are added to the dataset to add meaning the the variable set in the data. The integer based activity identifiers were translated into human-readable names. The mean and standard deviation variables were retained from the 500+ variables. Those variables were further summarized by taking their mean for each subject/activity pair. 

The tidy data set is named UCI_HAR_Tidy_Data.csv, which can be read into R with read.csv("UCI_HAR_Tidy_Data.csv"). 
The description of the dataset in detail can be found in the CodeBook.md 

The basic naming convention is:
Mean{timeOrFreq}{measurement}{meanOrStd}{XYZ}

Where timeOrFreq indicates whether the measurement comes from the time or frequency domain.
measurement is one of the original measurement features,
meanOrStd indicates whether the measurement is aggregated as a mean or standard deviation variable, 
and XYZ indicates the axis along which the measurement was taken, or nothing, for magnitude measurements.
