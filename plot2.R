##Coursera - Exploratory Data Analysis - Plotting Assignment 1
## plot2.R - generates plot2.png

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

## Creating plot2 - Plot
png(filename = "plot2.png", width=480, height=480)
plot(subSetData$timestamp, subSetData$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

