# Exploratory data analysis project 1 plot 4
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

# plot 4  multiple plot
# create png file
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
with(proj1_df1, plot(x= Datelt, y= Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l" ))
with(proj1_df1, plot(x= Datelt, y= Voltage, ylab = "Voltage", xlab = "datetime", type = "l" ))
yrange<- range(c( proj1_df1$Sub_metering_1, proj1_df1$Sub_metering_2, proj1_df1$Sub_metering_3))
plot(x=proj1_df1$Datelt,y= proj1_df1$Sub_metering_1, ylim = yrange, col = "black", type = "l", ylab ="Energy sub metering", xlab ="")
lines(x= proj1_df1$Datelt, y=proj1_df1$Sub_metering_2, type ="l", col = "red")
lines(x= proj1_df1$Datelt,y=proj1_df1$Sub_metering_3, type = "l" ,col ="blue")
legend('topright',legend= c("Sub meter 1", "Sub meter 2", "Sub meter 3"), lty= c(1,1,1), lwd =c(2,2,2), col = c("black", "red", "blue"), bty ="n")
with(proj1_df1, plot(x= Datelt, y= Global_reactive_power, type ="l", xlab = "datetime"))
dev.off()
