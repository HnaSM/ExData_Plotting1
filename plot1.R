library(tidyverse)
library(dplyr)
library(stringr)
library(lubridate)



#Read in data excerpt for 2/1-2/2/2007
power= read.table("J:/Contract Reports, Deliverables, Admin/Professional Development/Coursera courses Fall 2023/Exploratory Data Anal course projects/household_power_consumption.txt",
                  skip=66637, nrow=2880, sep=";", na.strings="?", header=FALSE)

names(power) = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3")


power <- power %>% mutate(date=as.Date(date, format="%d/%m/%Y"), time= format(strptime(time, format="%H:%M:%S"), "%H:%M:%S")) 


hist(power$global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
   

dev.copy(png,file = "plot1.png")
dev.off()

