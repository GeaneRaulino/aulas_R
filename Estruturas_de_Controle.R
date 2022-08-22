# estrutura de repeticao
par(mfrow = c(1, 2)) # 
USMortality[,4]

for (i in 4:5) {
  
  x <- USMortality[ , i]
  hist(x,
       main = paste("Variável", i, names(USMortality)[i]),
       xlab = "Valores da Variável"
       )
}
