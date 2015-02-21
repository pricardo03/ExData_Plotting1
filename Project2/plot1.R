#setdirectory
#setwd("C:\\Users\\Rikhardo\\Documents\\Cursos\\Data Science\\4- Exploratory Data Analysis\\Week 3\\Project")

# Load data as RDS(R Single Objects) 
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Prepare grouping data by year
EmissionByYear <- aggregate(NEI[, 'Emissions'], by = list(TotalTons = NEI$year), FUN = sum)
#Now making number more easy to read replacing PM values, convet millons of tons -> thousands of tons ;) 
EmissionByYear$thousandTons <- round(EmissionByYear[, 2] / 1000, 2)

#finally create the plot using Bars
barplot(EmissionByYear$thousandTons
      , col="lightgreen"
      , names.arg = EmissionByYear$TotalTons
      , main = expression('Total Emission of PM'[2.5])
      , xlab = 'Year' 
      , ylab = expression(paste('PM', ''[2.5], ' in Kilotons'))
       )

#Copy the plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
