plot1 <- function() {
  
  ## read in data 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # sum PM[2.5] per Year 
  data <- tapply(NEI$Emissions, NEI$year, sum)
  data <- data/1000000
  
  # create barplot 
  png(file = "plot1.png")
  barplot(data, xlab = "Year", ylab = "total PM[2.5] in Mil.")
  dev.off()
}