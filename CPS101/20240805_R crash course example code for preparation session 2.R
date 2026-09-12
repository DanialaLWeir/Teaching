###################
# CPS 101 - example script for session 2 preparation
# created by: Sophie Bots
# purpose: perform the exercises from the session 2 preparation
# latest version: 05/08/2024
###################

# loading in any packages I will need
library(ggplot2)

# step 1 - loading in the datasets
# for .RData files, you can use the 'load()' function
load("C:/Users/3911195/OneDrive - Universiteit Utrecht/BKO/CPS101/R course/20240730_R course project dataset.RData")

# for .csv files, you can use the 'read.csv()' function
# CSV = comma separated file;
# read.csv() assumes columns are separated by a comma (standard in UK/US systems)
# read.csv2() assumes columns are separated by a ; (standard in Dutch systems)
ex1_data <- read.csv2("C:/Users/3911195/OneDrive - Universiteit Utrecht/BKO/CPS101/R course/20240730_R course project dataset.csv")

# step 2 - looking at the dataset
# to do this, you can either click on the object in your environment
# or use the code below
View(ex1_data)

# you can also choose other ways to look at this, for example:
summary(ex1_data$age)
# do you also notice that there are people with an age of 0? That seems weird.

# step 3 - recalculate age
# for this we will use the tidyverse way, which makes use of the dplyr package
# you will have to install and load it if you haven't already
install.packages("dplyr") # --> if you have never used RStudio/dplyr before, you need to install it (just once)
library(dplyr) # --> you need to 'activate' dplyr every time you use RStudio

ex1_data <- mutate(ex1_data, age2 = 2024-year_of_birth)

# we can check if it worked by looking at our dataset again. The new variable will be at the end of the dataset
View(ex1_data)

# or by repeating our code from above, swapping 'age' for 'age2'
summary(ex1_data$age2)
# this looks better

# step 4 - making histograms to compare age and age 2
# this is the same code as we used last session:
ggplot(data = ex1_data, aes(x=age)) + geom_histogram()
ggplot(data = ex1_data, aes(x=age2)) + geom_histogram()
# you can see that the weird 0 values disappeared in the second histogram, and that age is more normally distributed

# step 5 - create a subset of the data that only contains patients with diabetes
# it is smart to give this dataset a different name than your original, 
# so that you still have the original in case you do something wrong
ex1_data_dm <- filter(ex1_data, t2dm == 1)

# step 6 - create a subset of patients with both diabetes and hypertension
# there are two ways to do this:
# (1) the two-step solution
# take your dataset from 5 and filter again on htn
ex1_data_dmhtn <- filter(ex1_data_dm, htn == 1)

# (2) the one-step solution
# take the main dataset and do both filters at once:
ex1_data_dmhtn <- filter(ex1_data, htn == 1 & t2dm == 1)

# step 7 - removing variables from the dataset
# there are again two ways to do this:
# (1) select only the variables you do want
ex1_data_nomed <- select(ex1_data, c(id, male, year_of_birth, age, start, end, death, bmi, htn, t2dm, age2))

# (2) remove the variables you do not want
ex1_data_nomed <- select(ex1_data, -c(med_code_1, med_code_2, med_code_3, 
                                      date_start_1, date_start_2, date_start_3, 
                                      duration_1, duration_2, duration_3))

# this can be done even faster with dplyr's built-in helper functions:
ex1_data_nomed <- select(ex1_data, -c(contains("med"), contains("date_start"), contains("duration")))
