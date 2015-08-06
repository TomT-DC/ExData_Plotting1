# Exploratory data analysis project 1 plot1.R

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "explore_proj1.zip")
  unzip("explore_proj1.zip") ## yields "household_power_consumption.txt"
}

# read the data, cut it to just 2/1/2007 through 2/2/2007, combine the date and time columns as a datetime
proj1_df<- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE)
library(dplyr)
library(lubridate)
proj1_df1<- proj1_df %>% 
  filter(Date == "2/2/2007" | Date == "1/2/2007") %>%
  mutate(Date_long  = paste(Date, Time, sep =" "))
proj1_df1$Datelt<- parse_date_time(proj1_df1$Date_long, order = "dmy  hms" )


# create png file 
png("plot1.png", width = 480, height = 480)
# plot histogram of Global Active Power"
with(proj1_df1, hist(Global_active_power, col ="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
