Codebook
================

Overview
--------

This data reflect the results of experiments carried out by a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on their waist. Using the phone's embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity data were captured and labeled using observations from video-recordings of subject activities.

Accelerometer and gyroscope data were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter to differentiate between body acceleration (movement) and the force of gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The run\_analysis.R script performs the data preparation required by the project brief as articulated in the associated README file.

Datafields
----------

-   `subject`:
    -   An identifier of the subject who performed the activity for each window sample. Its range is from 1 to 30.
-   `activity`:
    -   Classifications of activities conducted by subjects. Allowable values are limited to the following:
        -   `LAYING`
        -   `SITTING`
        -   `STANDING`
        -   `WALKING`
        -   `WALKING_DOWNSTAIRS`
        -   `WALKING_UPSTAIRS`
-   `variable`: Variables reflect extracts of only the measurements on the mean and standard deviation for each measurement in the source data set and may be identified by "Mean" and "Stdv" tags within the variable's name. Variables include the following:

<!-- -->

    ##  [1] "fBodyAccl_JerkMagMean"     "fBodyAccl_JerkMagMeanFreq"
    ##  [3] "fBodyAccl_JerkMagStdv"     "fBodyAccl_JerkMean-X"     
    ##  [5] "fBodyAccl_JerkMean-Y"      "fBodyAccl_JerkMean-Z"     
    ##  [7] "fBodyAccl_JerkMeanFreq-X"  "fBodyAccl_JerkMeanFreq-Y" 
    ##  [9] "fBodyAccl_JerkMeanFreq-Z"  "fBodyAccl_JerkStdv-X"     
    ## [11] "fBodyAccl_JerkStdv-Y"      "fBodyAccl_JerkStdv-Z"     
    ## [13] "fBodyAccl_MagMean"         "fBodyAccl_MagMeanFreq"    
    ## [15] "fBodyAccl_MagStdv"         "fBodyAccl_Mean-X"         
    ## [17] "fBodyAccl_Mean-Y"          "fBodyAccl_Mean-Z"         
    ## [19] "fBodyAccl_MeanFreq-X"      "fBodyAccl_MeanFreq-Y"     
    ## [21] "fBodyAccl_MeanFreq-Z"      "fBodyAccl_Stdv-X"         
    ## [23] "fBodyAccl_Stdv-Y"          "fBodyAccl_Stdv-Z"         
    ## [25] "fBodyGyro_JerkMagMean"     "fBodyGyro_JerkMagMeanFreq"
    ## [27] "fBodyGyro_JerkMagStdv"     "fBodyGyro_MagMean"        
    ## [29] "fBodyGyro_MagMeanFreq"     "fBodyGyro_MagStdv"        
    ## [31] "fBodyGyro_Mean-X"          "fBodyGyro_Mean-Y"         
    ## [33] "fBodyGyro_Mean-Z"          "fBodyGyro_MeanFreq-X"     
    ## [35] "fBodyGyro_MeanFreq-Y"      "fBodyGyro_MeanFreq-Z"     
    ## [37] "fBodyGyro_Stdv-X"          "fBodyGyro_Stdv-Y"         
    ## [39] "fBodyGyro_Stdv-Z"          "tBodyAccl_JerkMagMean"    
    ## [41] "tBodyAccl_JerkMagStdv"     "tBodyAccl_JerkMean-X"     
    ## [43] "tBodyAccl_JerkMean-Y"      "tBodyAccl_JerkMean-Z"     
    ## [45] "tBodyAccl_JerkStdv-X"      "tBodyAccl_JerkStdv-Y"     
    ## [47] "tBodyAccl_JerkStdv-Z"      "tBodyAccl_MagMean"        
    ## [49] "tBodyAccl_MagStdv"         "tBodyAccl_Mean-X"         
    ## [51] "tBodyAccl_Mean-Y"          "tBodyAccl_Mean-Z"         
    ## [53] "tBodyAccl_Stdv-X"          "tBodyAccl_Stdv-Y"         
    ## [55] "tBodyAccl_Stdv-Z"          "tBodyGyro_JerkMagMean"    
    ## [57] "tBodyGyro_JerkMagStdv"     "tBodyGyro_JerkMean-X"     
    ## [59] "tBodyGyro_JerkMean-Y"      "tBodyGyro_JerkMean-Z"     
    ## [61] "tBodyGyro_JerkStdv-X"      "tBodyGyro_JerkStdv-Y"     
    ## [63] "tBodyGyro_JerkStdv-Z"      "tBodyGyro_MagMean"        
    ## [65] "tBodyGyro_MagStdv"         "tBodyGyro_Mean-X"         
    ## [67] "tBodyGyro_Mean-Y"          "tBodyGyro_Mean-Z"         
    ## [69] "tBodyGyro_Stdv-X"          "tBodyGyro_Stdv-Y"         
    ## [71] "tBodyGyro_Stdv-Z"          "tGravAccl_MagMean"        
    ## [73] "tGravAccl_MagStdv"         "tGravAccl_Mean-X"         
    ## [75] "tGravAccl_Mean-Y"          "tGravAccl_Mean-Z"         
    ## [77] "tGravAccl_Stdv-X"          "tGravAccl_Stdv-Y"         
    ## [79] "tGravAccl_Stdv-Z"

-   `mean`: Calculated mean of signal data derived from source data set relateive to subject, activity, and variable fields.

Parsing Variable Names
----------------------

Read from left to right, variable names may be parsed thusly:

-   `Domain`: length: 1; options: `f` (frequency) or `t` (time)
-   `Force`: length: 4; options: `Body` (i.e., movement initiated by the subject) or `Grav` (i.e., signals indicating the effect of Gravity on sensor data)
-   `Source`: length: 4; options: `Accl` (i.e., data obtained from Accelerometer signals) or `Gyro` (i.e., data obtained from Gyroscope)
-   `Type`: length: 4; options: `Jerk` or absent. Linear acceleration and angular velocity were derived across the time domain to determine `Jerk` signals. If missing (i.e., not `Jerk`), movement is presumed to be customary / standard.
-   `Magnitude`: length: 3; options: `Mag` (i.e., Magnitude) or absent.
-   `Calculation`: length: 4 - 8; options: `Mean`,`MeanFreq`, or `Stdv` (i.e., Standard Deviation).
-   `Axis`: length: 1; options: `X`,`Y`, `Z` or absent.

Transformations
---------------

-   variables names containing "BodyBody" adjusted (second "Body" removed)
-   Additional changes to improve readability and reference include:
    -   Acc changed to "Accl"
    -   Gravity changed to "Grav"
    -   Calculation tags changed to title case
    -   Underscore added for readability following Force tag
