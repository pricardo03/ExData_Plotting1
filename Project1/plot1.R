library(datasets)

#Reading all data
PowerConsumption <- read.csv("household_power_consumption.txt", header = T, sep=";", na.string="?", ## nrows=2075259,
                              check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#set format date to get a clean filtered data
PowerConsumption$Date <- as.Date(PowerConsumption$Date, format="%d/%m/%Y")

#get only two days
DataPeriod <- subset(PowerConsumption, subset=(Date>= "2007-02-01" & Date<="2007-02-02"))
#deallocating resources
rm(PowerConsumption)

#Create png file
png(file="plot1.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

#Show de plot
hist(DataPeriod$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frecuency")

#Close device
png(file="plot1.png")
