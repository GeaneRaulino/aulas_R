##########
install.packages("readxl")
library(microbenchmark)
library(data.table)
library(dplyr)
library(tidyverse)
library(funModeling) 
library(writexl)
library(readxl)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela")

latin_america <- general_data %>% filter(location %in% latin_america_countries)

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

latin_america <- latin_america %>% filter(new_cases>=0) #18.223 linhas

#filtrando mesmo dataframe removendo NA de new_cases e new_deaths
latin_america <- latin_america %>% filter(new_deaths !='NA') #17.949 linhas

# exporta em formato nativo do R
saveRDS(latin_america, "bases_tratadas/latin_america.rds")

# exporta em formato tabular (.csv) 
write.csv2(latin_america, "bases_tratadas/latin_america.csv")

# exporta em formato txt
write.table(latin_america, "bases_tratadas/latin_america.txt")

#exportando base para excel
write_xlsx(latin_america, path = "bases_tratadas/latin_america.xlsx")

# carrega base de dados em formato nativo R
latin_america <- readRDS('bases_tratadas/latin_america.rds')

# carrega base de dados em formato tabular (.csv) 
latin_america <- read.csv2('bases_tratadas/latin_america.csv', sep = ';')

# carrega base em formato txt
latin_america <- read.delim("bases_tratadas/latin_america.txt", sep=" ") #separador de colunas era espaço em branco

#carrega base para excel
latin_america <- read_excel("bases_tratadas/latin_america.xlsx", sheet = "Sheet1")

# compara os dois processos de exportação, usando a função microbenchmark
microbenchmark(a <- saveRDS(latin_america, "bases_tratadas/latin_america.rds"), 
               b <- write.csv2(latin_america, "bases_tratadas/latin_america.csv"),
               c <- write.table(latin_america, "bases_tratadas/latin_america.txt"),
               d <- write_xlsx(latin_america, path = "bases_tratadas/latin_america.xlsx"),
               times = 30L)

microbenchmark(a <- readRDS("bases_tratadas/latin_america.rds"), 
               b <- read.csv2("bases_tratadas/latin_america.csv", sep = ';'),
               c <- read.delim("bases_tratadas/latin_america.txt", sep=" "),
               d <- read_excel("bases_tratadas/latin_america.xlsx", sheet = "Sheet1"),
               times = 10L)
