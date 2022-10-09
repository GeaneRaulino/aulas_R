pacman::p_load(data.table, dplyr, tidyverse, validate)

covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv') #Showing 1 to 16 of 3,596,797 entries, 16 total columns
covid19PE1 <- covid19PE %>% select(dt_notificacao, Sexo, municipio, dt_primeiros_sintomas, sintomas, hospitalizacao, faixa_etaria, tipo)

regras_covid <- validator(!is.na(faixa_etaria), !is.na(dt_primeiros_sintomas))

validacao_covid_PE <- confront(covid19PE1, regras_covid)

summary(validacao_covid_PE)

plot(validacao_covid_PE)
