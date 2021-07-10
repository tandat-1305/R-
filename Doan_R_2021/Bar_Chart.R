url <- 'https://raw.githubusercontent.com/tandat-1305/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-14-2021.csv'
covid <- read.csv(url, header = TRUE)

str(covid)
library(plotly)
library(ggcharts)

#Bi???u d??? ngang
fig1 <- plot_ly(covid %>% 
             top_n(20, Confirmed),
             x = ~Confirmed,
             y = ~Province_State,
             type = 'bar',
             text = ~Confirmed,
             textposition =  'outside',
             marker = list(color = '#19D3F3',                                                    
                           line = list(color = '#D62728)',
                                       width = 2))) 

fig1 <- fig1  %>% layout(title = "Confirmed in Province/State",uniformtext=list(minsize=8, mode='hide'))
fig1

#Bi???u d??? d???c
fig2 <- plot_ly(covid %>%
               top_n(20, Confirmed),
               type='bar',
               x = ~Province_State,
               y = ~Confirmed,
               textposition = 'outside',
               marker = list(color = '#19D3F3',
                             line = list(color = '#D62728)',
                                         width = 2)))  


fig2 <- fig2  %>% layout(title = "Confirmed in Province/State",uniformtext=list(minsize=8, mode='hide'))
fig2

