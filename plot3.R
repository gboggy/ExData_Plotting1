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

#Plot 3
# par(bg="transparent")
# with(powerdata, plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
# with(powerdata, lines(Time, Sub_metering_2, col="Red"))
# with(powerdata, lines(Time, Sub_metering_3, col="Blue"))
# legend("topright", lty = 1, col=c("black","blue", "red"),
#        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
#        cex=0.75, pt.cex=2)
# dev.copy(png, file= "Project1/plot3.png", bg="transparent", width = 480, height = 480, units = "px")
# dev.off()

#Plot 3
png(file= "Project1/plot3.png", width = 480, height = 480, units = "px",
    bg="transparent")
par(bg="transparent")
with(powerdata, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(powerdata, lines(datetime, Sub_metering_2, col="Red"))
with(powerdata, lines(datetime, Sub_metering_3, col="Blue"))
legend("topright", lty = 1, col=c("black","blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=1, pt.cex=1)
dev.off()
