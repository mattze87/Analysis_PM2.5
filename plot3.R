plot3 <- function() {
  
  # load required packages 
  library(ggplot2)
  
  # read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # sum PM[2.5] for fips "24510" per Year (only 1999,2008) and per Type 
  data <- NEI[NEI$fips == "24510" & (NEI$year == "1999" | NEI$year == "2008") ,]
  data <- aggregate(data$Emissions, by = list(data$type,data$year), sum)
  names(data) <- c("Type","Year","PM")
  
  # create barplot 
  ggplot(data,aes(Type,PM, fill = factor(Year))) + geom_bar(stat = "identity", position = "dodge") 
  ggsave("plot3.png")
}