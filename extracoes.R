install.packages('rjson')
install.packages('readxl')
library(readxl)
library(rjson)

# arquivos de texto com read.csv2
dadosDespesas <- read.csv2('http://dados.recife.pe.gov.br/dataset/4e008cec-c6a8-40cf-8fc7-d1530168b816/resource/a4b97fb4-7dc6-4e70-a87d-3c3503f00b1e/download/recife-dados-despesas-2022.csv', sep = ';', encoding = 'UTF-8')

# arquivos de excel
general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela")

latin_america <- general_data %>% filter(location %in% latin_america_countries)

#exportando base para excel
write_xlsx(latin_america, path = "bases_tratadas/latin_america.xlsx")

#para ler em excel, executei a base e salvei em xlsx
latinAmerica2 <- read_excel('bases_originais/latin_america.xlsx', sheet=1) 

# arquivos json Dicionário de Dados SEDEC Chamados
dicionarioSEDEC <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/ee1d0a4f-3ad2-4d77-a2b4-d50a7893693f/download/sedec-chamados.json" )
dicionarioSEDEC <- as.data.frame(dicionarioSEDEC)
