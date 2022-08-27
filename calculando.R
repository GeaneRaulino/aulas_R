# o R como calculadora

binomialnegSimulacao <- rnbinom(50, mu = 20, size = 1000)
hist(binomialnegSimulacao)
poissonSimulacao <- rpois(1000, 5)
hist(poissonSimulacao)

#centralizar simulacao poisson
poissonSimulacaoCentral <- poissonSimulacao - mean(poissonSimulacao)
hist(poissonSimulacao)
hist(poissonSimulacaoCentral)

#centralizar 
LifeCycleSavings[,3]
hist(LifeCycleSavings[,3])
LifeCycleSavingsCentral <- LifeCycleSavings[,3] - mean(LifeCycleSavings[,3]) 
hist(LifeCycleSavingsCentral)
