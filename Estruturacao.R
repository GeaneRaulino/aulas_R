library(data.table)
library(dplyr)
library(tidyverse)

#http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv
recife_data <- fread("http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv")

tipo_colisao <- c("COLISÃO TRASEIRA", "COLISÃO TRANSVERSAL", "COLISÃO LATERAL", "COLISÃO FRONTAL", "COLISÃO COM CICLISTA", "COLISÃO")

#filtra data de acordo com os valores do vetor tipo_colisao
recife_colisao <- recife_data %>% filter(tipo %in% tipo_colisao)

mRecife <- recife_colisao %>% group_by(bairro) %>% mutate(row = row_number()) %>% select(data, hora, natureza_acidente, row, endereco)
result <- mRecife %>% group_by(bairro) %>% filter(row == max(row))
mRecife <- mRecife %>% filter(row<=min(result$row))

# pivota o data frame de long para wide
mRecifeNew <- mRecife %>% pivot_wider(names_from = row, values_from = row )  %>% column_to_rownames(var="bairro") 

