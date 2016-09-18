# Plot 2
if (!require("data.table")) {
  install.packages("data.table")
}
if (!require("dplyr")) {
  install.packages("dplyr")
}
library(data.table)
library(dplyr)

# Reset layout
par(mfrow=c(1,1))

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

# Plot histogram to local png file in same folder
png(filename="plot2.png", width=480, height=480)
plot(mydf$datetime,mydf$Global_active_power,type="l", xlab ="", ylab = "Global Active Power (kilowatts)")

dev.off()


