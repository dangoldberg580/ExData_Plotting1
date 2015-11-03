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

plot(FebData$DateTime, FebData$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "o", pch = 46, xlab = "")
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()
