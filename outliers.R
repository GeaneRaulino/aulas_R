pacman::p_load(data.table, dplyr, plotly,EnvStats)


world_data <- fread('https://covid.ourworldindata.org/data/owid-covid-data.csv')
world_data1 <- world_data %>% filter(continent !='')
world_data1 <- world_data1 %>% select(location, total_cases, new_cases,new_cases_smoothed, new_deaths, new_deaths_smoothed, reproduction_rate, icu_patients)

world_data1 <- world_data1 %>% filter(total_cases !='NA') 
world_data1 <- world_data1 %>% filter(new_cases !='NA') 
world_data1 <- world_data1 %>% filter(new_cases_smoothed !='NA') 
world_data1 <- world_data1 %>% filter(new_deaths !='NA') 
world_data1 <- world_data1 %>% filter(new_deaths_smoothed !='NA') 
world_data1 <- world_data1 %>% filter(reproduction_rate !='NA') 
world_data1 <- world_data1 %>% filter(icu_patients !='NA')

world_data2 <- world_data1 %>% select(location, total_cases)
world_data2 <- world_data2 %>% group_by(location) %>% summarise(across(everything(), list(sum)))
world_dataCountry <- world_data2  %>% mutate(casos2 = sqrt(total_cases_1), casosLog = log10(total_cases_1))

#outliers em variáveis
#distância interquartil
plot_ly(y = world_dataCountry$total_cases_1, type = "box", text = world_dataCountry$location, boxpoints = "all", jitter = 0.3)

boxplot.stats(world_dataCountry$total_cases_1)$out
boxplot.stats(world_dataCountry$total_cases_1, coef = 2)$out

world_dataCountryOut <- boxplot.stats(world_dataCountry$total_cases_1)$out
world_dataCountryOutIndex <- which(world_dataCountry$total_cases_1 %in% c(world_dataCountryOut))
world_dataCountryOutIndex

#filtro de Hamper
lower_bound <- median(world_dataCountry$total_cases_1) - 3 * mad(world_dataCountry$total_cases_1, constant = 1)
upper_bound <- median(world_dataCountry$total_cases_1) + 3 * mad(world_dataCountry$total_cases_1, constant = 1)
(outlier_ind <- which(world_dataCountry$total_cases_1 < lower_bound | world_dataCountry$total_cases_1 > upper_bound))

#teste de Rosner
world_dataCountryRosner <- rosnerTest(world_dataCountry$total_cases_1, k = 10)
world_dataCountryRosner
world_dataCountryRosner$all.stats

