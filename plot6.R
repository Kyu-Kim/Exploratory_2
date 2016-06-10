if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


BaltNy <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
BaltNyagg <- aggregate(Emissions~year+fips, BaltNy, sum)
BaltNyagg$fips[BaltNyagg$fips=="24510"] <- "Baltimore"
BaltNyagg$fips[BaltNyagg$fips=="06037"] <- "Los Angeles"
png("plot6.png")
g <- ggplot(BaltNyagg, aes(factor(year), Emissions))
g <- g + facet_grid(.~fips) + geom_bar(stat="identity")
g <- g + xlab("Year") + ggtitle("Total emissions comparison")
g
dev.off()