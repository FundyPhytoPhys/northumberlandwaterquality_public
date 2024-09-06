# Code Read Me

DataStreamImport.Rmd

This script uses packages to support direct import of marine microbial contamination data via public API from DataStream (https://atlanticdatastream.ca, "Mount Allison Phyto Lab Data" dataset). The imported data (DataIn/"DataStreamALL.Rds") contains ECCC Shellfish Survey data only until year 2015. Code/"ShellfishSurvey_DSConvert.Rmd" generates DataStream formatted ECCC Shellfish Survey data for years 2016-2022 for Kouchibouguac and Shediac Bays (ProcessedData/"ECCCDataKouchShediac.Rds"). The DataStream and updated ECCC Shellfish Survey datasets are combined, subset into three Northumberland Strait study sites (Kouchibouguac Bay, Shediac Bay and Parlee Beach Provincial Park), and saved as .Rds files for further manipulation in Code/"DataClean.Rmd".


WeatherCanImport.Rmd

This script uses packages to support direct import of Environment and Climate Change Canada weather (and tide) data into R. New columns are added generating variables used in a Shiny app (Code/"Facet_app_WQ.R") for data exploration. Weather data are saved as TidiedData/"KouchWeatherDay.Rds", "ShediacWeatherDay.Rds" for further use in Code/"DataClean.Rmd".


ShellfishSurvey_DSConvert.Rmd

This script uses packages to import and format Environment and Climate Change Canada Shellfish Survey data from "Shellfish Water Classification Program – Marine Water Quality Data in New Brunswick" for years 2016-2022. Data is downloaded manually as .csv from the Open Government Data Portal as two separate files a) bacteria data: DataIn/"Shellfish_Samples_Mollusques_Echantillons_NB.csv" and b) monitoring location data: DataIn/"Shellfish_Sites_Mollusques_NB.csv". These file are then imported into R for tidying and conversion to DataStream upload format (TidiedData/"ECCCDataKouchShediac.Rds"). This new data is added to the existing DataStream dataset and further manipulated in Code/"DataStreamImport.Rmd". Note: the Kouchibouguac Bay and Shediac Bay datasets targeted for update in this script were not uploaded to DataStream because the DataStream team are currently working to implement an automated direct data download process from the ECCC Shellfish Survey database.


NBBeaches_DSConvert.Rmd

This script uses packages to import and tidy New Brunswick Provincial Park Beach monitoring data (https://beaches.gnb.ca). Data is downloaded manually as .xlsx, saved as .csv (DataIn/"Parlee_Status_2022_23.csv", "Parlee_Data_2022_23.csv") and imported into R for tidying and conversion to DataStream upload format (https://atlanticdatastream.ca). Here Parlee Beach Provincial Park data is imported for years 2022-23, tidied and saved as TidiedData/"Parlee_2022_23.csv" for direct upload to DataStream.


DataClean.Rmd

This script uses packages to combine marine microbial contamination data from DataStream (https://atlanticdatastream.ca) and weather data from Environment and Climate Change Canada (https://climate.weather.gc.ca/historical_data/search_historic_data_e.html) previously imported via API (Code/"DataStreamImport.Rmd", "WeatherCanImport.Rmd") at three sites on the Northumberland Strait: Shediac Bay, Kouchibouguac Bay and Parlee Beach Provincial Park. This combined bacteria/weather dataset (ProcessedData/"KouchShediacParleeData.Rds") is loaded into a Shiny app (Code/"Facet_app_WQ.R") to visualize water quality patterns. Based on those visualizations, statistical models and plots are then generated (see Code/"DataProcess.Rmd").


DataProcess.Rmd

This script takes the combined bacteria/weather data file generated in "DataClean.Rmd" (ProcessedData/"KouchShediacParleeData.Rds") and applies a binomial model to test for interactions between variables. Various tables and figures are generated for use in the final manuscript "NorthumberlandManuscript.Rmd" (Figures/"StatsAll_table1.rds", "StatsAll_table2.rds", "KouchShediacParleeBinom_fig.png", "StatsAll_table3.rds", "precip_prior48_fig.png", "measurement_date_fig.png", "mean_temp_prior48_fig.png").


Facet_app_WQ.R

Northumberland Water Quality Simple Shiny App used for data exploration.