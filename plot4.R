#plot4
library(data.table)
library(dplyr)

setwd("/home/boole2/coursera/exploratoryDataAnalysis/Prj1")
getwd()
if(!file.exists("household_power_consumption.txt")){
        
        unzip(zipfile = "./exdata-data-household_power_consumption.zip", exdir = "./")
}
list.files()

df_household_power <-  read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

ddtt <- paste( df_household_power$Date, df_household_power$Time)
d <- strptime(ddtt, format="%d/%m/%Y %H:%M:%S")

dt_housrhold_date <-  data.frame( date_time = d, df_household_power)

dt_housrhold <- data.table(dt_housrhold_date)
head(dt_housrhold)
dt_household <- dt_housrhold %>% 
        mutate(Date = as.Date(Date))
dt_twoday <- dt_household %>% filter( date_time >=  as.POSIXct("2007-02-01 00:00:00", format ="%Y-%m-%d %H:%M:%S")  
                                      & date_time <= as.POSIXct("2007-02-03 00:00:00",format ="%Y-%m-%d %H:%M:%S"))
head(dt_twoday)
tail(dt_twoday)

png(file = "plot4.png")
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(dt_twoday, plot(date_time, Global_active_power,
                     main = "", 
                     xlab ="",
                     ylab = "Global Active Power (kilowatts) ", 
                     type="l") )
with(dt_twoday, plot(date_time, Sub_metering_1,
                     main = "", 
                     xlab ="",
                     ylab = "Energy Sub Metering ", 
                     type="l") )
with(dt_twoday, lines(date_time, Sub_metering_2, col = "red" ))
with(dt_twoday, lines(date_time, Sub_metering_3, col = "blue" ))


legend( "topright", inset=.0001 , c( "Sub_metering_1","Sub_metering_2","Sub_metering_3"  ), 
        lty=c(1,1), 
        text.font=6,
        col= c("black", "blue","red"),
        cex =0.6)
with(dt_twoday, plot(date_time, Voltage,
                     main = "", 
                     xlab ="datetime",
                     ylab = "Voltage) ", 
                     type="l") )
with(dt_twoday, plot(date_time, Global_reactive_power,
                     main = "", 
                     xlab ="datetime",
                     ylab = "Global_reactive_power) ", 
                     type="l") )


dev.off()