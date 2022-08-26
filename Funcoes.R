# função com estrutura condicional e de repetição
f <- function(nro) {
  if(nro < 100) {
    for(i in 1:nro) {
      cat("Hello, world!\n")
    }
  } else {
    cat("Tá de brincadeira imprimir isso tudo")
  }
}

f(3)
f(100)


verificarNome <- function(nome){
  if(nome == 'iris'){
    par(mfrow = c(2, 2))
    for (i in 1:4) {
      x <- iris[ , i]
      hist(x,
           main = paste("Variável", i, names(iris)[i]), 
           xlab = "Valores da Variável", 
           xlim = c(0, 10)) 
    }
  }else{
    cat("Nome errado")
  }
}

verificarNome('iris')
verificarNome('AirPassengers')



