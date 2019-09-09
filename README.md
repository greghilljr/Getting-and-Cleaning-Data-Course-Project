README
================

Getting and Cleaning Data Course Project
========================================

Overview
--------

The goal is to prepare tidy data that can be used for later analysis. Requirements include:

1.  a tidy data set as described below,
2.  a link to a Github repository with your script for performing the analysis, and
3.  a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md
4.  a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

Dataset
-------

The dataset to be operated on represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The data for this project are accessible here: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The single R script *run\_analysis.R* included here does the following:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
