
## Getting And Cleaning Data Project

This project is for Getting and Cleaning Data of Coursera.
The run_analysis.R code performs the following:
1. Creates the GettingData directory if it does not exist
2. Downloads the dataset into the GettingData directory, then unzip it
3. Loads the test and train datasets and merges them (by rows)
4. Set descriptive column names and set column names for activity and subject
5. Merge the 3 files above by columns
6. Keep only the columsn related to Mean and Standard Deviation
7. Creates an ID out of activity and subject columns 
8. Creates the tidy dataset that consists of the average (mean) value of each variable for each subject and activity combination
9. Writes the end result is written to the file tidy.txt.