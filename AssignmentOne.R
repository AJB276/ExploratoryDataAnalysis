library("lubridate")

gitRepo <- "http://archive.ics.uci.edu/ml/"
dataFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
  download.file(dataFile, zipFile, mode = "wb")
}

#unzip zip file containing data if data directory doesn't already exist
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile)) {
   unzip(zipFile)
}

# Source:
#   
# Georges Hebrail (georges.hebrail '@' edf.fr), Senior Researcher, EDF R&D, Clamart, France
# Alice Berard, TELECOM ParisTech Master of Engineering Internship at EDF R&D, Clamart, France
# 
# 
# Data Set Information:
#   
#   This archive contains 2075259 measurements gathered in a house located in Sceaux (7km of Paris, France) between December 2006 and November 2010 (47 months).
# Notes:
#   1.(global_active_power*1000/60 - sub_metering_1 - sub_metering_2 - sub_metering_3) represents the active energy consumed every minute (in watt hour) in the household by electrical equipment not measured in sub-meterings 1, 2 and 3.
# 2.The dataset contains some missing values in the measurements (nearly 1,25% of the rows). All calendar timestamps are present in the dataset but for some timestamps, the measurement values are missing: a missing value is represented by the absence of value between two consecutive semi-colon attribute separators. For instance, the dataset shows missing values on April 28, 2007.

# Attribute Information:
#   
# 1.date: Date in format dd/mm/yyyy
# 2.time: time in format hh:mm:ss
# 3.global_active_power: household global minute-averaged active power (in kilowatt)
# 4.global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5.voltage: minute-averaged voltage (in volt)
# 6.global_intensity: household global minute-averaged current intensity (in ampere)
# 7.sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# 8.sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# 9.sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )


if(!exists("hhpc"))
{
  hhpc <- read.table(dataFile,header=TRUE,sep=";",stringsAsFactors=FALSE, na.strings = c("?"),
                   colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

  #join date and time as POSIXlt Date,Time
  hhpc$Date <- with(hhpc,as.POSIXlt(paste(Date,Time),tz=tz("Europe/France")))
  hhpc$Time <- NULL
}


## plot1.R
## will move this later
feb2007 <- hhpc[(year(hhpc$Date) == 2007) & (month(hhpc$Date) == 2),]
twodays <- feb2007[(day(feb2007$Date) <= 2),]

showInWindow <- FALSE
if(showInWindow) {
  dev.new(width = 480, height = 480, unit = "px")
} else {
  png("plot1.png")
}
with(twodays,hist(Global_active_power,col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)",xlim=c(0,6)))
if(showInWindow)
  dev.copy(png,"plot1.png")
dev.off()

## plot2.R
if(showInWindow) {
  dev.new(width = 480, height = 480, unit = "px")
} else {
  png("plot2.png")
}
with(twodays,plot(Date,Global_active_power,type="l",col="Black",xlab="",ylab="Global Active Power (kilowatts)"))
if(showInWindow)
  dev.copy(png,"plot2.png")
dev.off()

## plot3.R
if(showInWindow) {
  dev.new(width = 480, height = 480, unit = "px")
} else {
  png("plot3.png")
}
with(twodays,plot(Date,Sub_metering_1,type="l",col="Black",xlab="",ylab="Energy sub metering"))
with(twodays,points(Date,Sub_metering_2,type="l",col="Red"))
with(twodays,points(Date,Sub_metering_3,type="l",col="Blue"))
legend("topright",lwd = 1, col = c("Black","Red","Blue"),legend = names(twodays)[6:8])
if(showInWindow)
  dev.copy(png,"plot3.png")
dev.off()

## plot4.R
if(showInWindow) {
  dev.new(width = 480, height = 480, unit = "px")
} else {
  png("plot4.png")
}
par(mfcol=c(2,2))
with(twodays,plot(Date,Global_active_power,type="l",col="Black",xlab="",ylab="Global Active Power (kilowatts)"))
with(twodays,plot(Date,Sub_metering_1,type="l",col="Black",xlab="",ylab="Energy sub metering"))
with(twodays,points(Date,Sub_metering_2,type="l",col="Red"))
with(twodays,points(Date,Sub_metering_3,type="l",col="Blue"))
legend("topright",lwd = 1, col = c("Black","Red","Blue"),legend = names(twodays)[6:8])
with(twodays,plot(Date,Voltage,col="Black",xlab="datetime",type="l"))
with(twodays,plot(Date,Global_reactive_power,col="Black",xlab="datetime",type="l"))
if(showInWindow)
  dev.copy(png,"plot4.png")
dev.off()



