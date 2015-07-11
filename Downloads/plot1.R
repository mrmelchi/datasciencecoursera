# Exploratory Data Analysis
# Course Project 1
# plot 1

DownloadDirectory <- "Downloads"
if (!(file.exists(DownloadDirectory))) dir.create(DownloadDirectory)

## Set the working directory to the folder where the Project Downloads will be stored
entrywd<-getwd()
setwd(paste(entrywd,"/Downloads",sep=""))
if (!(file.exists("hpc.zip"))){ 
    ## Downloads zip with data collected from household_power_consumption
    hpc.url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    hpc.zipFileName="hpc.zip"
    download.file(
        url = hpc.url,
        destfile = hpc.zipFileName,
        mode = "wb")
    hpc.downloadDate <- date()
    hpc.downloadDate
    }
# Unzip the file on the working directory 
if (!(file.exists("household_power_consumption.txt"))){
    hpc.fileName <- unzip(zipfile = hpc.zipFileName)}

# Read txt file
hpc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

# See basic characteristic from data
dim(hpc)
str(hpc)
# Extract subset data from the dates 2007-02-01 and 2007-02-02
twoday <- subset(hpc,Date == "1/2/2007" | Date== "2/2/2007")
table(twoday$Date)
summary(twoday$Global_active_power)

# Disabling scientific notation in R
options(scipen = 999)

## Plot 1
# Open PNG device, create plot1.png file
png(filename = 'plot1.png' ,width = 480, height = 480)
hist(twoday$Global_active_power,col='red',main = 'Global Active Power',xlab = 'Global Active Power (kilowatts)')
# Close the PNG file device
dev.off()

# Back to initial working directory
setwd(entrywd)
