library(tidyverse)
library(dplyr)
library(stringr)
library(lubridate)


#Read in data excerpt for 2/1-2/2/2007
power= read.table("J:/Contract Reports, Deliverables, Admin/Professional Development/Coursera courses Fall 2023/Exploratory Data Anal course projects/household_power_consumption.txt",
                  skip=66637, nrow=2880, sep=";", na.strings="?", header=FALSE)

names(power) = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3")


power <- power %>% mutate(date=as.Date(date, format="%d/%m/%Y"), time= format(strptime(time, format="%H:%M:%S"), "%H:%M:%S"), day=wday(date, label=TRUE)) 

plot(power$global_active_power, type="l",col="black", ylab="Global Active Power (kilowatts)",xlab="", xaxt = "n")
axis(1, at=c(1,median(1:2880),2880), labels = c("Thu","Fri","Sat"))

dev.copy(png,file = "plot2.png")
dev.off()


