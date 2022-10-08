pacman::p_load(data.table, Hmisc, VIM)

world_data <- fread('https://covid.ourworldindata.org/data/owid-covid-data.csv')
world_data1 <- world_data %>% filter(continent !='')
world_data1 <- world_data1 %>% select(location,total_cases,total_cases_per_million, population) #base contem NA a partir da linha 6615 até 6676 nas colucas total_cases e total_cases_per_million


#Tendência central
world_data1$total_cases <- impute(world_data1$total_cases, fun = mean) #média


is.imputed(world_data1$total_cases) #teste se o valor foi imputado
table(is.imputed(world_data1$total_cases)) #tabela de imputação por sim / não
world_data1 #Linha 6615 valor imputado 1083141

#Hot deck imputação por instâncias

world_data2 <- world_data %>% filter(continent !='')
world_data2 <- world_data2 %>% select(location,total_cases,total_cases_per_million, population) #base contem NA a partir da linha 6615 até 6676 nas colucas total_cases e total_cases_per_million
(world_data2$total_cases <- impute(world_data2$total_cases, "random"))
world_data2 #Linha 6615 valor imputado 332822