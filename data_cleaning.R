rm(list=ls())
rawdat = read.csv("Data_CCU_ver2.csv") # read data #read.csv("Data_CCU.csv")
#clean data
#rawdat = rawdat[1:54,]
cleanup  = data.frame(t = 1:(nrow(rawdat)-1))
cleanup$daily_cases = diff(rawdat$Total_cumulative_cases_Kolkata)
library(xts)
library(pracma)
cleanup$AQI = movavg(rawdat$AQI[-1],n=8,type = "s")
cleanup$PM2 = movavg(rawdat$PM2.5.Average.[-1],n=8,type = "s")
cleanup$PM10 = movavg(rawdat$PM10.Average.[-1],n=8,type = "s")
cleanup$NO2 = movavg(rawdat$NO2.Average.[-1],n=8,type = "s")
cleanup$NH3 = movavg(rawdat$NH3.Average.[-1],n=8,type = "s")
cleanup$SO2 = movavg(rawdat$SO2.Average.[-1],n=8,type = "s")
cleanup$CO = movavg(rawdat$CO.Average.[-1],n=8,type = "s")
cleanup$SO2 = movavg(rawdat$SO2.Average.[-1],n=8,type = "s")
cleanup$O3 = movavg(rawdat$OZONE.Average.[-1],n=8,type = "s")
cleanup$temp = movavg(rawdat$Avg_temp[-1],n=8,type = "s")
cleanup$wind = movavg(rawdat$Avg_wind_speed[-1],n=8,type = "s")
cleanup$prec =  movavg(rawdat$Precipitation[-1],n=8,type = "s")
cleanup$hum = movavg(rawdat$Avg_humidity[-1],n=8,type = "s")
#cleanup$date = seq(as.Date("2020/04/22"),as.Date("2020/06/13"),"days")
cleanup = na.omit(cleanup)
#cleanup <- xts(select(cleanup,-"date"), order.by=cleanup$date)
mod_dat = cleanup[2:nrow(cleanup),]
mod_dat$caseprev = cleanup$daily_cases[1:(nrow(cleanup)-1)]

# time-series plots
rawdat2 = data.frame(day = 1:nrow(rawdat))
rawdat2$New_cases_WB = rawdat$New_cases_WB
rawdat2$New_Tests_WB = rawdat$New_Tests_WB
rawdat2$Total_cumulative_cases_Kolkata = rawdat$Total_cumulative_cases_Kolkata
rawdat2$AQI = rawdat$AQI
rawdat2$PM2 = rawdat$PM2.5.Average.
rawdat2$PM10 = rawdat$PM10.Average.
rawdat2$NO2  = rawdat$NO2.Average.
rawdat2$NH3 = rawdat$NH3.Average.
rawdat2$SO2 = rawdat$SO2.Average.
rawdat2$CO = rawdat$CO.Average.
rawdat2$O3 = rawdat$OZONE.Average.
rawdat2 = na.omit(rawdat2)


