library(dplyr)
library(data.table)

prepareData <- function(){
  # read Data: file "household_power_consumption.txt" must be available in the working directory  
  data <- fread("./household_power_consumption.txt", header=TRUE, sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)
  
  # conver String to Date
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  
  # choose Data between 007-02-01 and 2007-02-02 
  data <- filter(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
  # merger Date and Time in new column
  data <- data %>% mutate(Date_Time = paste(Date, Time, sep=" ")) %>% select(-c("Date", "Time"))
  
  # Format dateTime Column
  data$Date_Time <- as.POSIXct(data$Date_Time)
  data
}

createPNGPlot <- function(data, file_name){
  png(file=file_name,height=480, width=480)
  hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
  dev.off()
}
data <- prepareData()
createPNGPlot(data, "plot1.png")






