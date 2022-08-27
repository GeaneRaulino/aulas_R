#bibliotecas internas R
data()
pressure
airquality
#
airquality[3,1] #Linha 3, coluna 1
airquality[,'Wind'] #retorna todas a linhas da coluna Wind, que é a coluna 3
airquality[, 'Ozone']

CO2
CO2[, 'Treatment']
CO2[, 'Treatment', drop = FALSE]

#operadores logicos
airquality$Wind < 0
which(airquality$Wind <= 10)

match(airquality$Ozone, 22)


