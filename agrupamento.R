#Carregar bibliotecas
pacman::p_load(cluster, dplyr, factoextra, ggplot2)

library(carData)
Arrests

#Pré-processamento
Arrests_cluster <- Arrests[ , -5]
Arrests_cluster <- Arrests_cluster[ , -1]
Arrests_cluster <- Arrests_cluster[ , -1]
Arrests_cluster <- Arrests_cluster[ , -3]
Arrests_cluster <- Arrests_cluster[ , -3]
str(Arrests_cluster)

#Definir semente aleatória
set.seed(1)


fviz_nbclust(Arrests_cluster, kmeans, method = "wss")

#Agrupamento com kmeans
cls <- kmeans(x = Arrests_cluster, centers = 3) # aprendizagem ns
Arrests_cluster$cluster <- as.factor(cls$cluster) # passamos os clusters para a base original
head(Arrests_cluster)

#Plot
clusplot(Arrests_cluster, cls$cluster, xlab = 'Fator1', ylab = 'Fator2', main = 'Agrupamento Presos', lines = 0, shade = F, color = TRUE, labels = 2) 
