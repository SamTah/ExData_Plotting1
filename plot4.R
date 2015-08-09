##Coursera - Exploratory Data Analysis - Plotting Assignment 1
## plot4.R - generates plot4.png

library(data.table)
fname <- "./data/household_power_consumption.txt"
if (!file.exists(fname)){
  stop("Please download the household_power_consumption.txt file")
}

## Read the data
file.info(fname)$size    #File size
data <- read.table(fname, sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
print(dim(data)) # The dataset should have 2,075,259 rows and 9 columns


## Formatting the date and data subset on 2007-02-01 and 2007-02-02
data$timestamp = strptime(paste(data$Date, data$Time),
                          format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
subSetData = data[data$timestamp >= startDate & data$timestamp <= endDate, ]
head(subSetData)

## Creating plot4 - 4 plots in one

png(filename="plot4.png", width=480, height=480)

# To set up for 4 plots columnwise ((r1,c1),(r2,c1),(r1,c2),(r2,c2))
par(mfcol=c(2,2))

# First plot - Top-left
plot(subSetData$timestamp, subSetData$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

# Second plot - Bottom-left
plot(subSetData$timestamp, subSetData$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(subSetData$timestamp, subSetData$Sub_metering_2, col="red")
lines(subSetData$timestamp, subSetData$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"), bty="n")

# Third Plot - Top-right
plot(subSetData$timestamp, subSetData$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Fourth plot - Bottom-right
plot(subSetData$timestamp, subSetData$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
