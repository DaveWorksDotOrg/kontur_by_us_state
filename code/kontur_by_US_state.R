################################################################################
################################################################################
##                          KONTUR DATA BY US STATE                           ##
################################################################################
################################################################################

# This code groups Kontur population density data by US State.

################################################################################
#                                Load Libraries                                #
################################################################################

library(sf)
library(tigris)
library(tidycensus)
library(tidyverse)
library(mapview)
library(ggplot2)
library(jsonlite)
library(dplyr)

################################################################################
#                                  Load Data                                   #
################################################################################

# Load kontur geopackage file using sf package. 

kontur <- st_read("E:/Projects/ferry_konturbystate_2023/data/raw/kontur_population_US_20220630.gpkg")

head(kontur,5)

# Load shapefiles for the states using tigris package.

tigris_us <- states(year = 2020, cb = FALSE)
tigris_us <- tigris_us %>%
  filter(STUSPS != "PR", STUSPS != "VI", STUSPS != "AS", 
         STUSPS != "MP", STUSPS != "GU")

# Load population data using tidycensus package.

census <- get_decennial(geography = "state",
                        variables = "P1_001N",
                        year = 2020,
                        sumfile = "pl",
                        geometry = TRUE,
                        keep_geo_vars = TRUE)
census <- census %>%
  filter(STUSPS != "PR")

# Align Coordinate Reference Systems (CRS)

tigris_us <- st_transform(tigris_us, 3857)
census <- st_transform(census, 3857)


################################################################################
#                     Initial parse of data by state                           #
################################################################################

# Create data frame of which kontur lines match with each state.
# WARNING! This next code block took my system approximately 4 hours to run.

state_list <- as.list(tigris_us$STUSPS[])
ix <- data.frame()
for (i in state_list) {
  state <- tigris_us %>% filter(STUSPS == i)
  ix_list <- list()
  ix_list <- st_intersects(state, kontur)
  ix_list <- cbind(i, ix_list)
  ix <- rbind(ix, ix_list)
}
colnames(ix) <- c("state", "lines")

# Steps to write to and read from a json file in case you need to let code run overnight
address = "E:/Projects/ferry_konturbysate_2023/data/processed/kontur_US_tigris_intersections.json"
ix_json <- toJSON(ix, dataframe = 'rows', pretty = TRUE)
write(ix_json, address)
