## read in and subset the data (data should be in the same directory as the R script)
library(dplyr)
library(data.table)

df <- fread("household_power_consumption.txt", na.strings = "?")     ## read in the data
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")                     ## convert characters to dates

FebData <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")   ## select only the two dates we need
rm(df)                                                               ## remove large data frame     
gc()                                                                 ## clear up some memory  

DateTime <- paste(FebData$Date, FebData$Time, sep = " ")             ## create a new date - character variable
DateTime <- as.POSIXct(DateTime, format = "%Y-%m-%d %H:%M:%S")       ## convert to date
FebData$DateTime <- FebData[ , DateTime]                             ## add it into the data frame

png("plot4.png", width = 480, height = 480, type = "quartz")

par(mfcol = c(2,2))                                                  ## set the number of row/cols for graph area and call 4 plots
par(cex = .75)

plot(FebData$DateTime, FebData$Global_active_power, ylab = "Global Active Power", type = "o", pch = 46, xlab = "")

plot(FebData$DateTime, FebData$Sub_metering_1, ylab = "Energy sub metering", type = "o", pch = 46, col = "black", xlab = "")
points(FebData$DateTime, FebData$Sub_metering_2, type="o", pch = 46, col = "red")
points(FebData$DateTime, FebData$Sub_metering_3, type="o", pch = 46, col = "blue")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col=c("black", "red", "blue"), lty = c(1, 1, 1))

plot(FebData$DateTime, FebData$Voltage, ylab = "Voltage", type = "o", pch = 46, xlab = "datetime")

plot(FebData$DateTime, FebData$Global_reactive_power, ylab = "Global_reactive_power", type = "o", pch = 46, xlab = "datetime")

dev.off()
