## ---- results='hide', message=FALSE--------------------------------------
include <- function(library_name){
  if( !(library_name %in% installed.packages()) )
    install.packages(library_name)
  library(library_name, character.only = TRUE)
}

include("rvest")
include("tidyr")
include("tidyverse")
include("stringr")
include("data.table")
include("rjson")
#fire arm table for data by state for firearm mortality
FireArm <- read_csv("https://raw.githubusercontent.com/introdsci/DataScience-AdamGonzalezJr/master/Firearm%20Mortality%20by%20State.csv")

#Crime per state for the past 40 years
Crime <- read.csv("https://raw.githubusercontent.com/introdsci/DataScience-AdamGonzalezJr/master/ucr_crime_1975_2015.csv")



## ------------------------------------------------------------------------

#two different ways of setting the new column names
old = c("ORI", "year", "department_name", "total_pop")
new = c("police_identifier", "year_of_crime", "state", "population")
setnames(Crime, old, new)

#setting the column names a different way for the rest of them 
setnames(Crime, old = c("homs_sum", "rape_sum", "rob_sum", "agg_ass_sum") , new = c("homicide_total", "rape_total", "robbery_total", "aggrivated_assault_total"))


#settings names in the FireArm data tables
setnames(FireArm, old = c("YEAR", "STATE", "RATE", "DEATHS"), new = c("year_of_data", "state_of_shootings", "rate_per_month", "deaths_per_year"))



## ------------------------------------------------------------------------

#this selects the coloumns from the data table and removes them
select(Crime, -c("source", "url"))



## ------------------------------------------------------------------------

#creating a new table and that holds the value of deaths per month
FireArmDeathsPerMonth <- tibble(year_of_data = FireArm$year_of_data, state_of_shootings = FireArm$state_of_shootings, rate_per_month = FireArm$rate_per_month)

#creating a new table that has deaths per year
FireArmDeathsPerYear <- tibble(year_of_data = FireArm$year_of_data, state_of_shootings = FireArm$state_of_shootings, rate_per_year = FireArm$deaths_per_year)

## just testing to see 
## ------------------------------------------------------------------------
homicide <- tibble(year_of_homicide = Crime$year_of_crime, state_of_homicide = Crime$state, total_homicides = Crime$homicide_total)
rape <- tibble(year_of_rape = Crime$year_of_crime, state_of_rape = Crime$state, rape_total = Crime$rape_total)
robbery <- tibble(year_of_robbery = Crime$year_of_crime, state_of_robbery = Crime$state, robbery_total = Crime$robbery_total)
aggrivated_assault <- tibble(year_of_assaults = Crime$year_of_crime, state_of_assaults = Crime$state, assault_total = Crime$aggrivated_assault_total)
violentcrimes <- tibble(year_of_violent_crimes = Crime$year_of_crime, state_of_violent_crimes = Crime$state, violent_crime_total = Crime$violent_crime)



## ------------------------------------------------------------------------
ggplot(FireArm, aes(x=year_of_data, y = deaths_per_year)) + geom_col(bandwidth = 1)



## ------------------------------------------------------------------------
ggplot(Crime, aes(x=year_of_crime, y = homicide_total)) + geom_col(color = 'red')
ggplot(Crime, aes(x=year_of_crime, y = rape_total)) + geom_col(color = 'blue')
ggplot(Crime, aes(x=year_of_crime, y = robbery_total)) + geom_col(color = 'green')
ggplot(Crime, aes(x=year_of_crime, y = aggrivated_assault_total)) + geom_col(color = 'pink')
ggplot(Crime, aes(x=year_of_crime, y = violent_crime)) + geom_col(color = 'yellow')

