source("C:/MY_DATABASE/NISER_AQI/data_cleaning.R")

library(mgcv)
#mod_dat$daily_cases = log(mod_dat$daily_cases)
#########################################################################################################
####################################         Modeling Data          #####################################
#########################################################################################################

mod_dat$caseprev = log(mod_dat$caseprev)

#########################   AQI
AQI_fit <- gam(daily_cases ~ t + caseprev + AQI + s(temp) + s(wind) + s(prec) + s(hum),
               data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(AQI_fit)
summary(AQI_fit)

#########################   PM2
PM2_fit <- gam(daily_cases ~ t + caseprev + PM2 + s(temp) + s(wind) + s(prec) + s(hum),
               data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(PM2_fit)
summary(PM2_fit)

#########################   PM10
PM10_fit <- gam(daily_cases ~ t + caseprev + PM10 + s(temp) + s(wind) + s(prec) + s(hum),
                data = mod_dat,family = poisson(link = "log"),
                drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(PM10_fit)
summary(PM10_fit)

#########################   NO2
NO2_fit <- gam(daily_cases ~ t + caseprev + NO2+ s(temp) + s(wind) + s(prec) + s(hum),
               data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(NO2_fit)
summary(NO2_fit)

#########################   NH3
NH3_fit <- gam(daily_cases ~ t + caseprev + NH3 + s(temp) + s(wind) + s(prec) + s(hum),
               data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(NH3_fit)
summary(NH3_fit)


#########################   SO2
SO2_fit <- gam(daily_cases ~ t + caseprev + SO2 + s(temp) + s(wind) + s(prec) + s(hum),
               data = mod_dat,family = poisson(link = "log"),
               drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(SO2_fit)
summary(SO2_fit)

#########################   CO
CO_fit <- gam(daily_cases ~ t + caseprev + CO + s(temp) + s(wind) + s(prec) + s(hum),
              data = mod_dat,family = poisson(link = "log"),
              drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(CO_fit)
summary(CO_fit)

#########################   O3
O3_fit <- gam(daily_cases ~ t + caseprev + O3 + s(temp) + s(wind) + s(prec) + s(hum),
              data = mod_dat,family = poisson(link = "log"),
              drop.intercept = F, method = 'REML')
par(mfrow=c(2,2))
gam.check(O3_fit)
summary(O3_fit)


#########################################################################################################
##################################         Interpretations          #####################################
#########################################################################################################

newdat = rbind.data.frame(mod_dat[1,-c(2)],
                          c(15,41.75,22.875,36.625,6.125,1,4.375,12.25,36.25,28.625,7.21875,6.1375,84.5,3.713572))

predict.gam(AQI_fit,newdat)
exp(predict.gam(AQI_fit,newdat))
# interpretation of beta: unit increase in pollutant increases log(daily cases) by beta

xx = summary(AQI_fit)
mm1 = xx$cov.scaled
mm2 = vcovHC(AQI_fit,"HC0")
mm3 = vcovHAC(AQI_fit)
library(msm)
s <- deltamethod(list(~ exp(x1), ~ exp(x2), ~ exp(x3), ~ exp(x4)), 
                 xx$p.coeff, mm1[1:4,1:4])

View(xx$cov.scaled)
View(vcovHC(AQI_fit,"HC0"))
