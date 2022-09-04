library(ade4)
library(arules)
library(forcats)

#base disponibilizada no git do professor e salva no computador
facebook <- read.table("bases_originais/facebook_2021.csv", sep=";", header = T)
str(facebook)

# conversão em fatores

for(i in 2:7) {
  facebook[,i] <- as.factor(facebook[,i]) } 

str(facebook)

# filtro por tipo de dado

factorsFacebook <- unlist(lapply(facebook, is.factor))  
facebookFactor <- facebook[ , factorsFacebook]
str(facebookFactor)

# One Hot Encoding
facebookDummy <- acm.disjonctif(facebookFactor)

# Discretização
inteirosFacebook <- unlist(lapply(facebook, is.integer))  
facebookInteiros <- facebook[, inteirosFacebook]
str(facebookInteiros)

#A coluna "num_loves" não é bem distribuida
facebookInteiros$num_loves.Disc <- discretize(facebookInteiros$num_loves, method = "interval", breaks = 3, labels = c("poucos", 'médio', 'muitos'))

# forcats - usando tidyverse para fatores
fct_count(facebookFactor$status_type) # conta os fatores

fct_anon(facebookFactor$status_type) # anonimiza os fatores

fct_lump(facebookFactor$status_type, n = 2) # reclassifica os fatores em mais comum e outros photo, video e other
