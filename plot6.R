## Exploratory Data Analysis -- Peer Assignment 2 ##
## plot6.R

## Download and upzip the source files are not under ./data sub-folder:
if (!file.exists("./data/summarySCC_PM25.rds")) {
    # Make a sub-folder "data", unless it exists
    if (!dir.exists("./data")) {
        dir.create("./data")
    }
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile="./data/NEI_data.zip")
    unzip("./data/NEI_data.zip", exdir = "./data")
}

## Read the source data files
dataNEI <- readRDS("./data/summarySCC_PM25.rds")
dataSCC <- readRDS("./data/Source_Classification_Code.rds")

## data of Baltimore City, MD (fips == "24510") and LA Country, CA (fips == "06037")
BM_LA_NEI <- subset(dataNEI, (fips=="24510" | fips=="06037"))

## Obtain SCC for motor vehicle sources, using 'EI.Sector' variable
vehicleSCC <- dataSCC[grep("Mobile.*Vehicles", dataSCC$EI.Sector), "SCC"]

## Select only the coal-related data from BaltimoreNEI, data of Baltimore City
vehicleNEI <- BM_LA_NEI[BM_LA_NEI$SCC %in% vehicleSCC, ]

library("ggplot2")

png("plot6.png", width=480, height=480)
g <- ggplot(vehicleNEI, aes(year, Emissions, color = fips))
diagram <- g + geom_line(stat = "summary", fun.y = "sum") +
    xlab("Year") +
    ylab(expression("PM"[2.5]*' Emission')) +
    ggtitle("Total Emissions in Baltimore City and\n Los Angeles County from 1999 to 2008") +
    scale_colour_discrete(name = "City/County", label = c("LA County","Baltimore City"))
print(diagram)
dev.off()

print("Q: Which city/county has seen greater changes over time in motor vehicle emissions?")
print("A: Los Angeles County.")