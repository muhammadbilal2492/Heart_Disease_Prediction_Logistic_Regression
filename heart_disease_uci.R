# import data set
heart_disease_uci = read.csv("C:\\Users\\Hp\\Downloads\\heart_disease_uci.csv")

# Data cleaning
head(heart_disease_uci)
str(heart_disease_uci)
summary(heart_disease_uci)

# Check for missing values
colSums(is.na(heart_disease_uci))

# Check for Duplicates
duplicates = duplicated(heart_disease_uci)
duplicated(heart_disease_uci)

# Remove Duplicates
heart_disease_uci = heart_disease_uci[!duplicated(heart_disease_uci), ]
duplicates = duplicated(heart_disease_uci)
summary(heart_disease_uci)

# Drop unnecessary columns
heart_disease_uci = heart_disease_uci %>% select(-c(id,dataset))

# Exploratory Data Analysis
# Load tidyverse for data wrangling
library(tidyverse)
library(ggplot2)
library(geom)


# Histogram for Age
ggplot(heart_disease_uci, aes(x = age)) + 
  geom_histogram(binwidth = 1, fill = "blue", color = "white") + 
  labs(title = "Age Distribution", x = "Age", y = "Count")

# Histogram for Cholesterol
ggplot(heart_disease_uci, aes(x = chol)) + 
  geom_histogram(binwidth = 20, fill = "green", color = "white") + 
  labs(title = "Cholesterol Distribution", x = "Cholesterol", y = "Count")

# Boxplot for Age by Heart Disease Presence (target)
ggplot(heart_disease_uci, aes(x = factor(num), y = age)) + 
  geom_boxplot(fill = "lightblue") +
  labs(title = "Age Distribution by Heart Disease", x = "Heart Disease (0 = No, 1 = Yes)", y = "Age")

# Boxplot for Cholesterol by Heart Disease Presence
ggplot(heart_disease_uci, aes(x = factor(num), y = chol)) + 
  geom_boxplot(fill = "orange") + 
  labs(title = "Cholesterol Distribution by Heart Disease", x = "Heart Disease (0 = No, 1 = Yes)", y = "Cholesterol")

# correlation matrix
library(corrplot)

# Creating the correlation matrix
# Selecting only numeric columns for correlation
numeric_columns <- heart_disease_uci[sapply(heart_disease_uci, is.numeric)]

correlation_matrix <- cor(numeric_columns, use = "complete.obs")

# Plotting the correlation matrix
library(corrplot)
corrplot(correlation_matrix, method = "circle")

# identifying the unique values
unique(heart_disease_uci$num)

# Ensure num is binary (0 or 1)
heart_disease_uci$num = as.factor(heart_disease_uci$num)
unique(heart_disease_uci$num)

# Logistic Regression Model
model = glm(num ~ age + sex + cp + trestbps + chol + fbs + restecg + thalch + exang + oldpeak + slope + ca + thal,
            data = heart_disease_uci, family = "binomial")
summary(model)

# Load necessary libraries
library(caret)
library(pROC)
library(ggplot2)

# Set a random seed for reproducibility
set.seed(123)

# Split the data into training and testing sets
train_index <- createDataPartition(heart_disease_uci$num, p = 0.8, list = FALSE)
train_data <- heart_disease_uci[train_index, ]
test_data <- heart_disease_uci[-train_index, ]

# Fit the logistic regression model
modelT <- glm(num ~ age + sex + cp + trestbps + chol + fbs + restecg + thalch + exang + oldpeak + slope + ca + thal,
              data = train_data, family = "binomial")
summary(modelT)

# Exponential of coefficients
exp(coef(modelT))
exp(5.0127)

# Error occurs when the variable types (e.g., factor vs numeric)
# in the test data set are different from those in the training data set
# Ensure that test data columns have the SAME TYPE and SAME LEVELS as the training data4
# Convert categorical variables in test data to factors with the same levels as in train data
test_data$fbs   = factor(test_data$fbs, levels = levels(train_data$fbs))
test_data$exang = factor(test_data$exang, levels = levels(train_data$exang))
test_data$ca    = factor(test_data$ca, levels = levels(train_data$ca))
train_data$fbs   = factor(train_data$fbs)
train_data$exang = factor(train_data$exang)
train_data$ca    = factor(train_data$ca)

modelT <- glm(num ~ age + sex + cp + trestbps + chol + fbs + restecg + thalch +
                exang + oldpeak + slope + ca + thal,
              data = train_data, family = "binomial")

# Predict on Test Data
pred_probs <- predict(modelT, newdata = test_data, type = "response")

test_data$target <- ifelse(test_data$num == 0, 0, 1)
roc_curve <- roc(test_data$target, pred_probs)

# Ensure valid predictions
pred_probs <- predict(modelT, newdata = test_data, type = "response")