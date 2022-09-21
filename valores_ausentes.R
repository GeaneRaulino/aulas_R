pacman::p_load(data.table, funModeling, tidyverse, VIM) 
sleep
data()
library("VIM")


latin_america <- fread('https://covid.ourworldindata.org/data/owid-covid-data.csv')
latin_america1 <- latin_america %>% select(total_cases, new_cases,new_cases_smoothed, new_deaths, new_deaths_smoothed, reproduction_rate, icu_patients)

latin_america2 <- latin_america %>% select(location, total_cases, new_cases,new_cases_smoothed, new_deaths, new_deaths_smoothed, reproduction_rate, icu_patients)


latin_americaNA <- as.data.frame(abs(is.na(latin_america1))) #cria a matrix sombra
head(latin_americaNA)

latin_americaNA <- latin_americaNA[which(sapply(latin_americaNA, sd) > 0)] 
cor(latin_americaNA)

cor(latin_america1, latin_americaNA, use="pairwise.complete.obs") 

round(cor(latin_americaNA), 3)


latin_americaNA <- cbind(latin_americaNA, country = latin_america2$location) # trazemos uma variável de interesse (location = country) de volta pro frame
latin_americaCountry <- latin_americaNA %>% group_by(country) %>% summarise(across(everything(), list(sum)))
covid19PENAMun <- covid19PENA %>% group_by(municipio) %>% summarise(across(everything(), list(sum)))