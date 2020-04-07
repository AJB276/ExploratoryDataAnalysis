library("lubridate")

## plot1.R
source("ReadHouseholdPowerConsumption.R")

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
