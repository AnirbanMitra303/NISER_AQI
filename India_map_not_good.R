
###############################################################################################
#map <- get_map(location = 'India', zoom = 4)
library(sf)
my_sf <- st_read("C:/MY_DATABASE/NISER_AQI/viz_india-master/india_states_2014/india_states.shp")
library(GADMTools)
india_wrapper <- gadm_sf.loadCountries("IND", level = 1, basefile = "./")
my_spdf <- as(my_sf, "Spatial")
class(my_spdf)
str(my_spdf, max.level = 2)
library(tidyverse)
glimpse(my_spdf@data)
ind_sf <- st_as_sf(my_spdf)
class(ind_sf)
head(ind_sf, 3)
glimpse(ind_sf)
uts <- c("Delhi", "Andaman & Nicobar Islands", "Puducherry",
         "Lakshadweep", "Dadra & Nagar Haveli", "Daman & Diu",
         "Chandigarh")

ind_sf <- ind_sf %>%
  select(name, abbr) %>%
  mutate(
    type = ifelse(name %in% uts, "Union Territory", "State")
  ) %>%
  rename(abb = abbr, state_ut = name)
class(ind_sf)
attributes_df <- readRDS("C:/MY_DATABASE/NISER_AQI/viz_india-master/attributes.rds")
ind_sf <- ind_sf %>%
  left_join(attributes_df, by = "state_ut") %>%
  mutate(
    per_capita_gdp_inr = nominal_gdp_inr / pop_2011,
    per_capita_gdp_usd = nominal_gdp_usd / pop_2011
  )
glimpse(ind_sf)
library(units)
# mutate area
ind_sf <- ind_sf %>%
  mutate(my_area = st_area(.))

# convert units
units(ind_sf$my_area) <- with(ud_units, km^2)

# mutate gdp density
ind_sf <- ind_sf %>%
  mutate(gdp_density_usd_km2 = nominal_gdp_usd / my_area)
class(ind_sf$area_km2)
class(ind_sf$my_area)
# strip units class
ind_sf <- ind_sf %>%
  mutate(
    my_area = as.vector(my_area),
    gdp_density_usd_km2 = as.vector(gdp_density_usd_km2)
  )

original_geometry <- st_geometry(ind_sf)

library(rmapshaper)
simp_sf <- rmapshaper::ms_simplify(ind_sf, keep = 0.01, keep_shapes = TRUE)
simple_geometry <- st_geometry(simp_sf)

par(mfrow = c(1,2))
plot(original_geometry, main = "Original Geometry")
plot(simple_geometry, main = "Simplified Geometry")

wb_sf = simp_sf %>% filter(state_ut == "West Bengal")
simple_wb <- st_geometry(wb_sf)
plot(simple_wb, main = "Simplified Geometry")
saveRDS(simp_sf, "simp_sf.rds")
library(tidyverse)
library(sf)
simp_sf <- readRDS("simp_sf.rds")
plot(simp_sf['pop_2011'])
