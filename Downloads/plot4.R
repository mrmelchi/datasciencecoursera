# Exploratory Data Analysis
# Course Project 1
# plot 4

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

# Convert character string to 'Date? format for easier manipulation
twoday$datetime <- as.POSIXct(paste(twoday$Date, twoday$Time), format="%d/%m/%Y %H:%M:%S")

# Open PNG device, create plot4.png file
png(filename = 'plot4.png' ,width = 480, height = 480)
par(mfrow = c(2, 2))
with(twoday, {
    # topleft plot
    with(twoday,plot(datetime,Global_active_power,xlab = '',
                     ylab = 'Global Active Power',type ='l'))
    #top right plot
    plot(datetime, Voltage, type = 'l')
    
    #bottom left plot
    with(twoday,{
        plot(datetime,Sub_metering_1, xlab = '', ylab = 'Energy sub metering',type ='l')
        lines(datetime,Sub_metering_2, col = 'red',type = 'l')
        lines(datetime,Sub_metering_3, col = 'blue',type = 'l')
        legend("topright",col = c('black','red','blue'),
               legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
               lty = 1, bty = "n")
    })
    # bottom right plot 
    plot(datetime, Global_reactive_power, type = 'l')
})

# Close the PNG file device
dev.off()

# Back to initial working directory
setwd(entrywd)

