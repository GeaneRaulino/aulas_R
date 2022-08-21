tarefaSemente <- addTaskCallback(function(...) {set.seed(123);TRUE}) 
tarefaSemente

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


removeTaskCallback(tarefaSemente)

