dev.off()
source("C:/MY_DATABASE/NISER_AQI/data_cleaning.R")
library(dplyr)
rawdat2$date = seq(as.Date("2020/05/04"),as.Date("2020/06/13"),"days")
rawdat2 = xts(select(rawdat2,-"date"), order.by = rawdat2$date )
mod_dat$date = seq(as.Date("2020/05/06"),as.Date("2020/06/13"),"days")
mod_dat <- xts(select(mod_dat,-"date"), order.by=mod_dat$date)
cleanup$date = seq(as.Date("2020/05/05"),as.Date("2020/06/13"),"days")
cleanup <- xts(select(cleanup,-"date"), order.by=cleanup$date)
# rawdat2 = rawdat[,c("New_cases_WB","New_Tests_WB","Total_cumulative_cases_Kolkata",
#                                   "Total.COVID.19.Cases.Confirmed..WB.","Total.deaths.due.to.COVID.19.WB.",
#                                   "AQI","PM2.5.Average.","PM10.Average.","NO2.Average.","NH3.Average.",
#                                   "SO2.Average.","CO.Average.","OZONE.Average.")]

# par(mfrow=c(2,1))
# ts.plot(rawdat2$Total_cumulative_cases_Kolkata,ylab=NA,main="cumulative cases"); ts.plot(cleanup$daily_cases,ylab=NA,main="daily cases")
# ts.plot(rawdat2$AQI,ylab=NA,main="AQI"); ts.plot(cleanup$AQI,ylab=NA,main="AQI 8-moving avg")
# ts.plot(rawdat2$PM2.5.Average.,ylab=NA,main="PM2.5"); ts.plot(cleanup$PM2,ylab=NA,main="PM2.5 8-moving avg")
# ts.plot(rawdat2$PM10.Average.,ylab=NA,main="PM10"); ts.plot(cleanup$PM10,ylab=NA,main="PM10 8-moving avg")
# ts.plot(rawdat2$NO2.Average.,ylab=NA,main="NO2"); ts.plot(cleanup$NO2,ylab=NA,main="NO2 8-moving avg")
# ts.plot(rawdat2$NH3.Average.,ylab=NA,main="NH3"); ts.plot(cleanup$NH3,ylab=NA,main="NH3 8-moving avg")
# ts.plot(rawdat2$SO2.Average.,ylab=NA,main="SO2"); ts.plot(cleanup$SO2,ylab=NA,main="SO2 8-moving avg")
# ts.plot(rawdat2$CO.Average.,ylab=NA,main="CO"); ts.plot(cleanup$CO,ylab=NA,main="CO 8-moving avg")
# ts.plot(rawdat2$OZONE.Average.,ylab=NA,main="O3"); ts.plot(cleanup$O3,ylab=NA,main="O3 8-moving avg")


par(mfrow=c(2,1))
plot(rawdat2$Total_cumulative_cases_Kolkata,ylab=NA,main="cumulative cases"); plot(cleanup$daily_cases,ylab=NA,main="daily cases")
plot(rawdat2$AQI,ylab=NA,main="AQI"); plot(cleanup$AQI,ylab=NA,main="AQI 8-moving avg")
plot(rawdat2$PM2,ylab=NA,main="PM2.5"); plot(cleanup$PM2,ylab=NA,main="PM2.5 8-moving avg")
plot(rawdat2$PM10,ylab=NA,main="PM10"); plot(cleanup$PM10,ylab=NA,main="PM10 8-moving avg")
plot(rawdat2$NO2,ylab=NA,main="NO2"); plot(cleanup$NO2,ylab=NA,main="NO2 8-moving avg")
plot(rawdat2$NH3,ylab=NA,main="NH3"); plot(cleanup$NH3,ylab=NA,main="NH3 8-moving avg")
plot(rawdat2$SO2,ylab=NA,main="SO2"); plot(cleanup$SO2,ylab=NA,main="SO2 8-moving avg")
plot(rawdat2$CO,ylab=NA,main="CO"); plot(cleanup$CO,ylab=NA,main="CO 8-moving avg")
plot(rawdat2$O3,ylab=NA,main="O3"); plot(cleanup$O3,ylab=NA,main="O3 8-moving avg")
