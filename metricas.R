
pacman::p_load(ade4, car, caret, corrplot, data.table, dplyr, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse, mboost)

#Base utilizada, será base USRegionalMortality disponível

USRegionalMortality_Base <- USRegionalMortality

USRegionalMortality_D <- acm.disjonctif(as.data.frame(USRegionalMortality_Base$Region))
names(USRegionalMortality_D) <- c('Region01', 'Region02', 'Region03', 'Region04', 'Region05', 'Region06', 'Region07', 'Region08', 'Region09', 'Region10')

USRegionalMortality_Base <- cbind(USRegionalMortality_Base, USRegionalMortality_D)

#discretização
USRegionalMortality_Base$Rate <- discretize(USRegionalMortality_Base$Rate, method = "frequency", breaks = 2, labels = c("baixa", "alta"))

#Treino e teste
particaoMortality = createDataPartition(USRegionalMortality_Base$Rate, p=.7, list = F)
treinoMortality = USRegionalMortality_Base[particaoMortality,]
testeMortality = USRegionalMortality_Base[-particaoMortality,]

#controle de treinamento
train.control <- trainControl(method = "cv", number = 40, verboseIter = T)


#Máquina de vetor de Suporte (SVM)
mortality_SVM_CLASS <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "svmLinear", trControl = train.control)
mortality_SVM_CLASS
plot(varImp(mortality_SVM_CLASS))


#cria predição
predicaoRF_Mortality = predict(mortality_SVM_CLASS,testeMortality$Rate)


#cria matriz de confusão
cmRF2 <- confusionMatrix(predicaoRF_Mortality, testeMortality$Rate) 
cmRF2 #baixa acuracia e baixo kappa, modelo ainda não ideal
cmRF2$table


gtBaixa <- cmRF2$table[1]+cmRF2$table[2]
gtAlta <- cmRF2$table[3]+cmRF2$table[4]

pdBaixa <- cmRF2$table[1]+cmRF2$table[3]
pdAlta <- cmRF2$table[2]+cmRF2$table[4]

gtTotal <- gtAlta + gtBaixa
estAcc <- (gtBaixa*pdBaixa/gtTotal^2)+(gtAlta*pdAlta/gtTotal^2)
estAcc
