library(tidyverse)
library(dplyr)
library(stringr)
library(lubridate)


#Read in data excerpt for 2/1-2/2/2007
power= read.table("J:/Contract Reports, Deliverables, Admin/Professional Development/Coursera courses Fall 2023/Exploratory Data Anal course projects/household_power_consumption.txt",
                  skip=66637, nrow=2880, sep=";", na.strings="?", header=FALSE)

names(power) = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3")


power <- power %>% mutate(date=as.Date(date, format="%d/%m/%Y"), time= format(strptime(time, format="%H:%M:%S"), "%H:%M:%S"), day=wday(date, label=TRUE)) 



submetering_data <- power[,7:9]



par(mfrow=c(2,2), type="n", mar=c(4,4,2,2))

#1st plot
plot(power$global_active_power, type="l",col="black", xlab="", ylab="Global Active Power",xaxt = "n")
axis(1, at=c(1,median(1:2880),2880), labels = c("Thu","Fri","Sat"))

#2nd plot
plot(power$voltage, type="l",col="black", ylab="Voltage", xlab="datetime",xaxt = "n")
axis(1, at=c(1,median(1:2880),2880), labels = c("Thu","Fri","Sat"))

#3rd plot
plot(submetering_data[,1], type="l",xlab="", ylab="Energy sub metering", xaxt = "n", col="black")
points(submetering_data[,2], type="l", ylab="Energy sub metering", xaxt = "n",col="red")
points(submetering_data[,3], type="l", ylab="Energy sub metering", xaxt = "n",col="blue")

legend("topright", lty=1, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
axis(1, at=c(1,median(1:2880),2880), labels = c("Thu","Fri","Sat"))

#4th plot
plot(power$global_reactive_power, type="l",col="black", ylab="Global_reactive_power", xlab="datetime",  xaxt = "n", yaxt = "n")
axis(1, at=c(1,median(1:2880),2880), labels = c("Thu","Fri","Sat"))
axis(2, at=c(seq(0,0.5,0.1)),labels = c("0.0", "0.1","0.2","0.3","0.4","0.5"))


dev.copy(png, file = "plot4.png")

dev.off()

