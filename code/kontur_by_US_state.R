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

<<<<<<< HEAD
=======

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
