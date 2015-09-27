## Exploratory Data Analysis -- Peer Assignment 2 ##
## plot4.R

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

## Obtain SCC for coal combustion-related sources, using 'SCC.Level.Three' variable
coalSCC <- dataSCC[grep("Coal", dataSCC$SCC.Level.Three), "SCC"]

## Select only the coal-related data from dataNEI
coalNEI <- dataNEI[dataNEI$SCC %in% coalSCC, ]

png("plot4.png", width=480, height=480)

totalEmissions <- aggregate(Emissions ~ year, data=coalNEI, sum)
plot(totalEmissions, type = "b", pch=18, col="blue",
     main = "Total Emissions from Coal Combustion-related\n Sources from 1999 to 2008",
     xlab = "Year",
     ylab = expression('PM'[2.5]*" Emission"))
dev.off()

print("Q: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?")
print("A: They abruptly decreased between 2005 and 2008.")
