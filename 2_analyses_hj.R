
#This script include initial and main analyses for the STATS506 group project.
#"Does working overtime predict abnormal blood pressure?"
#Author: Hyesue Jang

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
#for SPB
pairs(SBP ~ overtime + gender + age + bmi +
        alcohol_adj + sleep + smoke, data = df)
#for DBP
pairs(DBP ~ overtime + gender + age + bmi + 
        alcohol_adj + sleep + smoke, data = df)

#assumption3) linearity
#first fit a linear regression with all covariates
avplot_SBP = lm(SBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
avplot_DBP = lm(DBP ~ overtime + gender + age + bmi + 
                  alcohol_adj + sleep + smoke, data = df)
#then see the added variable plots
car::avPlots(avplot_SBP) #for SBP
car::avPlots(avplot_DBP) #for DBP

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