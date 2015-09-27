## Exploratory Data Analysis -- Peer Assignment 2 ##
## plot3.R

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

library("ggplot2")

png("plot3.png", width=480, height=480)
g <- ggplot(BaltimoreNEI, aes(year, Emissions, color = type))
  # summary(g)
diagram <- g + geom_line(stat = "summary", fun.y = "sum") +
    xlab("Year") +
    ylab(expression("PM"[2.5]*' Emission')) +
    ggtitle("Total Emissions in Baltimore City\n by the Type from 1999 to 2008")
print(diagram)
dev.off()

print("Q1: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?")
print("A1: NONPOINT, NON-ROAD, and ON-ROAD types.")
print("Q2: Which have seen increases in emissions from 1999-2008?")
print("A2: POINT type")
