#Carregando pacotes
pacman::p_load(dplyr, tidyverse, readxl)


latin_america <- fread('https://covid.ourworldindata.org/data/owid-covid-data.csv')
latin_america1 <- latin_america %>% select(iso_code, location, total_cases, new_cases,new_cases_smoothed, new_deaths, new_deaths_smoothed, reproduction_rate, icu_patients)

latin_america1 <- latin_america1 %>% filter(new_cases>=0)

latin_america1 <- latin_america1 %>% filter(new_cases_smoothed !='NA') 
latin_america1 <- latin_america1 %>% filter(new_deaths !='NA') 
latin_america1 <- latin_america1 %>% filter(new_deaths_smoothed !='NA') 
latin_america1 <- latin_america1 %>% filter(reproduction_rate !='NA') 
latin_america1 <- latin_america1 %>% filter(icu_patients !='NA') #27384 linhas

#base baixada do site https://data.worldbank.org/indicator/SP.POP.TOTL com a população total de cada país
countries <- read.csv2('https://raw.githubusercontent.com/GeaneRaulino/aulas_R/main/bases_originais/countries_total_population.csv')
countries <- countries %>% select(Country.Name, Country.Code, X2021)

#join de base de covid com pupalação dos países
latin_america1 <- left_join(latin_america1, countries, by = c('iso_code' = 'Country.Code'))
