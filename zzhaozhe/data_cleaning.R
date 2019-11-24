library(haven)
library(data.table)
library(magrittr)

# download data ----------------------------------------------------------------
## 2015 - 2016
demog15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DEMO_I.XPT')
bp15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BPX_I.XPT')
bm15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BMX_I.XPT')
alc15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/ALQ_I.XPT')
occupation15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/OCQ_I.XPT')
sleep15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/SLQ_I.XPT')
smoke15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/SMQRTU_I.XPT')
take_pre15 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/BPQ_I.XPT')

## 2013 - 2014
demog13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DEMO_H.XPT')
bp13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPX_H.XPT')
bm13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BMX_H.XPT')
alc13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.XPT')
occupation13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OCQ_H.XPT')
sleep13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SLQ_H.XPT')
smoke13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SMQRTU_H.XPT')
take_pre13 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPQ_H.XPT')

## 2011 - 2012
demog11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/DEMO_G.XPT')
bp11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BPX_G.XPT')
bm11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BMX_G.XPT')
alc11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/ALQ_G.XPT')
occupation11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/OCQ_G.XPT')
sleep11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/SLQ_G.XPT')
smoke11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/SMQRTU_G.XPT')
take_pre11 = read_xpt('https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/BPQ_G.XPT')

# if variables got cleaned, run this code to get data set
full_dt = fread("~/Desktop/Math_Courses/Umich/506/506_group_project/project_data.csv")

# join data tables -------------------------------------------------------------
## 2015 - 2016
demog15 = as.data.table(demog15)
bp15 = as.data.table(bp15)
bm15 = as.data.table(bm15)
alc15 = as.data.table(alc15)
occupation15 = as.data.table(occupation15)
sleep15 = as.data.table(sleep15)
smoke15 = as.data.table(smoke15)
take_pre15 = as.data.table(take_pre15)

dt15 = demog15 %>%
  merge( . , bp15, by = 'SEQN', all = FALSE ) %>%
  merge( . , bm15, by = 'SEQN', all = FALSE ) %>%
  merge( . , alc15, by = 'SEQN', all = FALSE ) %>%
  merge( . , occupation15, by = 'SEQN', all = FALSE ) %>%
  merge( . , sleep15, by = 'SEQN', all = FALSE ) %>%
  merge( . , smoke15, by = 'SEQN', all = FALSE ) %>%
  merge( . , take_pre15, by = 'SEQN', all = FALSE )

## 2013 - 2014
demog13 = as.data.table(demog13)
bp13 = as.data.table(bp13)
bm13 = as.data.table(bm13)
alc13 = as.data.table(alc13)
occupation13 = as.data.table(occupation13)
sleep13 = as.data.table(sleep13)
smoke13 = as.data.table(smoke13)
take_pre13 = as.data.table(take_pre13)

dt13 = demog13 %>%
  merge( . , bp13, by = 'SEQN', all = FALSE ) %>%
  merge( . , bm13, by = 'SEQN', all = FALSE ) %>%
  merge( . , alc13, by = 'SEQN', all = FALSE ) %>%
  merge( . , occupation13, by = 'SEQN', all = FALSE ) %>%
  merge( . , sleep13, by = 'SEQN', all = FALSE ) %>%
  merge( . , smoke13, by = 'SEQN', all = FALSE ) %>%
  merge( . , take_pre13, by = 'SEQN', all = FALSE )

## 2011 - 2012
demog11 = as.data.table(demog11)
bp11 = as.data.table(bp11)
bm11 = as.data.table(bm11)
alc11 = as.data.table(alc11)
occupation11 = as.data.table(occupation11)
sleep11 = as.data.table(sleep11)
smoke11 = as.data.table(smoke11)
take_pre11 = as.data.table(take_pre11)

dt11 = demog11 %>%
  merge( . , bp11, by = 'SEQN', all = FALSE ) %>%
  merge( . , bm11, by = 'SEQN', all = FALSE ) %>%
  merge( . , alc11, by = 'SEQN', all = FALSE ) %>%
  merge( . , occupation11, by = 'SEQN', all = FALSE ) %>%
  merge( . , sleep11, by = 'SEQN', all = FALSE ) %>%
  merge( . , smoke11, by = 'SEQN', all = FALSE ) %>%
  merge( . , take_pre11, by = 'SEQN', all = FALSE )

# data cleaning ----------------------------------------------------------------
## 2015 - 2016
dt15 = dt15 %>%
  ## age ranges from 18 to 60
  .[RIDAGEYR >= 18 & RIDAGEYR <= 60, ] %>%
  ## work at a job or business. Eliminating non-working group
  .[OCD150 == 1, ] %>%
  ## eliminate people who are now taking prescription for hyper-blood-pressure
  .[BPQ050A != 1 & is.na(BPQ050A) == FALSE, ] %>%
  ## eliminate observations where unit of alcohol drink is missing
  .[is.na(ALQ120U) == FALSE] %>%
  ## choose variables interested 
  .[, .(id = SEQN,
        gender = RIAGENDR, age = RIDAGEYR, race = RIDRETH3,
        bmi = BMXBMI, BPXSY1, BPXDI1, BPXSY2, BPXDI2, BPXSY3, BPXDI3, BPXSY4, BPXDI4,
        alchol = ALQ120Q, sleep = SLD012, smoke = SMQ681, workhrs = OCQ180)] %>%
  ## eliminate missing values
  na.omit(., cols = c(1:11,14:17)) 
  
## 2013 - 2014
dt13 = dt13 %>%
  ## age ranges from 18 to 60
  .[RIDAGEYR >= 18 & RIDAGEYR <= 60, ] %>%
  ## work at a job or business. Eliminating non-working group
  .[OCD150 == 1, ] %>%
  ## eliminate people who are now taking prescription for hyper-blood-pressure
  .[BPQ050A != 1 & is.na(BPQ050A) == FALSE, ] %>%
  ## eliminate observations where unit of alcohol drink is missing
  .[is.na(ALQ120U) == FALSE] %>%
  ## choose variables interested 
  .[, .(id = SEQN,
        gender = RIAGENDR, age = RIDAGEYR, race = RIDRETH3,
        bmi = BMXBMI, BPXSY1, BPXDI1, BPXSY2, BPXDI2, BPXSY3, BPXDI3, BPXSY4, BPXDI4,
        alchol = ALQ120Q, sleep = SLD010H, smoke = SMQ681, workhrs = OCQ180)] %>%
  ## eliminate missing values
  na.omit(., cols = c(1:11,14:17)) 
  
## 2011 - 2012
dt11 = dt11 %>%
  ## age ranges from 18 to 60
  .[RIDAGEYR >= 18 & RIDAGEYR <= 60, ] %>%
  ## work at a job or business. Eliminating non-working group
  .[OCD150 == 1, ] %>%
  ## eliminate people who are now taking prescription for hyper-blood-pressure
  .[BPQ050A != 1 & is.na(BPQ050A) == FALSE, ] %>%
  ## eliminate observations where unit of alcohol drink is missing
  .[is.na(ALQ120U) == FALSE] %>%
  ## choose variables interested 
  .[, .(id = SEQN,
        gender = RIAGENDR, age = RIDAGEYR, race = RIDRETH3,
        bmi = BMXBMI, BPXSY1, BPXDI1, BPXSY2, BPXDI2, BPXSY3, BPXDI3, BPXSY4, BPXDI4,
        alchol = ALQ120Q, sleep = SLD010H, smoke = SMQ680, workhrs = OCQ180)] %>%
  ## eliminate missing values
  na.omit(., cols = c(1:11,14:17)) 

## full data 
full_dt = rbind(dt15, dt13, dt11)

# fwrite(full_dt, "project_data.csv")


