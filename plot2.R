## Exploratory Data Analysis -- Peer Assignment 2 ##
## plot2.R

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

## data of Baltimore City, MD (fips == "24510")
BaltimoreNEI = subset(dataNEI, fips==24510)
  # dim(BaltimoreNEI)

png("plot2.png", width=480, height=480)
totalEmissions <- aggregate(Emissions ~ year, data=BaltimoreNEI, sum)
plot(totalEmissions, type = "b", pch=18, col="blue",
     main = "Total Emissions from all sources\n in Baltimore from 1999 to 2008",
     xlab = "Year",
     ylab = expression('PM'[2.5]*" Emission"))
dev.off()

print("Q: Have total emissions from PM2.5 decreased in Baltimore City, Maryland?")
print("A: Basically, yes. But the paatern is down, a bit up, and down again.")
