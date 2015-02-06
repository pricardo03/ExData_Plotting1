library(datasets)

#Reading all data
PowerConsumption <- read.csv("household_power_consumption.txt", header = T, sep=";", na.string="?", 
                             check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#set format date to get a clean filtered data
PowerConsumption$Date <- as.Date(PowerConsumption$Date, format="%d/%m/%Y")

#get only two days
DataPeriod <- subset(PowerConsumption, subset=(Date>= "2007-02-01" & Date<="2007-02-02"))
#deallocating resources
rm(PowerConsumption)

#built new column datetime 
datetime <- paste(as.Date(DataPeriod$Date), DataPeriod$Time)
DataPeriod$Datetime <- as.POSIXct(datetime)

#use type= L to create line 
plot(DataPeriod$Global_active_power~DataPeriod$Datetime, ylab="Global Active Power (kilowatts)", xlab="", type="l")

#save into a png file from screen
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
