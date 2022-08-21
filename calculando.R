# o R como calculadora

binomialnegSimulacao <- rnbinom(50, mu = 20, size = 1000)
hist(binomialnegSimulacao)
poissonSimulacao <- rpois(1000, 5)
hist(poissonSimulacao)

#centralizar simulacao poisson
poissonSimulacaoCentral <- poissonSimulacao - mean(poissonSimulacao)
hist(poissonSimulacao)
hist(poissonSimulacaoCentral)


