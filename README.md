# Getting and Cleaning Data Project
 An Course Project
 
 ------------
 FILES
 ------------
 
 run_analysis.R
 
 assignment.Rmd
 
 README.md
 
 summary.txt
 
 ------------
 NOTES - run_analysis.R
 ------------
 
 run_analysis.R should be within the folder of Samsung Data
 Example
 
 	UCI HAR Dataset
		run_analysis.R
		...
		test
			Inertial Signals
				...
			X_test.txt
			y_test.txt
			...
		train
			Inertial Signals
				...
			X_train.txt
			y_train.txt
			...

If not, then you must direct file path within the function.

------------
NOTES - assignment.Rmd
------------

This is a R markdown describing run_analysis.R and the process to
creating it.

------------
NOTES - summary.txt
------------

This is the ultimate product, the tidy data to be submitted.
Created using 
	write.table("table_name", "filename", row.names = FALSE)
