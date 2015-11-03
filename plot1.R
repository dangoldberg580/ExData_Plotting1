## read in and subset the data (data should be in the same directory as the R script)
library(dplyr)
library(data.table)

df <- fread("household_power_consumption.txt", na.strings = "?")     ## read in the data
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")                     ## convert characters to dates

FebData <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")   ## select only the two dates we need
rm(df)                                                               ## remove large data frame     
gc()                                                                 ## clear up some memory  

hist(FebData$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()