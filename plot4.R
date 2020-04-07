library("lubridate")

## plot4.R
source("ReadHouseholdPowerConsumption.R")

showInWindow <- FALSE
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