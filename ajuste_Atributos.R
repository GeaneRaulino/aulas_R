pacman::p_load(dplyr, ggplot2, data.table, gridExtra)

#Dados covid mundial
world_data <- fread('https://covid.ourworldindata.org/data/owid-covid-data.csv')
world_data1 <- world_data %>% filter(continent !='')


#Agrupar casos por país
world_dataLocation <- world_data1 %>% count(continent, sort = T, name = 'total_cases') %>% mutate(casos2 = sqrt(total_cases), casosLog = log10(total_cases))


nomeVar <- names(world_dataLocation)[2:4] 
listaPlots <- NULL


for(i in nomeVar) {
  plot <- world_dataLocation %>% ggplot(aes_string(x = 'continent', y=i)) + geom_bar(stat = "identity") + labs(x = "continent")
  listaPlots[[length(listaPlots) + 1]] <-plot
} # criar lista com os plots

# printar todos os plots, lado a lado
grid.arrange(listaPlots[[1]], listaPlots[[2]], listaPlots[[3]], ncol=3)
