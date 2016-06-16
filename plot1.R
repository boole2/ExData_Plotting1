#
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

png(file = "plot1.png")
with(dt_twoday, hist(Global_active_power,
                     main = "Global Active Power", 
                     col = "red",
                     xlab = "Global Active Power (kilowatts) ", 
                     ylab = "Frequency") )

dev.off()



