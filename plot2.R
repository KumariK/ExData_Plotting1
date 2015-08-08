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
GlobalActivePower <- as.numeric(Sdf$Global_active_power)


## create png file with the plot
png("plot2.png", width=480, height=480)
plot(DateTime, GlobalActivePower, xlab="", ylab = "Global Active Power (kilowatts)", type ="l")
dev.off()
