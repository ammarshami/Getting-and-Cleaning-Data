

dataFile <- "household_power_consumption.txt"
electricData <- read.table(dataFile, header = TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")
# Convertind the date format
electricData$Date <- as.Date(electricData$Date, format="%d/%m/%Y")
# Subsetting the data, selecting the data for Feb 1 & 2 
requiredData <- subset(electricData, (Date =="2007-02-01" | Date =="2007-02-02"))
# plot1
hist(requiredData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()
