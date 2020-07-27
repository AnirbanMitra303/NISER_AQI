rawdat = read.csv("Data_CCU.csv") # read data
#clean data
rawdat = rawdat[1:54,]
cleanup  = data.frame(t = 1:(nrow(rawdat)-1))
cleanup$daily_cases = diff(rawdat$Total_cumulative_cases_Kolkata)
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
cleanup = na.omit(cleanup)
mod_dat = cleanup[2:nrow(cleanup),]
mod_dat$caseprev = cleanup$daily_cases[1:(nrow(cleanup)-1)]

# time-series plots
rawdat2 = na.omit(rawdat)
par(mfrow=c(2,1))
ts.plot(rawdat2$AQI); ts.plot(cleanup$AQI)
ts.plot(rawdat2$PM2.5.Average.); ts.plot(cleanup$PM2)
ts.plot(rawdat2$PM10.Average.); ts.plot(cleanup$PM10)


library(mgcv)
#mod_dat$daily_cases = log(mod_dat$daily_cases)
mod_dat$caseprev = log(mod_dat$caseprev)

#########################   AQI
AQI_fit <- gam(daily_cases ~ t + caseprev + AQI,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(AQI_fit)
summary(AQI_fit)

#########################   PM2
PM2_fit <- gam(daily_cases ~ t + caseprev + PM2,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(PM2_fit)
summary(PM2_fit)

#########################   PM10
PM10_fit <- gam(daily_cases ~ t + caseprev + PM10,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(PM10_fit)
summary(PM10_fit)

#########################   NO2
NO2_fit <- gam(daily_cases ~ t + caseprev + NO2,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(NO2_fit)
summary(NO2_fit)

#########################   NH3
NH3_fit <- gam(daily_cases ~ t + caseprev + NH3,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(NH3_fit)
summary(NH3_fit)


#########################   SO2
SO2_fit <- gam(daily_cases ~ t + caseprev + SO2,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(SO2_fit)
summary(SO2_fit)

#########################   CO
CO_fit <- gam(daily_cases ~ t + caseprev + CO,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(CO_fit)
summary(CO_fit)

#########################   O3
O3_fit <- gam(daily_cases ~ t + caseprev + O3,data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(O3_fit)
summary(O3_fit)



