#distribuicao normal simulada
amostraNormal <- rnorm(500)

#sumario da distribuicao normal simulada
summary(amostraNormal)

# distribuicao binomial simulada
amostraBinomial <- rbinom(800, 1, 0.7)

#repeticoes
classeSimulacao <- c(rep("Aluno", length(amostraBinomial)/3), rep("Monitor", length(amostraBinomial)/3), rep("Professor", length(amostraBinomial)/3))

#sequencia numerica
indexSimulacao <- seq(1, length(amostraBinomial))

#amostragem sem reposicao usando funcao sample
sample(amostraNormal, 30, replace = FALSE)

#amostragem com reposicao
sample(amostraNormal, 30, replace = TRUE)

#bootstraping com funcao replicate
set.seed(700)

bootsDistNormal <- replicate(20, sample(amostraNormal, 20, replace = TRUE))
bootsDistNormal

# calculando com bootstrapping (20 amostras)
mediaBootsNormal10 <- replicate(10, mean(sample(amostraNormal, 20, replace = TRUE)))
mediaBootsNormal80 <- replicate(80, mean(sample(amostraNormal, 20, replace = TRUE)))
mediaBootsNormal200 <- replicate(200, mean(sample(amostraNormal, 20, replace = TRUE)))


#comparando medias
mean(mediaBootsNormal10)
mean(mediaBootsNormal80)
mean(mediaBootsNormal200)
mean(amostraNormal)

#instalando pacotes
install.packages('caret', dependencies = T)
library(caret)

#particoes
particaoDistNormal <- createDataPartition(1:length(amostraNormal), p=.8) 
treinoDistNormal <- amostraNormal[unlist(particaoDistNormal)] 
testeDistNormal <- amostraNormal[- unlist(particaoDistNormal)]
