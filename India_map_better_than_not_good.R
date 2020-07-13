library(raster)
library(rgdal)
library(rgeos)
library(ggplot2)
library(dplyr)
library(tidyverse)
### Q1: Assam only

### Get data
india <- getData("GADM", country = "India", level = 1)
### Choose Assam
wb <- subset(india, NAME_1 == "West Bengal")
### SPDF to DF
map <- fortify(wb)
### Draw a map
ggplot() +
  geom_map(data = map, map = map, aes(x = long, y = lat, map_id = id, group = group))
###########################################################################################################################
India <- getData("GADM", country = "India", level = 2)  
wb <- subset(India, NAME_1 == "West Bengal")
map <- fortify(wb);  
map$id <- as.factor(map$id); 
t = as.data.frame(table(map$id))
dat <- data.frame(id = t$Var1, district = wb@data$NAME_2);  
map_df <- inner_join(map, dat, by = "id");  
centers <- data.frame(gCentroid(wb, byid = TRUE));  
centers$state <- dat$district;  
###########
map_df = select(map_df,-district)
centers = centers %>% add_column(id = as.factor(row.names(centers)))
map_df = inner_join(map_df, centers, by = "id")
map_df$district = map_df$state 
map_df = select(map_df,-c(state,x,y))
#warning: id variable doesn't have correct mapping in map_df. centers has the correct mapping but in the index.
(ggwb <- ggplot() +
  geom_map(data = map_df, map = map_df,
           aes(map_id = id, x = long, y = lat, group = id), #replace id by group
           color = "#ffffff", fill = "#bbbbbb", size = 0.25) +
  geom_text(data = centers, aes(label = state, x = x, y = y), size = 2) +
  coord_map() + labs(x = "long", y = "lat", title = "Districts of WB") 
)

map_df_ccu = map_df %>% filter(district == "Kolkata")
ggplot(data = map_df_ccu) + 
  geom_polygon(aes(x = long, y = lat, group = group), color = "black",fill="white") + 
  labs(x = "long", y = "lat", title = "Kolkata") 


###########################################################################################################################
India2 <- getData("GADM", country = "India", level = 3)  
wb2 <- subset(India2, NAME_1 == "West Bengal")
kol <- subset(wb2, NAME_2 == "Kolkata")
map <- fortify(kol);  
map$id <- as.factor(map$id); 
t = as.data.frame(table(map$id))
dat <- data.frame(id = t$Var1, subreg = kol@data$NAME_3)  
map_df <- inner_join(map, dat, by = "id");  
centers <- data.frame(gCentroid(kol, byid = TRUE));  
centers$state <- dat$subreg;  
###########
map_df = select(map_df,-subreg)
centers = centers %>% add_column(id = as.factor(row.names(centers)))
map_df = inner_join(map_df, centers, by = "id")
map_df$subreg = map_df$state 
map_df = select(map_df,-c(state,x,y))
#warning: id variable doesn't have correct mapping in map_df. centers has the correct mapping but in the index.
ggplot() +
    geom_map(data = map_df, map = map_df,
             aes(map_id = id, x = long, y = lat, group = id), #replace id by group
             color = "#ffffff", fill = "#bbbbbb", size = 0.25) +
    geom_text(data = centers, aes(label = state, x = x, y = y), size = 2) +
    coord_map() + labs(x = "long", y = "lat", title = "Kolkata") 
