
pacman::p_load(ade4, car, caret, corrplot, data.table, dplyr, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse, mboost)

#Base utilizada, será base Wine disponível no pacote Rattle

wineBase <- rattle::wine


wineD <- acm.disjonctif(as.data.frame(wineBase$Type))
names(wineD) <- c('Tipo1','Tipo2','Tipo3')


wineBase <- cbind(wineBase,wineD)

#discretização
wineBase$Alcohol <- discretize(wineBase$Alcohol, method = "frequency", breaks = 2, labels = c("baixo", "alto"))

#Treino e teste

particaoWine = createDataPartition(wineBase$Alcohol, p=.7, list = F) # cria a partição 70-30
treinoWine  = wineBase[particaoWine, ] # treino
testeWine  = wineBase[-particaoWine, ] # - treino = teste

#controle de treinamento
train.control <- trainControl(method = "cv", number = 40, verboseIter = T)


#Máquina de vetor de Suporte (SVM)

wine_SVM_CLASS <- train(Alcohol ~ Tipo1 + Tipo2 + Tipo3 + Color + Dilution + Alcalinity + Flavanoids, data = treinoWine, method = "svmLinear", trControl = train.control)
wine_SVM_CLASS
plot(varImp(wine_SVM_CLASS))

#cria matriz de confusão e predição


predicaoWineRF <- predict(wine_SVM_CLASS, testeWine) # criar predição
cmWineRF <- confusionMatrix(predicaoWineRF, testeWine$Alcohol)
cmWineRF
cmWineRF$table

gtBaixa <- cmWineRF$table[1]+cmWineRF$table[2]
gtAlta <- cmWineRF$table[3]+cmWineRF$table[4]

pdBaixa <- cmWineRF$table[1]+cmWineRF$table[3]
pdAlta <- cmWineRF$table[2]+cmWineRF$table[4]

gtTotal <- gtAlta + gtBaixa
estAcc <- (gtBaixa*pdBaixa/gtTotal^2)+(gtAlta*pdAlta/gtTotal^2)
estAcc
