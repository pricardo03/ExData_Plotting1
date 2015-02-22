require(ggplot2)

# Load data as RDS(R Single Objects) 
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#Extract Baltimore city Emissions
BaltimoreNEI = subset(NEI, fips ="24510")
BaltimoreNEI$year <- factor(BaltimoreNEI$year, levels = c('1999', '2002', '2005', '2008'), ordered = TRUE)

#using really nice help:
#       http://docs.ggplot2.org/current/geom_boxplot.html
#       http://www.inside-r.org/r-doc/grDevices/boxplot.stats
ggplot( data = BaltimoreNEI                  
        , aes(x = year, y = log(Emissions))) +  #here I use log to increase the spaces in the data and show nice graph  
  facet_grid(. ~ type) +                          #now add grid paneles for type of emission
  guides(fill = F) +                              #mapping scale and guide
  geom_boxplot(aes(fill = type)) +                #ok, handson touche, add boxplots using Emissions Type
  stat_boxplot(geom = 'errorbar') +               #colors and statistics
  geom_jitter(alpha = 0.3) +                      #here include point and make it like transparent, have to be after boxplot to bring at front 
  #from here titles
  ylab(expression(paste('Log(2)', ' of PM'[2.5], ' Emissions'))) + 
  xlab('Years') + 
  ggtitle('Baltimore City Emissions, Maryland') 

#have to be in big size to see more details
dev.copy(png, file="plot3.png", height=900, width=800, units = 'px')
dev.off()

