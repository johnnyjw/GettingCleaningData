<h1>Data collected from the accelerometers from the Samsung Galaxy S smartphone. </h1>

This repo consists of 3 files:

readme.md - a description of all the files#
codebook.md - a description of the output dataset produced in this assignment
run_analysis.R  - the script that produces the output dataset

The script works as follows:

Phone data file was manually collected and unpacked into the working directory from this location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The Script performs the following steps:
1)Import and combine data and labels.
2)Limit the data utilised to mean and standard deviations.
3)Add a variable that provides a descriptive value for the activity measured on each row.
4)Perform mean summary on all values by subject and activity and produce a summary table of these.
5)Outputs the new table to "TidyDataSet.txt"