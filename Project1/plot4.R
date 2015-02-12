#setwd("C:\\Users\\Rikhardo\\Documents\\Cursos\\Data Science\\4- Exploratory Data Analysis\\Project1")

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

#Setup enviroment 4 plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) 

with(DataPeriod, { 
  plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="") 
  plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="") 
  plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="") 
      #Legend Lines
      lines(Sub_metering_2~Datetime,col='Red') 
      lines(Sub_metering_3~Datetime,col='Blue') 
      #Legend Titles
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
  plot(Global_reactive_power~Datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="") 
}) 

#save into a png file from screen
dev.copy(png, file="plot4.png", height=480, width=480, units = "px", bg = "transparent")
dev.off()
