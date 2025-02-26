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

# Plot
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot 1: Global Active Power vs Time
plot(data$datetime, data$Global_active_power, type = "l", 
    ylab = "Global Active Power", xlab = "",
    xaxt = "n")
axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))

# Plot 2: Voltage vs Time
plot(data$datetime, data$Voltage, type = "l",
    ylab = "Voltage", xlab = "datetime",
    xaxt = "n")
axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))

# Plot 3: Energy Sub Metering vs Time
plot(data$datetime, data$Sub_metering_1, type = "l",
    ylab = "Energy sub metering", xlab = "",
    xaxt = "n")
axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      lty = 1, col = c("black", "red", "blue"), bty = "n")

# Plot 4: Global Reactive Power vs Time
plot(data$datetime, data$Global_reactive_power, type = "l",
    ylab = "Global_reactive_power", xlab = "datetime",
    xaxt = "n")
axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))

dev.off()