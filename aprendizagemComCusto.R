#carregar as bibliotecas
pacman::p_load(ade4, car, caret, corrplot, data.table, dplyr, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse, mboost)

#Base utilizada, será base Wine disponível no pacote Rattle

wineB <- rattle::wine

wineDummy <- acm.disjonctif(as.data.frame(wineB$Type))
names(wineDummy) <- c('Tipo1','Tipo2','Tipo3')

wineB <- cbind(wineB,wineDummy)

#discretização
wineB$AlcoholDisc <- discretize(wineB$Alcohol, method = "frequency", breaks = 2, labels = c("baixo", "alto"))

table(wineB$AlcoholDisc)

#Treino e teste

particaoWineB = createDataPartition(wineB$AlcoholDisc, p=.7, list = F) # cria a partição 70-30
treinoWineB  = wineB[particaoWineB, ] # treino
testeWineB  = wineB[-particaoWineB, ] # - treino = teste

prop.table(table(wineB$AlcoholDisc)) #verificar tabela desbalanceada

#controle de treinamento
train.control <- trainControl(method = "cv", number = 40, verboseIter = T)


matrizCusto <- matrix(c(0,1000,1,0), ncol = 2)
rownames(matrizCusto) <- levels(treinoWineB$AlcoholDisc)
colnames(matrizCusto) <- levels(treinoWineB$AlcoholDisc)
matrizCusto


wine_RF_CLASS <- randomForest(Alcohol ~ Tipo1 + Tipo2 + Tipo3 + Color + Dilution + Alcalinity + Flavanoids, data = treinoWine, method = "cforest", parms = list(loss = matrizCusto))
wine_RF_CLASS

wine_C5_CLASS <- train(Alcohol ~ Tipo1 + Tipo2 + Tipo3 + Color + Dilution + Alcalinity + Flavanoids, data = treinoWine, method = "C5.0Cost", trControl = train.control)
wine_C5_CLASS

predicaoWINE_RF_CLASS = predict(wine_RF_CLASS, testeWineB) # criar predição
cmWINE_RF_CLASS <- confusionMatrix(predicaoWINE_RF_CLASS, testeWineB$AlcoholDisc)
cmWINE_RF_CLASS

predicaoWINE_C5_CLASS = predict(wine_C5_CLASS, testeWineB) # criar predição
cmWINE_C5_CLASS <- confusionMatrix(predicaoWINE_C5_CLASS, testeWineB$AlcoholDisc)
cmWINE_C5_CLASS
