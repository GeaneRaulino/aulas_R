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

rm(list = c('amostraBinomial', 'amostraNormal')) #Exemplos que ainda estavam na memória do R

# deletando todos os elementos: rm(list = ls())
# deletando todos os elementos, menos os listados: rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))
rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")