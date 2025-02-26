# Read the data
if (!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "data.zip")
    unzip("data.zip")
}

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
data$datetime <- as.POSIXct(paste(data$Date, data$Time))

# Plot
png('plot2.png', width = 480, height = 480)
plot(
    data$datetime, 
    data$Global_active_power, 
    type="l", 
    ylab="Global Active Power (kilowatts)", 
    xlab="",
    xaxt="n"  # Suppress default x-axis
)
# Create three points for the axis labels
axis(1, at = c(min(data$datetime), mean(data$datetime), max(data$datetime)),
     labels = c("Thu", "Fri", "Sat"))
dev.off()