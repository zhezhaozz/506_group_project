library(data.table)
library(magrittr)
analysis_dt = fread("cleaned_data.csv")

# matrix plot ------------------------------------------------------------------
pairs( ~avg_sys_bp + gender + age + bmi + sleep + smoke + workhrs +
         alchol, data = analysis_dt, main = "simple matrix plot for Systolic blood pressure")

pairs( ~avg_dia_bp + gender + age + bmi + sleep + smoke + workhrs +
         alchol, data = analysis_dt, main = "simple matrix plot for Diastolic blood pressure")


# normality check by histogram -------------------------------------------------
hist(analysis_dt$avg_sys_bp)
hist(analysis_dt$avg_dia_bp)
hist(analysis_dt$age)
hist(analysis_dt$bmi)
hist(analysis_dt$sleep)
hist(analysis_dt$alchol)
# age and alcohol are big problem


# check variance pre -----------------------------------------------------------
## systolic bp
## the result of prefit will not be shown in write-up
pre_sys_fit = lm(avg_sys_bp ~ gender + age + bmi + sleep + smoke + workhrs + alchol,
             data = analysis_dt)

summary(pre_sys_fit)
## standardized residuals plot
st_sys_red = rstandard(pre_sys_fit)
fitted_sys = pre_sys_fit$fitted.values

plot(fitted_sys, st_sys_red, xlab = "fitted values", 
     ylab = "standardized residuals", 
     main = "standardized residuals plot (systolic bp)")


## diatolic bp
## the result of prefit will not be shown in write-up
pre_dia_fit = lm(avg_dia_bp ~ gender + age + sleep + smoke + workhrs + alchol,
                 data = analysis_dt)

## standardized residuals plot
st_dia_red = rstandard(pre_dia_fit)
fitted_dia = pre_sys_fit$fitted.values

plot(fitted_dia, st_dia_red, xlab = "fitted values", 
     ylab = "standardized residuals", 
     main = "standardized residuals plot (diatolic bp)")

# check correlation ------------------------------------------------------------
cov_mat = vcov(pre_sys_fit)
cov_mat[-1, -1] > 0.8
## no correlation between continuous variables larger than 0.8

## check correlation between indicators
gs = chisq.test(analysis_dt$gender, analysis_dt$smoke)
gw = chisq.test(analysis_dt$gender, analysis_dt$workhrs)
sw = chisq.test(analysis_dt$smoke, analysis_dt$workhrs)

## make tables
row = c("gender", "gender", "smoke")
col = c("smoke", "workhrs", "workhrs")
chi_sq_stats = c( gs$statistic, gw$statistic, sw$statistic )
p_value = c(gs$p.value, gw$p.value, sw$p.value)

m = as.data.table(cbind(row, col, chi_sq_stats, p_value))
##  no significant correlation between dummy variables

# check linearity --------------------------------------------------------------
## added value plot
par(mfrow = c(2,2))
## added variable plot for age
lm_a = lm(avg_sys_bp ~ gender + bmi + sleep + smoke + workhrs + alchol,
          data = analysis_dt)
residual_y_age = rstandard(lm_a)

lm_a_x = lm(age ~ gender + bmi + sleep + smoke + workhrs + alchol, 
            data = analysis_dt)
residual_x_age = rstandard(lm_a_x)

plot(residual_x_age, residual_y_age) # added variable plot given age

sp_age = smooth.spline(residual_x_age, residual_y_age, df = 3)

lines(sp_age, col = "red")

# age has non linear pattern

## added variable plot for bmi
lm_b = lm(avg_sys_bp ~ gender + age + sleep + smoke + workhrs + alchol,
          data = analysis_dt)
residual_y_bmi = rstandard(lm_b)

lm_b_x = lm(bmi ~ gender + age + sleep + smoke + workhrs + alchol, 
            data = analysis_dt)
residual_x_bmi = rstandard(lm_b_x)

plot(residual_x_bmi, residual_y_bmi) # added variable plot given age

sp_bmi = smooth.spline(residual_x_bmi, residual_y_bmi, df = 5)

lines(sp_bmi, col = "red")

## added variable plot for sleep
lm_s = lm(avg_sys_bp ~ gender + age + bmi + smoke + workhrs + alchol,
          data = analysis_dt)
residual_y_sleep = rstandard(lm_s)

lm_s_x = lm(sleep ~ gender + age + bmi + smoke + workhrs + alchol, 
            data = analysis_dt)
residual_x_sleep = rstandard(lm_s_x)

plot(residual_x_sleep, residual_y_sleep) # added variable plot given age

## added variable plot for alcohol
lm_al = lm(avg_sys_bp ~ gender + age + sleep + smoke + workhrs + bmi,
          data = analysis_dt)
residual_y_alchol = rstandard(lm_al)

lm_al_x = lm(alchol ~ gender + age + sleep + smoke + workhrs + bmi, 
            data = analysis_dt)
residual_x_alchol = rstandard(lm_al_x)

plot(residual_x_alchol, residual_y_alchol) # added variable plot given age
# non-linear for alchol





