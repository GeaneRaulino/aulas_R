pacman::p_load(dplyr)


#Carrega a base de snistros de transito do site da PCR
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2018Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2485590a-3b35-4ad0-b955-8dfc36b61021/download/acidentes_2018.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw
sinistrosRecife2021Raw
sinistrosRecife2018Raw



colunas_iguais <- names(sinistrosRecife2018Raw[ intersect( names(sinistrosRecife2018Raw), names(sinistrosRecife2020Raw) ) ] ) 
colunas_iguais <- intersect(colunas_iguais, names(sinistrosRecife2021Raw))
colunas_iguais

sinistrosRecife2018Raw <- sinistrosRecife2018Raw %>% select(all_of(colunas_iguais))
sinistrosRecife2020Raw <- sinistrosRecife2020Raw %>% select(all_of(colunas_iguais))
sinistrosRecife2021Raw <- sinistrosRecife2021Raw %>% select(all_of(colunas_iguais))

sinistrosRecife2020Raw
sinistrosRecife2021Raw
sinistrosRecife2018Raw

sinistrosRecifeRaw <- rbind( sinistrosRecife2018Raw, sinistrosRecife2020Raw, sinistrosRecife2021Raw)
sinistrosRecifeRaw
#Observa a estrutura dos dados
str(sinistrosRecifeRaw)

#Cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}


#Modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$acidente_verificado)





#### Staging area e uso de memória

ls() # lista todos os objetos no R

# vamos ver quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

ls() # lista todos os objetos no R

# agora, vamos remover

gc() # uso explícito do garbage collector

rm(list = c('sinistrosRecife2018Raw', 'sinistrosRecife2020Raw', 'sinistrosRecife2021Raw')) #Exemplos que ainda estavam na memória do R


rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

#Exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

#Exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

