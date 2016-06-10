if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


library(ggplot2)
Balt <- NEI[NEI$fips=="24510",]
Baltagg <- aggregate(Emissions~year+type, Balt, sum)
png("plot3.png")
g <- ggplot(Baltagg, aes(year, Emissions, color=type))
g<-g+geom_line()+xlab("Year")+ylab("Emissions")+ggtitle("Total Emissions in Baltimore City")
print(g)
dev.off()
