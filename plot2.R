library("lubridate")

## plot2.R
source("ReadHouseholdPowerConsumption.R")

showInWindow <- FALSE
if(showInWindow) {
  dev.new(width = 480, height = 480, unit = "px")
} else {
  png("plot2.png")
}
with(twodays,plot(Date,Global_active_power,type="l",col="Black",xlab="",ylab="Global Active Power (kilowatts)"))
if(showInWindow)
  dev.copy(png,"plot2.png")
dev.off()
