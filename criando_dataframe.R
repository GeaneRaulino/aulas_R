#instalar pacote
install.packages("eeptools")

#utilizando pacote
library("eeptools")

#vetor nome do aluno
nomeAluno <- c("Geane", "Maria", "João", "José")

#vetor turma do aluno
turmaAluno <- c("2022.2", "2022.2", "2022.2", "2022.2")

#vetor nota de avaliacao
nota <- c(10, 9, 8, 10)

#media da turma
media <- mean(nota)

#data.frame
levantamentoTurma <-data.frame(nome = nomeAluno, turma = turmaAluno, nota = nota, media = media)