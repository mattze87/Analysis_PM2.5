plot5 <- function() {
  
  # read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # vlookup to select only data in relation to Motor Vehicles and Baltimore City  
  NEI_Balt <- NEI[NEI$fips == "24510",]
  NEI_Balt$SCC <- as.factor(NEI_Balt$SCC)
  NS_merge <- merge(NEI_Balt,SCC, by.x = "SCC", by.y = "SCC", all.x = TRUE) # left join
  NS_merge <- NS_merge[grep("Motor",NS_merge$Short.Name),] # select only data in relation to Motor Vehicles
  
  # calculate PM 
  NS_cc <- aggregate(NS_merge$Emissions, by = list(NS_merge$year),sum)
  names(NS_cc) <- c("Year","PM")
  
  # create barplot 
  ggplot(NS_cc,aes(as.factor(Year),PM)) + geom_bar(stat = "identity", position = "dodge") + xlab("Year") + ylab("PM Motor Vehicles, Baltimore")
  ggsave("plot5.png")
}