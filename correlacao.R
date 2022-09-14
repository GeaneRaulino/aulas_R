pacman::p_load(corrplot, dplyr, ggplot2)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela")

latin_america <- general_data %>% filter(location %in% latin_america_countries)

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

latin_america <- latin_america %>% filter(new_cases>=0)

latin_america <- latin_america %>% filter(new_deaths !='NA') 


#Base de dados sem a coluna Location
latin_america2 <- latin_america %>% select(-location)

cor(latin_america2)
pairs(latin_america2)

latin_america3 <- cor(latin_america2)
corrplot(latin_america3, method = "number", order = 'alphabet')
corrplot(latin_america3, order = 'alphabet') 
