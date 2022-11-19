#carregar as bibliotecas
pacman::p_load(ade4, car, caret, corrplot, data.table, dplyr, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse, mboost)

#Base utilizada, será base Wine disponível no pacote Rattle
wine_B <- rattle::wine

#Dummy
wine_Dummy <- acm.disjonctif(as.data.frame(wine_B$Type))
names(wine_Dummy) <- c('Tipo1','Tipo2','Tipo3')

wine_B <- cbind(wine_B,wine_Dummy)

#discretização
wine_B$AlcoholDisc <- discretize(wine_B$Alcohol, method = "interval", breaks = 2, labels = c("baixo", "alto"))

table(wine_B$AlcoholDisc)

#Treino e teste

particao_WineB = createDataPartition(wine_B$AlcoholDisc, p=.7, list = F) # cria a partição 70-30
treino_WineB  = wine_B[particao_WineB, ] # treino
teste_WineB  = wine_B[-particao_WineB, ] # - treino = teste

table(wine_B$AlcoholDisc)


#Treino down/under
treinWineDownUnder <- downSample(x = treino_WineB[, -ncol(treino_WineB)], y = treino_WineB$AlcoholDisc)
table(treinWineDownUnder$Class)   

#Treino Up
treinoWineUp <- upSample(x = treino_WineB[, -ncol(treino_WineB)], y = treino_WineB$AlcoholDisc)
table(treinoWineUp$Class) 
