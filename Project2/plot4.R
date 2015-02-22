# Loads RDS
require(ggplot2)

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Coal-related SCC
coalRelated = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merges data sets
merge <- merge(x = NEI, y = coalRelated, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

png(filename = 'plot4.png')

ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000)) + 
  geom_line(aes(group = 1, col = Emissions)) + 
  geom_point(aes(size = 2, col = Emissions)) + 
  ggtitle(expression('Total Emissions of PM'[2.5])) + 
  ylab(expression(paste('PM', ''[2.5], ' in thousands of tons'))) + 
  geom_text(aes(label = round(Emissions / 1000, digits = 2),size = 2, hjust = 1.5, vjust = 1.5)) + 
  scale_colour_gradient(low = 'green', high = 'red') 

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
