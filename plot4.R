if(!file.exists("pm.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="pm.zip", mode="wb")
  unzip("pm.zip")
}


if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


library(ggplot2)
M <- merge(NEI, SCC, by="SCC")
coal <- grepl("coal", M$Short.Name, ignore.case=TRUE)
Mcoal <- M[coal,]
Coalagg <- aggregate(Emissions~year, Mcoal, sum)
png("plot4.png")
g<-ggplot(Coalagg, aes(factor(year), Emissions/10^5))
g<-g+geom_bar(stat="identity") + xlab("Year") + ylab("Emissions/(10^5)") + ggtitle("Total Emissions from coal sources")
g
dev.off()
