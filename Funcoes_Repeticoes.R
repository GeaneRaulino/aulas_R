# funções de repetição - família apply

sapply(LifeCycleSavings[ , 1:5], hist)
mapply(hist, LifeCycleSavings[ , 1:4], MoreArgs=list(main='Histograma', xlab = 'Valores', ylab = 'Frequência')) 

for (i in 1:5) { 
  x <- LifeCycleSavings[ , i] 
  hist(x,
       main = names(LifeCycleSavings)[i], 
       xlab = "Valores da Variável", 
       ylab = 'Frequência', 
       xlim = c(min(LifeCycleSavings[, i]), max(LifeCycleSavings[, i]))) 
}


