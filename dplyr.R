library(dplyr)

facebook <- read.table("https://raw.githubusercontent.com/GeaneRaulino/aulas_R/main/bases_originais/facebook_2021.csv", sep=";", header = T)

#sumários
count(facebook, status_type) 

#sumários com agrupamentos
facebook %>% group_by(status_type) %>% summarise(avg = mean(num_reactions))


#seleção de casos
facebook %>%  filter(status_type != "video") %>% summarise(avg = mean(num_reactions))


#seleção de colunas utilizando quantidade de likes e tipo, ordenando pela data de publicação
facebook %>% select(num_likes, status_type) %>% arrange(facebook$status_published)


#renomear
facebook %>% rename(Type = status_type)

