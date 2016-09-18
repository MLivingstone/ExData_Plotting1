# Plot 4
if (!require("data.table")) {
  install.packages("data.table")
}
if (!require("dplyr")) {
  install.packages("dplyr")
}
library(data.table)
library(dplyr)

file = "household_power_consumption.txt"

# Read in data, using the first 5 rows to determine the column classes
rawdata <- read.table(file, sep=";", header=TRUE, stringsAsFactors = FALSE, nrows = 5, na.strings="?")
classes <- sapply(rawdata, class)
rawdata <- read.csv(file, sep=";", header=TRUE, colClasses = classes, na.strings="?")

mydf <- tbl_df(rawdata) %>%
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >="2007-02-01" & Date <= "2007-02-02") %>%
  mutate(datetime = paste(Date,Time)) %>%
  select(datetime,Global_active_power:Sub_metering_3)

mydf$datetime <-strptime(mydf$datetime,"%Y-%m-%d %H:%M:%S")

par(mfrow=c(2,2))

## Plot 1
plot(mydf$datetime,mydf$Global_active_power,type="l", ylab = "Global Active Power")

## Plot 2
plot(mydf$datetime,mydf$Voltage,type="l", xlab ="datetime", ylab = "Voltage")

## Plot 3
with(mydf, {
  plot(datetime,Sub_metering_1,type="l", xlab="", ylab = "Energy sub metering")
  points(datetime,Sub_metering_2,type="l",col="red")
  points(datetime,Sub_metering_3,type="l",col="blue")
})
legend("topright",lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       inset=c(0.16,0,0,0),
       bty = "n", cex = 0.9, y.intersp = 1.3)

## Plot 4
plot(mydf$datetime,mydf$Global_reactive_power,type="l", xlab ="datetime", ylab = "Global_reactive_power")


# Copy to local png file
dev.copy(png,file="plot4.png")
dev.off()


