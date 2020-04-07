library("lubridate")

## plot3.R
source("ReadHouseholdPowerConsumption.R")

showInWindow <- FALSE
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