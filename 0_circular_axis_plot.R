# Time series analysis in a circular axis plot

### This is a plot of some known events and possible sub-events that can occur
### every hour and every day for n years.

## Packages and Libraries
require("plotrix")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lubridate")
library("ggplot2")

## Data Import
data = read.csv("data/test_generated_circleplot.csv", header=TRUE, 
                fileEncoding="UTF-8-BOM")
attach(data)

## Extract year, month, day from date
data$date = format(data$date, format = "%m/%d/%Y")
data$time = as.numeric(data$time)
data$year = as.numeric(format(as.Date(data$date, format="%m/%d/%Y"), "%Y"))
data$month = as.numeric(format(as.Date(data$date, format="%m/%d/%Y"), "%m"))
data$day = as.numeric(format(as.Date(data$date, format="%m/%d/%Y"), "%d"))

monthdays = c(31,28,31,30,31,30,31,31,30,31,30,31)

as.matrix(data)

## Plot circular time series by category, hour of day, and numeric day
ggplot(data, mapping=aes(x=time, y=day)) +
  geom_point(aes(shape=category, color=category)) +
  scale_x_continuous(breaks=1:24, labels=c(1:24)) +
  coord_polar() +
  labs(title="Event Category by Hour/Day", 
       x="Hour of Day", y="Day of Month",
       color="Legend", shape="Legend") +
  theme(plot.title=element_text(hjust=.5), 
        axis.text.x=element_text(family=""),
        axis.text.y=element_text(family="")) +
  expand_limits(x=0) # corrects x axis start point