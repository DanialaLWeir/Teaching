###################
# CPS 101 - example script for session 1 preparation
# created by: Sophie Bots
# purpose: perform the exercises from the session 1 preparation
# latest version: 05/08/2024
###################

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

# step 3 - using ggplot2 to create a scatterplot
install.packages("ggplot2") # --> if you have never used RStudio/ggplot2 before, you need to install it (just once)
library(ggplot2) # --> you need to 'activate' ggplot2 every time you use RStudio

# now you can create the plot
ggplot(data = ex1_data, aes(x = age, y = bmi)) + geom_point()

# step 4 - incorporating sex into the scatterplot
ggplot(data = ex1_data, aes(x = age, y = bmi, colour = male)) + geom_point()

# step 5 - fixing the issue
# the issue here is that our variable for sex (called 'male') is a numeric variable
# you can check whether this is the case as follows:
is.numeric(ex1_data$male)

# that means R thinks it works the same way as for example age, so you can have an average sex,
# and this is why it gives us the scatterplot we have
# of course, we know that is not true, sex is actually discrete:
# it has a number of specific categories (male, female, intersex, etc.)
# now we just need to tell R this --> there are two options to do this:
# option 1 - change the variable in the original dataset
ex1_data$male <- as.factor(ex1_data$male)

# we can now re-run our code from step 4 to see if it works
ggplot(data = ex1_data, aes(x = age, y = bmi, colour = male)) + geom_point()

# option 2 - we tell R to treat male differently, but only in the ggplot function
ggplot(data = ex1_data, aes(x = age, y = bmi, colour = as.factor(male))) + geom_point()

# step 6 - creating a histogram for bmi
ggplot(data = ex1_data, aes(x=bmi)) + geom_histogram()

# step 7 - checking if bmi differs depending on hypertension status
# option 1 - through the use of colour
ggplot(data = ex1_data, aes(x=bmi, fill = htn)) + geom_histogram()

# this does not work -- what could be the issue?
# htn in the dataset is coded as a 0/1 variable -- same as 'male'
# could this be the same issue? Let's check
is.numeric(ex1_data$htn)
ggplot(data = ex1_data, aes(x=bmi, fill = as.factor(htn))) + geom_histogram()

# maybe you don't like the current figure and want the bars next to each other instead of stacked
ggplot(data = ex1_data, aes(x=bmi, fill = as.factor(htn))) + geom_histogram(position = "dodge")

# step 8 - create a boxplot to see if bmi differs depending on diabetes status
ggplot(data = ex1_data, aes(x=t2dm, y=bmi)) + geom_boxplot()

# this again looks weird... are you catching on?
is.numeric(ex1_data$t2dm)
ggplot(data = ex1_data, aes(x=as.factor(t2dm), y=bmi)) + geom_boxplot()

# step 9 - saving your plot
# you can do this:
# (1) by directly copying the plot from the plotting area and pasting it into a Powerpoint or Word document -- downside: low quality
# (2) by clicking 'Export' in the plot area and then choosing either 'Save as Image' or 'Save as PDF' -- downside: have to do this manually
# (3) through the ggsave() function
# here, you need to specify the file name, so the name you want to save your plot under
# this should include the filepath to the folder you want to save your plot in, as below:
ggsave(filename = "C:/Users/3911195/OneDrive - Universiteit Utrecht/BKO/CPS101/R course/20240805_CPS101_R crash course_plot.jpg")

