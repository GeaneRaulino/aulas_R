#bibliotecas internas R
data()

#operadores logicos

USMortality

USMortality$Rate < 0
which(USMortality$Rate <= 10)
which(USMortality$Rate == 13.9)

match(USMortality$Cause, "Cancer")
