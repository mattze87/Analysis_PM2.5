plot6 <- function() {
  
  # read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # vlookup to select only data in relation to Motor Vehicles and Baltimore City  
  NEI_BaltLA <- NEI[(NEI$fips == "24510" | NEI$fips == "06037"),]
  NEI_BaltLA$SCC <- as.factor(NEI_BaltLA$SCC)
  NS_merge <- merge(NEI_BaltLA,SCC, by.x = "SCC", by.y = "SCC", all.x = TRUE) # left join
  NS_merge <- NS_merge[grep("Motor",NS_merge$Short.Name),] # select only data in relation to Motor Vehicles
  
  # calculate PM 
  NS_cc <- aggregate(NS_merge$Emissions, by = list(NS_merge$year,NS_merge$fips),sum)
  names(NS_cc) <- c("Year","State","PM")
  NS_cc$State <- gsub("06037","LA",NS_cc$State)
  NS_cc$State <- gsub("24510","Baltimore",NS_cc$State)
  
  # create barplot 
  ggplot(NS_cc,aes(as.factor(State),PM, fill = factor(Year))) + geom_bar(stat = "identity", position = "dodge") + xlab("Year") + ylab("PM Motor Vehicles")
  ggsave("plot6.png")
}