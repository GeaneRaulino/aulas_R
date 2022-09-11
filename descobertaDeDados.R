pacman::p_load(funModeling, tidyverse) 

data()

CO2 #contem colunas de fatores

glimpse(CO2) 
status(CO2) #possibel identificar colunas numericas e fatores
freq(CO2) #frequência das variáveis fator, no caso da biblioteca CO2, temos 4 fatores
plot_num(CO2) #exploração das variáveis numéricas
profiling_num(CO2) #estatísticas das variáveis numéricas
