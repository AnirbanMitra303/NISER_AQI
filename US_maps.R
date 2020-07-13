library(ggplot2)
library(dplyr)
library(maps)
library(viridis)
#library(ggmap)
theme_set(
  theme_void()
)
world_map <- map_data("world")
world_map = world_map %>% filter(region == "India")
#world_map <- map_data("county",region = "new jersey")

ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

states <- map_data("state")
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend

west_coast <- subset(states, region %in% c("california", "oregon", "washington"))

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat), fill = "palegreen", color = "black") 
ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)

ca_df <- subset(states, region == "california")
counties <- map_data("county")
ca_county <- subset(counties, region == "california")

ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
ca_base + theme_void()

ca_base + theme_void() + 
  geom_polygon(data = ca_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top

library(stringr)
library(dplyr)

# make a data frame
x <- readLines("ca-counties-wikipedia.txt")
pop_and_area <- str_match(x, "^([a-zA-Z ]+)County\t.*\t([0-9,]{2,10})\t([0-9,]{2,10}) sq mi$")[, -1] %>%
  na.omit() %>%
  str_replace_all(",", "") %>% 
  str_trim() %>%
  tolower() %>%
  as.data.frame(stringsAsFactors = FALSE)

# give names and make population and area numeric
names(pop_and_area) <- c("subregion", "population", "area")
pop_and_area$population <- as.numeric(pop_and_area$population)
pop_and_area$area <- as.numeric(pop_and_area$area)

cacopa <- inner_join(ca_county, pop_and_area, by = "subregion")
cacopa$people_per_mile <- cacopa$population / cacopa$area
# prepare to drop the axes and ticks but leave the guides and legends
# We can't just throw down a theme_nothing()!
ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

elbow_room1 <- ca_base + 
  geom_polygon(data = cacopa, aes(fill = people_per_mile), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_bw() +
  ditch_the_axes

elbow_room1

elbow_room1 + scale_fill_gradient(trans = "log10")
eb2 <- elbow_room1 + 
  scale_fill_gradientn(colours = rev(rainbow(7)),
                       breaks = c(2, 4, 10, 100, 1000, 10000),
                       trans = "log10")
eb2
eb2 + xlim(-123, -121.0) + ylim(36, 38)
eb2 + coord_fixed(xlim = c(-123, -121.0),  ylim = c(36, 38), ratio = 1.3)

