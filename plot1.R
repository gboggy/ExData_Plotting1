#Get data
setwd("~/Desktop/programming/Exploratory/Project1/ExData_Plotting1")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "../power_consumption.zip", method = "curl")
unzip("../power_consumption.zip")
fullfile <- read.table("../household_power_consumption.txt", header=TRUE, sep=";")
filesubset <- fullfile[fullfile$Date %in% c("1/2/2007", "2/2/2007"),]
rm(fullfile)

#Process data into numerical dataframe
dateandtime <- strftime(paste0(as.Date(filesubset$Date, format="%d/%m/%Y")," ", filesubset$Time), format="%Y-%m-%d, %T")
datetime <- strptime(dateandtime, format="%Y-%m-%d, %H:%M:%S")
datadatetime <- as.data.frame(datetime)
procdata <- lapply(filesubset[,3:8], function(x) as.numeric(levels(x))[x])
powerdata <- cbind.data.frame(datadatetime, procdata, filesubset$Sub_metering_3)
colnames(powerdata) <- c("datetime", colnames(powerdata)[2:7], "Sub_metering_3")

# Plot 1
png(file= "Project1/plot1.png", width = 480, height = 480, units = "px",
    bg="transparent")
with(powerdata, hist(powerdata$Global_active_power, col="Red", xlab="Global Active Power (kilowatts)",
     main ="Global Active Power"))
dev.off()

# Plot 1
par(bg="transparent")
with(powerdata, hist(Global_active_power, col="Red", xlab="Global Active Power (kilowatts)",
                     main ="Global Active Power"))
dev.copy(png, file= "Project1/plot1.png", width = 480, height = 480, units = "px", bg="transparent")
dev.off()