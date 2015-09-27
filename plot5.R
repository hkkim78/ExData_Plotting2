## Exploratory Data Analysis -- Peer Assignment 2 ##
## plot5.R

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

## Obtain SCC for motor vehicle sources, using 'EI.Sector' variable
vehicleSCC <- dataSCC[grep("Mobile.*Vehicles", dataSCC$EI.Sector), "SCC"]

## Select only the vehicle-related data from data of Baltimore City, BaltimoreNEI
vehicleNEI <- BaltimoreNEI[BaltimoreNEI$SCC %in% vehicleSCC, ]

png("plot5.png", width=480, height=480)
totalEmissions <- aggregate(Emissions ~ year, data=vehicleNEI, sum)
plot(totalEmissions, type = "b", pch=18, col="blue",
     main = "Total Emissions from Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City",
     xlab = "Year",
     ylab = expression('PM'[2.5]*" Emission"))
dev.off()

print("Q: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? ")
print("A: They decreased, especially abruptly between 1999 and 2002.")