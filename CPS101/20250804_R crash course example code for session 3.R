###################
# CPS 101 - example script for session 3
# created by: Sophie Bots
# purpose: perform the exercises from the session 3 lecture
# latest version: 04/08/2025
###################

# loading in any packages I will need
library(tidyverse)
library(tableone) # this is a new package, you need it for making Table 1 (see preparation)
library(survival) # this is a new package, you need it for survival analysis

# step 1 - loading in the datasets
# for .RData files, you can use the 'load()' function
load("C:/Users/3911195/OneDrive - Universiteit Utrecht/BKO/CPS101/R course/20240730_R course project dataset.RData")

# for .csv files, you can use the 'read.csv()' function
# CSV = comma separated file;
# read.csv() assumes columns are separated by a comma (standard in UK/US systems)
# read.csv2() assumes columns are separated by a ; (standard in Dutch systems)
ex1_data <- read.csv2("C:/Users/3911195/OneDrive - Universiteit Utrecht/BKO/CPS101/R course/20240730_R course project dataset.csv")

# part 1: comparing two variables
# the functions here are part of the stats package, which is automatically loaded

# t-test
# if you want to see whether the average of a variable is different between two groups
# for example the bmi of people with and without type 2 diabetes
# the second variable in the formula is the grouping variable
t.test(bmi ~ t2dm, data=ex1_data)
?t.test() # to learn more and see all the options

# chi-square
# if you want to test whether frequencies differ between two groups
# for example the amount of people with hypertension in people with and without type 2 diabetes
chisq.test(ex1_data$htn, ex1_data$t2dm)
?chisq.test() # to learn more and see all the options

# part 2: regression models

# linear regression
# if you want to see the effect of one continuous variable on another
# for example, the effect of age on bmi
lm(bmi ~ age, data = ex1_data) # this runs the model
summary(lm(bmi ~ age, data = ex1_data)) # this gives the complete output

?lm() # to learn more and see all the options

# you can also save the model and then do the summary
model1 <- lm(bmi~age, data=ex1_data)
summary(model1)

# logistic regression
# if you want to see the effect on a binary (yes/no) outcome
# for example, the effect of age on type 2 diabetes status
# logistic regression uses a function called 'glm'; generalised linear models
# this function can run many different models, so you need to specify which one you want through the 'family' argument
# for logistic regression, this is binomial with link = logit
# see ?family() for more
glm(as.factor(t2dm) ~ age, data=ex1_data, family = binomial(link = "logit"))
model2 <- glm(as.factor(t2dm) ~ age, data=ex1_data, family = binomial(link = "logit"))
summary(model2)

?glm() # to learn more and see all the options

# adjusting your model for confounders
# add confounders with the + after specifying the independent variable (age in this case)
model3 <- glm(as.factor(t2dm) ~ age + as.factor(htn) + bmi, 
              data=ex1_data, 
              family = binomial(link = "logit"))
summary(model3)

# survival analysis (Cox regression)
# you need to install the survival package if you haven't used it before
# I already loaded the package in at the start of the script

# for survival analysis, we need to know two additional things:
# (1) the outcome status --> this is the 'death' variable
# (2) the follow-up time --> we should define this based on start and end

# first I create a follow-up variable
ex1_data <- ex1_data %>%
  mutate(fu_time = as.Date(end) - as.Date(start))

# now I can run the model
# and see the effect of for example hypertension on survival
model4 <- coxph(Surv(fu_time, death) ~ as.factor(htn), data = ex1_data)
summary(model4)

# create a Kaplan-Meier to visualise survival
plot(survfit(Surv(fu_time, death) ~ as.factor(htn), data = ex1_data))
