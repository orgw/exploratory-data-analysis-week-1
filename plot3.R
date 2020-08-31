library(dplyr)
library(lubridate)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./Electric.zip")

unzip("./Electric.zip")

power<-tibble(read.table(file="./household_power_consumption.txt",skip=65000,nrow=8000,sep=";",header=F,col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")))

head(power$Time)
#check NA
grep("\\?",power)

tail(power)

#change file type to data and time, this time date to only specific day
power$Date<-dmy(power$Date)
power$Time<-hms(power$Time)


#subset specific dates
df<- subset(power,Date=="2007-02-01"|Date=="2007-02-02")
head(df)

#make new variable including date and time as Total
df$Total<- df$Date+df$Time
df$Total

#plot 
names(df)

with(df,plot(Total,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black"))
points(df$Total,df$Sub_metering_2,type="l",col="red")
points(df$Total,df$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,'plot3.png')
dev.off()
