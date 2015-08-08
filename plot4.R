## Go to the correct directory and read Power Consumption Data
wdir<-getwd()
if (wdir!="C:/KumariK/Coursera") {
  setwd("C:/KumariK/Coursera")
}
ReadFile <- "./data/household_power_consumption.txt"
Bdf <- read.table(ReadFile, header=TRUE, sep=";", na.strings="?")

## Subset Bdf for required dates and get only the complete cases
Sdf <- subset(Bdf, Bdf[,1] == "1/2/2007" | Bdf[,1] == "2/2/2007")
Sdf <- Sdf[complete.cases(Sdf),]

## Remove  Big Data File from memory
rm(Bdf)

# Convert time and date using as.Date() and strptime()
DateTime <- strptime(paste(Sdf$Date, Sdf$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## Get the required data
GlobalActivePower <- as.numeric(Sdf$Global_active_power)
Voltage <- as.numeric(Sdf$Voltage)
SubMetering1 <- as.numeric(Sdf$Sub_metering_1)
SubMetering2 <- as.numeric(Sdf$Sub_metering_2)
SubMetering3 <- as.numeric(Sdf$Sub_metering_3)
GlobalReactivePower <- as.numeric(Sdf$Global_reactive_power)

## create png file with 4 plots
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

plot(DateTime, GlobalActivePower, xlab="", ylab = "Global Active Power", type ="l")
plot(DateTime, Voltage, xlab="datetime", ylab = "Voltage", type ="l")
plot(DateTime, SubMetering1, xlab="", ylab = "Energy sub metering", type ="l")
lines(DateTime, SubMetering2, type ="l", col = "red")
lines(DateTime, SubMetering3, type ="l", col = "blue")
#Create the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue") )
plot(DateTime, GlobalReactivePower, xlab="datetime", ylab = "Global_reactive_power", type ="l")

dev.off()

