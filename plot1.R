# Plot 1
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
# systime <- system.time(rawdata <- read.csv(file, sep=";", header=TRUE, colClasses = classes, na.strings="?"))
systime <- system.time(rawdata <- read.csv(file, sep=";", header=TRUE, na.strings="?"))

mydf <- tbl_df(rawdata) %>%
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >="2007-02-01" & Date <= "2007-02-02") 

# Plot histogram and copy to png file in same folder
hist(mydf$Global_active_power, 
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",col = "red")

dev.copy(png,file="plot1.png")
dev.off()



  