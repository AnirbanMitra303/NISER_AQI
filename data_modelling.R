source("C:/MY_DATABASE/NISER_AQI/data_cleaning.R")

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
