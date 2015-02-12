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

#prepare the plot
with(DataPeriod, {plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="") 
                  lines(Sub_metering_2~Datetime,col="Red") 
                  lines(Sub_metering_3~Datetime,col="blue") 
                 }) 

#legends
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd=2)


#save into a png file from screen
dev.copy(png, file="plot3.png", height=480, width=480, units = "px", bg = "transparent")
dev.off()
