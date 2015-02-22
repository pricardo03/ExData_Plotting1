# Loads RDS
library(ggplot2)
require(dlpyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("data/Source_Classification_Code.rds")

# Baltimore City, Maryland
# Los Angeles County, California
onroad <- subset(NEI, (fips == c("24510", "06037") & type == "ON-ROAD"))

df <- aggregate(onroad[, 'Emissions'], by = list(year=onroad$year, City = onroad$fips), sum)

#ggplot need info sort because it read and bind secuencial :( 
df <- arrange(DataFrame, desc(City) , Year)

ggplot(data = df, aes(x = Year, y = Emissions)) + 
  geom_bar(aes(fill = City),stat = "identity") + 
  guides(fill = F) + 
  ggtitle('Los Angeles vrs California Emissions \n') +
  ylab(expression('PM'[2.5])) + 
  xlab('Year') + 
  theme(legend.position = 'none') + 
  geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.7, vjust = 0))

dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
