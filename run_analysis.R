# inladen activity labels
Activiteiten labels <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/activity_labels.txt")[,2]

# inladen columnnamen
columnnamen <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/features.txt")[,2]

# geef van elke waarde de standaardeviatie en de mean terug.
meanstd <- grepl("mean|std", columnnamen)

# Inladen x en y testdata en geef ze de juiste columnnamen mee
X_test <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/test/X_test.txt")
y_test <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/test/y_test.txt")
subject_test <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/test/subject_test.txt")

names(X_test) = columnnamen

# geef van elke waarde alleen de standaardeviatie en de mean terug.
X_test = X_test[,meanstd]

# activity labels koppelen aan de data 
y_test[,2] = Activiteiten labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# data samenvoegen
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Inladen x en y trainingsdata en geef ze de juiste columnnamen mee
X_train <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/train/X_train.txt")
y_train <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/train/y_train.txt")
subject_train <- read.table("file:///C:/Users/langeju/Desktop/Assignment 4/train/subject_train.txt")

names(X_train) = columnnamen

#  geef van elke waarde de standaardeviatie en de mean terug.
X_train = X_train[,meanstd]

# # activity labels koppelen aan de data
y_train[,2] = Activiteiten labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# samenvoegen data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# samenvoegen test en trainingsdata
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# aanroepen mean function door  gebruik te maken van dcast
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# Dataset wegschrijven naar c-schijf
write.table(tidy_data, file = ".......Assignment 4/Assingment 4.txt")
