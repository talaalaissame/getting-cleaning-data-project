# Run_analysis.R - Coursera Project
library(dplyr)

# تحميل البيانات إذا مش موجودة
if (!file.exists("UCI HAR Dataset")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                "data.zip")
  unzip("data.zip")
  cat("✅ تم تحميل البيانات\n")
}

# الخطوة 1: دمج بيانات التدريب والاختبار
cat("جاري دمج البيانات...\n")
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
merged_x <- rbind(train_x, test_x)

train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
merged_y <- rbind(train_y, test_y)

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
merged_subject <- rbind(train_subject, test_subject)

# الخطوة 2: استخراج المتوسط والانحراف المعياري
cat("جاري استخراج المتوسط والانحراف المعياري...\n")
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features[,2])
extracted_data <- merged_x[, mean_std_indices]
names(extracted_data) <- features[mean_std_indices, 2]

# الخطوة 3: تنظيف أسماء المتغيرات
cat("جاري تنظيف أسماء المتغيرات...\n")
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("-mean\\(\\)", "Mean", names(extracted_data))
names(extracted_data) <- gsub("-std\\(\\)", "Std", names(extracted_data))
names(extracted_data) <- gsub("[-()]", "", names(extracted_data))

# الخطوة 4: استخدام أسماء الأنشطة الوصفية
cat("جاري إضافة أسماء الأنشطة...\n")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
extracted_data$Activity <- factor(merged_y[,1], 
                                  levels = activity_labels[,1],
                                  labels = activity_labels[,2])
extracted_data$Subject <- merged_subject[,1]

# الخطوة 5: إنشاء مجموعة البيانات المرتبة
cat("جاري إنشاء البيانات المرتبة...\n")
tidy_data <- extracted_data %>%
  group_by(Subject, Activity) %>%
  summarise(across(everything(), mean))

# حفظ البيانات
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
cat("✅ تم الانتهاء بنجاح!\n")
cat("📁 الملف المحفوظ: tidy_data.txt\n")
cat("📊 أبعاد البيانات:", dim(tidy_data), "\n")
cat("👥 عدد الموضوعات:", length(unique(tidy_data$Subject)), "\n")
cat("🎯 عدد الأنشطة:", length(unique(tidy_data$Activity)), "\n")