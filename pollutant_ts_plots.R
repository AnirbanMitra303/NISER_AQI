pollutants = read.csv("AQI-all.csv")
names(pollutants)
start_ts = as.Date("2020/03/01"); end_ts = as.Date("2020/07/31")
pollutants$Date = seq(start_ts,end_ts,"days")
panel_starts = as.Date(c("2020/03/01","2020/03/23","2020/06/01","2020/07/01"))
panel_ends = as.Date(c("2020/03/23","2020/06/01","2020/07/01","2020/07/31"))
rects <- data.frame(panel_starts, panel_ends, phase = c("before","lockdown","unlock 1","unlock 2"))
#rects$phase <- ifelse(rects$phase, "red","white","blue","yellow") #for manual color coding background, not tested
library(ggplot2)
base = ggplot() + 
  geom_rect(data = rects, aes(xmin = panel_starts, xmax = panel_ends, ymin = -Inf, ymax = Inf, 
                              fill = phase), alpha = 0.1)+
  theme(legend.position='bottom',axis.title.y = element_blank())+
  xlab("Date")+
  geom_vline(xintercept = as.Date("2020/05/20"))+
  scale_x_date(limits=range(pollutants$Date),expand = c(0,0))

# aqi = base +  geom_line(data = pollutants, aes(Date,AQI))
# aqi
#aqi + annotate("text", label = "Amphan", x = as.Date("2020/05/20"), y = 250,angle=90) 

base +  geom_line(data = pollutants, aes(Date,AQI)) + 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$AQI,na.rm = T)-50),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("AQI")
base +  geom_line(data = pollutants, aes(Date,PM2))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$PM2,na.rm = T)-50),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("PM 2.5")
base +  geom_line(data = pollutants, aes(Date,PM10))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$PM10,na.rm = T)-50),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("PM 10")
base +  geom_line(data = pollutants, aes(Date,NO2))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$NO2,na.rm = T)-20),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("NO2")
base +  geom_line(data = pollutants, aes(Date,NH3))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$NH3,na.rm = T)-1),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("NH3")
base +  geom_line(data = pollutants, aes(Date,SO2))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$SO2,na.rm = T)-10),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("SO2")
base +  geom_line(data = pollutants, aes(Date,CO))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$CO,na.rm = T)-10),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("CO")
base +  geom_line(data = pollutants, aes(Date,OZONE))+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$OZONE,na.rm = T)-50),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("O3")

base +  geom_line(data = pollutants, aes(Date,Precipitation),colour="red")+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$Precipitation,na.rm = T)-50),
            colour="black", angle=90, vjust = 1.2, size=3.5)+ggtitle("Precipitation (mm.)")

base +  geom_line(data = pollutants, aes(x = Date,y = Humidity_1, color = "12AM-6AM"),size=1)+ 
  geom_line(data = pollutants, aes(x = Date,y = Humidity_2, color = "6AM-12PM"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Humidity_3, color = "12PM-6PM"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Humidity_4, color = "6PM-12AM"),size=1)+
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$Humidity_1,na.rm = T)-50),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("Humidity (%)")+
  labs(color="Time")

base +  geom_line(data = pollutants, aes(x = Date,y = Wind_1, color = "12AM-6AM"),size=1)+ 
  geom_line(data = pollutants, aes(x = Date,y = Wind_2, color = "6AM-12PM"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Wind_3, color = "12PM-6PM"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Wind_4, color = "6PM-12AM"),size=1)+
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$Wind_4,na.rm = T)-30),
            colour="black", angle=90, vjust = 1.2, size=3.5)+ggtitle("Wind Speed (kmph)")+
  labs(color="Time")

base +   geom_line(data = pollutants, aes(x = Date,y = Min_temp, color = "Min"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Avg_temp, color = "Avg"),size=1)+
  geom_line(data = pollutants, aes(x = Date,y = Max_temp, color = "Max"),size=1)+ 
  geom_text(aes(x=as.Date("2020/05/20"), label="Amphan", y=max(pollutants$Max_temp,na.rm = T)-20),
            colour="black", angle=90, vjust = 0.2, size=3.5)+ggtitle("Temperature (degree Celcius)")+
  labs(color="Temp.")
