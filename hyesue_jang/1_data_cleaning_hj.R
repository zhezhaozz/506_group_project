#This script include data cleaning process for the STATS506 group project.
#The dplyr package is used for data cleaning.
#Author: Hyesue Jang
#Acknowledgement: Zhe Zhao

library(haven) #for reading XPT files
library(dplyr)
library(tidyr)

#According to the analytical guideline of NHANES Examination Survey,
#it is recommended that researchers include at least 4 years data 
#to produce sufficient estimation sample size. Therefore, we used 
#three two-year cycle data sets: 2011-2012, 2013-2014, and 2015-2016

#download data -------------------------------------------
#2011-2012
demog11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/DEMO_G.XPT')
bp11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BPX_G.XPT')
bm11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BMX_G.XPT')
alc11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/ALQ_G.XPT')
occupation11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/OCQ_G.XPT')
sleep11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/SLQ_G.XPT')
smoke11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/SMQRTU_G.XPT')
take_pre11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BPQ_G.XPT')

#2013-2014
demog13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DEMO_H.XPT')
bp13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPX_H.XPT')
bm13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BMX_H.XPT')
alc13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.XPT')
occupation13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OCQ_H.XPT')
sleep13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SLQ_H.XPT')
smoke13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SMQRTU_H.XPT')
take_pre13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPQ_H.XPT')

#2015-2016
demog15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DEMO_I.XPT')
bp15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BPX_I.XPT')
bm15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BMX_I.XPT')
alc15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/ALQ_I.XPT')
occupation15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/OCQ_I.XPT')
sleep15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/SLQ_I.XPT')
smoke15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/SMQRTU_I.XPT')
take_pre15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BPQ_I.XPT')


#join variables -------------------------------------------
#2011-2012
demog11 = as.data.frame(demog11)
bp11 = as.data.frame(bp11)
bm11 = as.data.frame(bm11)
alc11 = as.data.frame(alc11)
occupation11 = as.data.frame(occupation11)
sleep11 = as.data.frame(sleep11)
smoke11 = as.data.frame(smoke11)
take_pre11 = as.data.frame(take_pre11)


df11 = demog11 %>% 
  left_join(bp11, by = 'SEQN') %>%
  left_join(bm11, by = 'SEQN') %>%
  left_join(alc11, by = 'SEQN') %>%
  left_join(occupation11, by = 'SEQN') %>%
  left_join(sleep11, by = 'SEQN') %>%
  left_join(smoke11, by = 'SEQN') %>%
  left_join(take_pre11, by = 'SEQN')

#2013-2014
demog13 = as.data.frame(demog13)
bp13 = as.data.frame(bp13)
bm13 = as.data.frame(bm13)
alc13 = as.data.frame(alc13)
occupation13 = as.data.frame(occupation13)
sleep13 = as.data.frame(sleep13)
smoke13 = as.data.frame(smoke13)
take_pre13 = as.data.frame(take_pre13)

df13 = demog13 %>% 
  left_join(bp13, by = 'SEQN') %>%
  left_join(bm13, by = 'SEQN') %>%
  left_join(alc13, by = 'SEQN') %>%
  left_join(occupation13, by = 'SEQN') %>%
  left_join(sleep13, by = 'SEQN') %>%
  left_join(smoke13, by = 'SEQN') %>%
  left_join(take_pre13, by = 'SEQN')

#2015-2016
demog15 = as.data.frame(demog15)
bp15 = as.data.frame(bp15)
bm15 = as.data.frame(bm15)
alc15 = as.data.frame(alc15)
occupation15 = as.data.frame(occupation15)
sleep15 = as.data.frame(sleep15)
smoke15 = as.data.frame(smoke15)
take_pre15 = as.data.frame(take_pre15)

df15 = demog15 %>% 
  left_join(bp15, by = 'SEQN') %>%
  left_join(bm15, by = 'SEQN') %>%
  left_join(alc15, by = 'SEQN') %>%
  left_join(occupation15, by = 'SEQN') %>%
  left_join(sleep15, by = 'SEQN') %>%
  left_join(smoke15, by = 'SEQN') %>%
  left_join(take_pre15, by = 'SEQN')


#data cleaning -------------------------------------------
#2011-2012
df11 = df11 %>%
  #age ranges from 18 to 60
  filter(RIDAGEYR >= 18 & RIDAGEYR <= 60) %>%
  #work at a job or business. Eliminating non-working group
  filter(OCD150 == 1) %>%
  #remove people who are now taking prescription for hyper-blood-pressure
  filter(BPQ050A != 1 & is.na(BPQ050A) == FALSE) %>%
  #remove observations where unit of alcohol drink is missing
  filter(is.na(ALQ120U) == FALSE) %>%
  #choose variables interested 
  transmute(id = SEQN,
            gender = RIAGENDR, 
            age = RIDAGEYR, 
            race = RIDRETH3,
            bmi = BMXBMI, 
            BPXSY1, BPXDI1, #1st BP measures 
            BPXSY2, BPXDI2, #2nd BP measures 
            BPXSY3, BPXDI3, #3rd BP measures
            BPXSY4, BPXDI4, #4th BP measures (optional)
            alcohol = ALQ120Q,
            alcohol_unit = ALQ120U,
            sleep = SLD010H, 
            smoke = SMQ680, 
            workhrs = OCQ180) %>%
  #remove missing values
  #except for the optional BPXSY4, BPXDI4 variables
  drop_na(-c("BPXSY1", "BPXDI1", 
             "BPXSY2", "BPXDI2",
             "BPXSY3", "BPXDI3",
             "BPXSY4", "BPXDI4")) %>% 
  #finally, add survey_year as variable
  #this will be used for testing random effects later
  mutate(survey_year = "2011-2012")

#2013-2014
df13 = df13 %>%
  #age ranges from 18 to 60
  filter(RIDAGEYR >= 18 & RIDAGEYR <= 60) %>%
  #work at a job or business. Eliminating non-working group
  filter(OCD150 == 1) %>%
  #remove people who are now taking prescription for hyper-blood-pressure
  filter(BPQ050A != 1 & is.na(BPQ050A) == FALSE) %>%
  #remove observations where unit of alcohol drink is missing
  filter(is.na(ALQ120U) == FALSE) %>%
  #choose variables interested 
  transmute(id = SEQN,
            gender = RIAGENDR, 
            age = RIDAGEYR, 
            race = RIDRETH3,
            bmi = BMXBMI, 
            BPXSY1, BPXDI1, #1st BP measures 
            BPXSY2, BPXDI2, #2nd BP measures 
            BPXSY3, BPXDI3, #3rd BP measures
            BPXSY4, BPXDI4, #4th BP measures (optional)
            alcohol = ALQ120Q, 
            alcohol_unit = ALQ120U,
            sleep = SLD010H, 
            smoke = SMQ681, 
            workhrs = OCQ180) %>%
  #remove missing values
  #except for the optional BPXSY4, BPXDI4 variables
  drop_na(-c("BPXSY1", "BPXDI1", 
             "BPXSY2", "BPXDI2",
             "BPXSY3", "BPXDI3",
             "BPXSY4", "BPXDI4")) %>% 
  #finally, add survey_year as variable
  #this will be used for testing random effects later
  mutate(survey_year = "2013-2014")

#2015-2016
df15 = df15 %>%
  #age ranges from 18 to 60
  filter(RIDAGEYR >= 18 & RIDAGEYR <= 60) %>%
  #work at a job or business. Eliminating non-working group
  filter(OCD150 == 1) %>%
  #remove people who are now taking prescription for hyper-blood-pressure
  filter(BPQ050A != 1 & is.na(BPQ050A) == FALSE) %>%
  #remove observations where unit of alcohol drink is missing
  filter(is.na(ALQ120U) == FALSE) %>%
  #choose variables interested 
  transmute(id = SEQN,
            gender = RIAGENDR, 
            age = RIDAGEYR, 
            race = RIDRETH3,
            bmi = BMXBMI, 
            BPXSY1, BPXDI1, #1st BP measures 
            BPXSY2, BPXDI2, #2nd BP measures 
            BPXSY3, BPXDI3, #3rd BP measures
            BPXSY4, BPXDI4, #4th BP measures (optional)
            alcohol = ALQ120Q, 
            alcohol_unit = ALQ120U,
            sleep = SLD012, 
            smoke = SMQ681, 
            workhrs = OCQ180) %>%
  #remove missing values
  #except for the optional BPXSY4, BPXDI4 variables
  drop_na(-c("BPXSY1", "BPXDI1", 
             "BPXSY2", "BPXDI2",
             "BPXSY3", "BPXDI3",
             "BPXSY4", "BPXDI4")) %>% 
  #finally, add survey_year as variable
  #this will be used for testing random effects later
  mutate(survey_year = "2015-2016")

#combine three data sets into one
final_data = rbind(df11, df13, df15)
final_data = final_data %>% select(-c("race"))

#save final data set
write.csv(final_data, "~/Box/HJ_main/2_Courses/STATS 506/Group Project/hyesue/data/final_data.csv", row.names = FALSE)
