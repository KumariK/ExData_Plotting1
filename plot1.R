## Go to the correct directory and read Power Consumption Data
wdir<-getwd()
if (wdir!="C:/KumariK/Coursera") {
  setwd("C:/KumariK/Coursera")
}
ReadFile <- "./data/household_power_consumption.txt"
BigDataFile <- read.table(ReadFile, header=TRUE, sep=";", na.strings="?", 
                         check.names=FALSE,stringsAsFactors=FALSE, dec=".")
BigDataFile$Date <- as.Date(BigDataFile$Date, format="%d/%m/%Y")

## Subset the data and remove the BigData file from memory
SmallDataFile <- subset(BigDataFile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(BigDataFile)

## Format the Date to Date/Time class
## and Global_active_power to numeric

DateTime <- strptime(paste(SmallDataFile$Date, SmallDataFile$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
## SmallDataFile$Datetime <- as.POSIXct(DateTime)
GlobalActivePower <- as.numeric(SmallDataFile$Global_active_power)

## create png file with the histogram
png("plot1.png", width=480, height=480)
hist(GlobalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
