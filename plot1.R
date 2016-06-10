if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


agg <- aggregate(Emissions~year, NEI, sum)

png("plot1.png")
plot(agg$year, agg$Emissions/10^6, xlab="Year", ylab="Emissions/(10^6)", main="Total Emissions from PM2.5")
dev.off()
