# Codebook for Human Activity Recognition

## Study Design
The experiments were carried out with 30 volunteers aged 19-48 years wearing Samsung Galaxy S II smartphones on their waist.

## Data Source
UCI Machine Learning Repository - Human Activity Recognition Using Smartphones
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables
- Subject: Integer (1-30) - Unique identifier for each participant
- Activity: Factor with 6 levels - Type of activity performed

### Activity Labels:
1. WALKING
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

## Processing Steps:
1. Merged training and test sets
2. Extracted only mean and standard deviation measurements
3. Used descriptive activity names
4. Appropriately labeled variables with descriptive names
5. Created independent tidy data set with averages for each variable per activity per subject
