pollutants = read.csv("AQI-all.csv")
names(pollutants)
start_ts = as.Date("2020/03/01"); end_ts = as.Date("2020/08/01")
pollutants$Date = seq(start_ts,end_ts,"days")
panel_starts = c(as.Date("2020/03/01","2020/03/23","2020/06/01","2020/07/01"))
panel_ends
library(ggplot2)
ggplot(pollutants, aes(x=Date, y=AQI)) +
  geom_line()
