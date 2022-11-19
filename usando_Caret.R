##Regresão Início
pacman::p_load(ade4, car, caret, corrplot, data.table, dplyr, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse, mboost)

#Base utilizada, será base USRegionalMortality disponível

USRegionalMortality_Base <- USRegionalMortality

USRegionalMortality_D <- acm.disjonctif(as.data.frame(USRegionalMortality_Base$Region))
names(USRegionalMortality_D) <- c('Region01', 'Region02', 'Region03', 'Region04', 'Region05', 'Region06', 'Region07', 'Region08', 'Region09', 'Region10')

USRegionalMortality_Base <- cbind(USRegionalMortality_Base, USRegionalMortality_D)

#discretização
USRegionalMortality_Base$Rate <- discretize(USRegionalMortality_Base$Rate, method = "frequency", breaks = 2, labels = c("baixa", "alta"))

status(USRegionalMortality_Base)
freq(USRegionalMortality_Base)
plot_num(USRegionalMortality_Base)
profiling_num(USRegionalMortality_Base)

#Treino e teste
particaoMortality = createDataPartition(USRegionalMortality_Base$Rate, p=.7, list = F)
treinoMortality = USRegionalMortality_Base[particaoMortality,]
testeMortality = USRegionalMortality_Base[-particaoMortality,]

#controle de treinamento
train.control <- trainControl(method = "cv", number = 40, verboseIter = T)

#Regressão Linear
mortality_LM <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "lm", trControl = train.control)
summary(mortality_LM)
plot(varImp(mortality_LM))

#Árvore de decisão
mortality_RPART <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "rpart", trControl = train.control)
summary(mortality_RPART)
fancyRpartPlot(mortality_RPART$finalModel)
plot(varImp(mortality_RPART))
#Para a base utilizada o modelo de árvore de decisão não é uma boa escolha

#Bagging com floresta aleatória
mortality_RF <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "cforest", trControl = train.control)
plot(mortality_RF)
plot(varImp(mortality_RF))

#Boosting com boosted generalized linear model
mortality_ADA <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "glmboost", trControl = train.control)
plot(mortality_ADA)
print(mortality_ADA)
summary(mortality_ADA)



melhor_modelo <- resamples(list(LM = mortality_LM, RPART = mortality_RPART, RF = mortality_RF, ADABOOST = mortality_ADA))
melhor_modelo

summary(melhor_modelo)


##Regresão Fim




##Classificação Início

#Máquina de vetor de Suporte (SVM)
mortality_SVM_CLASS <- train(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, method = "svmLinear", trControl = train.control)
mortality_SVM_CLASS
plot(varImp(mortality_SVM_CLASS))

#criar máquina 
svmMortality <- svm(Rate ~ Region01 + Region02 + Region03 + Region04 + Region05 + Region06 + Region07 + Region08 + Region09 + Region10, data = treinoMortality, cost = 10, scale = F)
svmMortality
plot(svmMortality, treinoMortality, Region09 ~ Region10)


melhor_modelo2 <- resamples(list(SVM = mortality_SVM_CLASS, LM = mortality_LM, RPART = mortality_RPART, RF = mortality_RF, ADABOOST = mortality_ADA))
melhor_modelo2

summary(melhor_modelo2)


predVals2 <- extractPrediction(list(SVM = mortality_SVM_CLASS, RPART = mortality_RPART, RF = mortality_RF, ADABOOST = mortality_ADA), testX = testeMortality[, c(7:16)], testY = testeMortality$Rate) 

plotObsVsPred(predVals2)
##Classificação Fim

