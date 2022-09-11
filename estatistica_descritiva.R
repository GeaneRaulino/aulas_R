#USArrests -> Violent Crime Rates by US State
USArrests

#Nao utilizei as funcoes table, pois a base USArrests não possui colunas qualitativas, apenas numericas

#Média da variável Murder da base USArrests
mean(USArrests$Murder)

#Mediana da variável Assault da base USArrests
median(USArrests$Assault)

#Separatrizes da variável Murder da base USArrests
quantile(USArrests$Murder, probs=0.75)
quantile(USArrests$Murder, probs=0.10)
quantile(USArrests$Murder, probs=0.95)
boxplot(USArrests$Murder) 

#Desvio-padrão da variável Rape da base USArrests
sd(USArrests$Rape)
plot(USArrests$Rape)

#Desvio-padrão da variável UrbanPop da base USArrests
sd(USArrests$UrbanPop)
plot(USArrests$UrbanPop)

#Sumário descritivo básico das variáveis
summary(USArrests)

#Sumário descritivo completo das variáveis usando o pacote fBasics
pacman::p_load(fBasics)
basicStats(USArrests[ , ]) #Todas as colunas são numericas, não foi necessário limitar as colunas
hist(USArrests$Murder) # histograma - gráfico que permite conhecer a curva dos dados
