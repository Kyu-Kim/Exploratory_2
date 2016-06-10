if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")



Balt <- NEI[NEI$fips=="24510",]
Baltagg <- aggregate(Emissions~year, Balt, sum)
png("plot2.png")
plot(Baltagg$year, Baltagg$Emissions, xlab="Year", ylab="Emissions", main="Total Baltimore Emissions")
dev.off()
