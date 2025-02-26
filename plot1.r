# Read the data
if (!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "data.zip")
    unzip("data.zip")
}

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Plot
png('plot1.png', width = 480, height = 480)
hist(data$Global_active_power, 
    col = "red",
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    breaks = 12
)
dev.off()
