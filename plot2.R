# Exploratory data analysis project 1, plot2

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "explore_proj1.zip")
  unzip("explore_proj1.zip") ## yields "household_power_consumption.txt"
}

proj1_df<- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE)
library(dplyr)
library(lubridate)
proj1_df1<- proj1_df %>% 
  filter(Date == "2/2/2007" | Date == "1/2/2007") %>%
  mutate(Date_long  = paste(Date, Time, sep =" "))

proj1_df1$Datelt<- parse_date_time(proj1_df1$Date_long, order = "dmy  hms" )


#plot Global active power vs time
png("plot2.png", width = 480, height = 480)

with(proj1_df1, plot(x= Datelt, y= Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l" ))
dev.off()
