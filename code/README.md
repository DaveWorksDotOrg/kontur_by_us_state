# File: get_kontur_data.bash

Kontur population density for 400m H3 hexagons for the United States was downloaded on 14 February 2023 from:

* [United States of America: Population Density for 400m H3 Hexagons](https://data.humdata.org/dataset/kontur-population-united-states-of-america)

Data is licensed for reuse under [Creative Commons Attribution International (CC BY) License](https://creativecommons.org/licenses/by/4.0/legalcode).
No changes were made to the data.

# File: kontur_by_US_state.R

## Load kontur geopackage file using sf package. 

Returns a simple feature collection of polygons with 4,268,708 features.
Variables: fid (index of record upload order), h3 (H3 index of hexagons), population (total population inside hexagon), geom (polygon, EPSG: 3857)

Note this data only covers the 50 US states plus the District of Columbia. The US territories (American Samoa, Guam, Puerto Rico, Commonwealth of the Northern Mariana Islands, and US Virgin Islands) have their own individual data files.

## Load shapefiles for the states using tigris package.

Returns a simple feature collection of multi-polygons. Note, this data covers all US states and territories so we will need to filter to match the kontur data.

## Load population data using tidycensus package.

Note this data covers the 50 US states plus the District of Columbia AND Puerto Rico so we will need to filter to match the kontur data.

## Align Coordinate Reference Systems (CRS)

CRS for tigris and census data need to match the kontur data in order to use geospatial information during analysis.

`st_crs(kontur)     # CRS: WGS 84     EPSG: 3857
st_crs(tigris_us)  # CRS: NAD83      EPSG: 4269
st_crs(census)     # CRS: NAD83      EPSG: 4269`

