#This script include initial and main analyses for the STATS506 group project.
#Project title: "Does working overtime predict abnormal blood pressure?"
#Author: Hyesue Jang
#Last modified: 12/05/2019

rm(list=ls())
library(dplyr)
library(tidyr) #for drop_na() function
library(nlme)

#data cleaning ----------------------------------------------
#read in data
df = read.csv("~/Box/HJ_main/2_Courses/STATS 506/Group Project/hyesue/data/final_data.csv")

#names(df)
df = df %>% 
  mutate(
    #factor categorical variables
    gender = factor(df$gender, 
                    levels = c(1,2), 
                    labels = c("male","female")),
    alcohol_unit = factor(df$alcohol_unit,
                          levels = c(1,2,3),
                          labels = c("week", "month", "year")),
    smoke = factor(df$smoke,
                   levels = c(1,2),
                   labels = c("Smoked", "NotSmoked")),
    #compute overtime variable
    overtime = ifelse(workhrs > 40, 1, 0),
    #compute average BP measures
    SBP = rowMeans(cbind(BPXSY1, BPXSY2, BPXSY3, BPXSY4), na.rm = T),
    DBP = rowMeans(cbind(BPXDI1, BPXDI2, BPXDI3, BPXDI4), na.rm = T),
    #compute abnormal BP variables
    SBP_bi = ifelse(SBP < 140, 0, 1),
    DBP_bi = ifelse(DBP < 90, 0, 1)) %>%
  drop_na(c("SBP", "DBP"))

#remove those with incomplete BP measures 
df = quantable::removeNArows(df, 2)

#recode alcohol variables
#measure of units differ by respondent (week, month, year)
df$alcohol_adj = df$alcohol
df$alcohol_adj[df$alcohol_unit == "month"] = df$alcohol_adj[df$alcohol_unit == "month"] / 4.345 #divide by average weeks per month
df$alcohol_adj[df$alcohol_unit == "year"] = df$alcohol_adj[df$alcohol_unit == "year"] / 52.143 #divide by average weeks per year

#preliminary analyses ---------------------------------------
#descriptive stats
psych::describe(df)

#test the assumptions for the linear regression
#assumption1) normality assumption: check if the continuous variables are normal
#DVs
hist(df$SBP)
hist(df$DBP)
#IVs
hist(df$age)
hist(df$bmi)
hist(df$sleep)
hist(df$alcohol_adj)

#check the distributions
hist(df$overtime)
hist(df$SBP_bi)
hist(df$DBP_bi)

#assumption2) consistent variances
#for SBP
pairs(SBP ~ overtime + gender + age + bmi +
        alcohol_adj + sleep + smoke, data = df)
#for DBP
pairs(DBP ~ overtime + gender + age + bmi + 
        alcohol_adj + sleep + smoke, data = df)

#assumption3) linearity
#first fit a linear regression with all covariates
prelim_SBP = lm(SBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
prelim_DBP = lm(DBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
#then see the added variable plots
car::avPlots(prelim_SBP) #for SBP
car::avPlots(prelim_DBP) #for DBP

#standardized residuals plots (SBP)
SBP_red = rstandard(prelim_SBP)
fitted_SBP = prelim_SBP$fitted.values

plot(fitted_SBP, SBP_red, xlab = "Fitted Values", 
     ylab = "Standardized Residuals", 
     main = "Standardized Residuals Plot (SBP)")

#standardized residuals plots (DBP)
DBP_red = rstandard(prelim_DBP)
fitted_DBP = prelim_DBP$fitted.values

plot(fitted_DBP, DBP_red, xlab = "Fitted Values", 
     ylab = "Standardized Residuals", 
     main = "Standardized Residuals Plot (DBP)")

#assumption4) multicollinearity
#collinearity for continuous variables
cont_df = df %>% 
  select(age, bmi, alcohol_adj, sleep)
cor(cont_df) 
#correlation coefficients have small values

#collinearity for categorical variables
cate_df = df %>%
  select(gender, smoke, overtime)
chisq.test(cate_df$gender, cate_df$smoke)
chisq.test(cate_df$gender, cate_df$overtime)
chisq.test(cate_df$smoke, cate_df$overtime)
#no significant associations

#lastly, vif can be additionally checked for collinearity
car::vif(prelim_SBP)
car::vif(prelim_DBP)
#VIF suggests that there is collinearity is not problematic.
#rule of thumb: less than 1 = not correlated; 1-5 = moderately correlated


#core analysis ----------------------------------------------
#linear regression with "overtime" as the main predictor
model_SBP = gls(SBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
summary(model_SBP)
model_DBP = gls(DBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
summary(model_DBP)

#additional analysis ----------------------------------------
#logistic regression with normal vs. abnormal BP outcome
logistic_SBP <- glm(SBP_bi ~ overtime + gender + age + bmi + 
                      alcohol_adj + sleep + smoke,
                    family = binomial(link = 'logit'),
                    data = df)
summary(logistic_SBP)


logistic_DBP <- glm(DBP_bi ~ overtime + gender + age + bmi + 
                      alcohol_adj + sleep + smoke,
                    family = binomial(link = 'logit'),
                    data = df)
summary(logistic_DBP)