## This repository contains all relevant codes and data for our paper.
* AQI-all.csv contains the full data. Wind_1,	Wind_2,	Wind_3,	Wind_4, are average windspeeds during time periods 12AM-6AM,6AM-12PM, 12PM-6PM, 6PM-12AM respectively. Humidity_1,	Humidity_2,	Humidity_3,	Humidity_4 are the humidities recorded in the same sense as wind speed. This contains data on pollution and meteorological factors starting March 1, 2020.
* Data_CCU_ver2.csv is a subset of the above dataset and has data starting from April 21, 2020 which is the relevant part for model building.
* data_cleaning.R is the R code used for cleaning the data and making it suitable for modeling.
* data_modelling.R is the main code file for analysis and GAM fitting.
* pollutant_ts_plots.R has the codes for plotting pollutant and meteorological factors' time series data from AQI-all.csv. 
* Modeling_results.Rmd is the R markdown file for the summary outputs required for our paper. Modeling_results.pdf is its pdf version.
