This is my week4 project for "Components of Tidy Data"

The Codebook can be found in Codebook.md

The run_analysis.R file will run all required data. It assumes that the plyr package is installed. This script will download required data and output a file called output_data.txt with the averages of all means and std deviations aggregated by subject and activity.


The script will download data and then write a file storing the timestamp when data were downloaded. Next, it reads the training and test data adding labels as needed. It merges those data sets and then performs some joins to get a single data frame with all required information. Finally, it performs some aggreagation and outputs a table.

Data used come from:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
