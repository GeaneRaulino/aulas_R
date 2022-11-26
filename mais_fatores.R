##########
install.packages("readxl")
library(microbenchmark)
library(data.table)
library(dplyr)
library(tidyverse)
library(funModeling) 
library(writexl)
library(readxl)

pacman::p_load(data.table, dplyr, plotly, EnvStats, forcats, arules, ade4)

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

#Conversão em fatores

for(k in 2:7) {
  sinistrosRecife2021Raw[,k] <- as.factor(sinistrosRecife2021Raw[,k]) 
} 

str(sinistrosRecife2021Raw)

#Filtro por tipo de dado
factorsSinistrosRecife2021Raw <- unlist(lapply(sinistrosRecife2021Raw, is.factor)) 
factorsSinistrosRecife2021Raw
sinistroFactor <- sinistrosRecife2021Raw[ factorsSinistrosRecife2021Raw ]
sinistroFactor

str(sinistroFactor)

#One Hot Encoding
sinistrosDummy <- acm.disjonctif(sinistroFactor)

#Discretização
inteirosSinistro <- unlist(lapply(sinistrosRecife2021Raw, is.integer))  
inteirosSinistro <- sinistrosRecife2021Raw[, inteirosSinistro]
str(inteirosSinistro)

#Discretização
inteirosSinistro$vitimas <- discretize(inteirosSinistro$vitimas, method = "interval", breaks = 3, labels = c("poucos", 'médio', 'muitos'))
inteirosSinistro
sinistroFactor

#Forcats - usando tidyverse para fatores
fct_count(sinistroFactor$natureza_acidente) # conta os fatores

fct_anon(sinistroFactor$natureza_acidente) # anonimiza os fatores

fct_lump(sinistroFactor$natureza_acidente, n = 2) # reclassifica os fatores em COM VÍTIMA, SEM VÍTIMA e OTHER
