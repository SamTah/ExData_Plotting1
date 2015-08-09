##Coursera - Exploratory Data Analysis - Plotting Assignment 1
## plot1.R - generates plot1.png

# Loading the dataset into R
# Calculate fileSize 
# Use data from the dates 2007-02-01 and 2007-02-02 
# Convert the Date and Time variables to Date/Time classes using the strptime() and as.Date()
# Missing values are coded as ?

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
data$Date = as.Date(data$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
subSetData = data[data$Date >= startDate & data$Date <= endDate, ]
head(subSetData)

## Creating plot1 - Histogram
png(filename = "plot1.png", width=480, height=480)
hist(subSetData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

