pacman::p_load(data.table, ggplot2,corrplot)

breast_cancer <- fread('https://raw.githubusercontent.com/GeaneRaulino/aulas_R/main/bases_tratadas/breast_cancer.csv', stringsAsFactors = T)

#tabela de contigência
breast_cancer_table <- table(breast_cancer$idade, breast_cancer$tumor_tamanho)
breast_cancer_table

#grafico de dispersão
ggplot(breast_cancer) + aes( x = tumor_tamanho, fill = idade) + geom_bar(position = "fill")

#teste qui quadrado
breast_cancer_test <- chisq.test(breast_cancer_table)
breast_cancer_test
breast_cancer_test$observed
breast_cancer_test$expected

#corrplot
corrplot(breast_cancer_test$residuals, is.cor = FALSE)
