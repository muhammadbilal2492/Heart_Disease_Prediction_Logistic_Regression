# Heart_Disease_Prediction_Logistic_Regression

Tools & Technologies
- R
- RStudio
- Packages: `dplyr`, `ggplot2`, `caret`

 ## Key Steps
1. Data Cleaning: Handled missing values and standardized variable formats.
2. Exploratory Data Analysis (EDA): Identified trends, patterns, and correlations using visualizations.
3. Modeling: Built a logistic regression model to classify heart disease presence.
4. Evaluation: Assessed model performance using accuracy, confusion matrix, ROC curve, and AUC score.
5. Visualization: Used `ggplot2` to plot insights and model diagnostics.

   
Introduction:
Heart disease remains one of the leading causes of death globally, accounting for millions of fatalities each year. The increasing prevalence of cardiovascular diseases underscores the need for efficient early detection and preventative measures.
In the modern healthcare landscape, predictive analytics and statistical modeling have emerged as powerful tools to augment clinical decision-making.
Logistic regression, in particular, offers a robust framework for modeling binary outcomes, such as the presence or absence of heart disease.
The present report delves into the development and evaluation of a logistic regression model designed to predict heart disease based on a range of clinical and demographic features.
The motivation for this analysis is twofold: first, to explore the relationships between cardiovascular risk factors and disease onset, and second, to evaluate the efficacy of logistic regression as a predictive model in this context.
This study utilizes a widely accepted UCI dataset, containing observations across variables such as age, sex, chest pain type, cholesterol levels, blood pressure, and more.
By systematically analyzing these features, we aim to identify the most statistically significant predictors and provide healthcare practitioners with valuable insights that can improve diagnostic accuracy and potentially inform preventive strategies.
The scope of this report includes a detailed methodology, model specification, training/testing procedures, result interpretation, and final recommendations based on statistical outputs.


Data Description and Exploration:
The dataset used for this study originates from the UCI Machine Learning Repository. It consists of 303 records and 14 attributes including demographic, clinical, and biological measurements.
The key variables are:

age: Age of the patient
sex: Gender (1 = male; 0 = female)
cp: Chest pain type (4 values)
trestbps: Resting blood pressure
chol: Serum cholesterol in mg/dl
fbs: Fasting blood sugar > 120 mg/dl (1 = true; 0 = false)
restecg: Resting electrocardiographic results (values 0,1,2)
thalach: Maximum heart rate achieved
exang: Exercise-induced angina
oldpeak: ST depression induced by exercise
slope: The slope of the peak exercise ST segment
ca: Number of major vessels (0–3) colored by fluoroscopy
thal: Thalassemia (3 = normal; 6 = fixed defect; 7 = reversible defect)

The target variable is 'num', which indicates the presence (1) or absence (0) of heart disease.
This variable was originally a multi-class variable but was transformed into a binary classification problem for this analysis.
Initial exploration revealed that the dataset contained missing values particularly in 'ca' and 'thal'.
We opted for complete case analysis by removing rows with missing data to ensure model consistency.
The age variable displayed a slight right skew, and categorical variables such as 'cp' and 'thal' had uneven distributions, which may affect model variance.

Methodology:
A logistic regression model was used for classification since the response variable 'num' is binary. The model was trained on 80% of the data using stratified sampling to ensure class balance and tested on the remaining 20%.
All predictor variables were included in the model: age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, and thal.
Categorical variables were encoded appropriately, and numeric variables were left as-is. The model used a binomial family with a logit link function.
Model performance was evaluated using residual deviance and AIC. The summary output provided p-values for each coefficient to assess statistical significance.
An odds ratio analysis was performed to interpret the effect of each variable on heart disease risk.
The logistic regression model is interpretable and provides a probabilistic understanding of the impact of each variable, which is beneficial in clinical decision-making contexts.

Results:
Key findings from the model summary include:
sexMale (p = 0.028): Males had significantly higher odds of heart disease
cpnon-anginal (p < 0.001): A protective factor with lower disease odds
cptypical angina (p = 0.0077): Also indicated reduced odds
ca (p < 0.001): More vessels colored by fluoroscopy were linked to higher disease risk
oldpeak (p ≈ 0.058): Marginally significant positive relationship with disease

The null deviance was 331.64 on 239 degrees of freedom and residual deviance was reduced to 158.12 on 221 degrees of freedom.
This indicates a substantial improvement in model fit. The AIC value was 196.12, which supports the relative strength of the model.

Interpretation of Results:
The interpretation of logistic regression coefficients using odds ratios indicated that male patients, those with higher oldpeak values, and higher vessel counts were more likely to have heart disease.
Meanwhile, non-anginal chest pain and typical angina appeared protective.
The clinical implications are consistent with medical literature: ST depression and vessel blockage are significant risk factors, while certain chest pain types may correspond with less severe conditions.
However, the model also showed that variables such as cholesterol and fasting blood sugar were not statistically significant, highlighting the importance of multivariate analysis instead of univariate assumptions.

Model Evaluation and Validation:
Although logistic regression is interpretable, evaluating its performance on unseen data is critical. Below are the results on the test dataset:
· Accuracy: 84%
· Sensitivity: 81%
· Specificity: 85%
· ROC-AUC: 0.89
These metrics indicate a good balance between true positives and true negatives, suitable for a diagnostic setting.
A ROC curve plot and confusion matrix can further illustrate performance.

Conclusion:
Logistic regression is a powerful yet interpretable model for binary classification. This analysis demonstrated how routine clinical variables can be used to build predictive models for heart disease.
The findings provide clear insights into which factors are most strongly associated with disease presence.
While the model fit was strong, further steps such as variable transformation, interaction terms, and alternative modeling techniques (like random forest or XGBoost) could be explored.
Using techniques such as k-fold cross-validation and hyperparameter tuning may further improve generalization.
