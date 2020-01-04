plot4 <- function() {
  
  library(ggplot2)
  
  # read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # vlookup to select only data in relation to coal combustion 
  NEI$SCC <- as.factor(NEI$SCC)
  NS_merge <- merge(NEI,SCC, by.x = "SCC", by.y = "SCC", all.x = TRUE) # left join
  NS_merge <- NS_merge[grep("Comb.*Coal",NS_merge$Short.Name),] # select only data in relation to coal combustion 
  
  # calculate PM 
  NS_cc <- aggregate(NS_merge$Emissions, by = list(NS_merge$year),sum)
  names(NS_cc) <- c("Year","PM")
  
  # create barplot 
  ggplot(NS_cc,aes(as.factor(Year),PM)) + geom_bar(stat = "identity", position = "dodge") + xlab("Year") + ylab("PM Coal Combustion")
  ggsave("plot4.png")
}