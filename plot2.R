plot2 <- function() {
  
  ## read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # sum PM[2.5] for fips "24510" per Year 
  data <- NEI[NEI$fips == "24510",]
  data <- tapply(data$Emissions, data$year, sum)
  data <- data/1000000
  
  # create barplot 
  png(file = "plot2.png")
  barplot(data, xlab = "Year", ylab = "total PM[2.5] in Mil., Baltimore")
  dev.off()
}