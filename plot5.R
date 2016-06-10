if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


BaltRoad <- NEI[NEI$fips=="24510" & NEI$type == "ON-ROAD",]
BRagg <- aggregate(Emissions~year, BaltRoad, sum)
png("plot5.png")
g<-ggplot(BRagg, aes(factor(year), Emissions))
g<-g+geom_bar(stat="identity")+xlab("Year")+ggtitle("Total Emissions from Motor in Baltimore")
g
dev.off()
