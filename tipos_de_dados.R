
escola <- c("a", "a", "p", "p", "a", "c", "a")

recode <- c(aluno = "a", professor = "p")
(escola <- factor(escola, levels = recode, labels = names(recode)))

(escola <- relevel(escola, ref = "professor"))

is.numeric(escola)
as.numeric(escola)
as.integer(escola)
as.character(escola)
is.na(as.numeric(escola))


#professores com 0 para simular o NA
notas <- c(7,8,0,0,9,0,10)

(escola <- reorder(escola,notas))
attr(escola,"scores") <- NULL
escola

