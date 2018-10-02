# Getting-and-Cleaning-Data-Project
This repository contains the following files:
1. README.md, this file, which provides an overview of the data set and how it was created.
2. tidy.txt, which contains the data set.
3. CodeBook.md, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
4. run_analysis.R, the R script that was used to create the data set (see the Creating the data set section below)

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges the two datasets
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.
