#!/usr/bin/env bash

wget -P data/raw/ -nc https://geodata-eu-central-1-kontur-public.s3.amazonaws.com/kontur_datasets/kontur_population_US_20220630.gpkg.gz
unzip -n -d data/raw data/raw/kontur_population_US_20220630.gpkg.gz