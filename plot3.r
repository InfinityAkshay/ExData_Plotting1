# Read the data
if (!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "data.zip")
    unzip("data.zip")
}

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")


# Create PNG file
png("plot3.png", width=480, height=480)

# Plot lines
plot(
    data$datetime,
    data$Sub_metering_1, 
    type = "l", 
    ylab = "Energy sub metering", 
    xlab = "",
    xaxt = "n",
    col  = "black"
)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")

axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))
# Add legend
legend(
    "topright", 
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty=1,
    col=c("black", "red", "blue")
)

# Close device
dev.off()