url <- 'https://raw.githubusercontent.com/tandat-1305/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-14-2021.csv'
covid <- read.csv(url, header = TRUE)

str(covid)
library(plotly)
library(ggcharts)

fig <- plot_ly(covid,
               type='pie',
               labels = ~Province_State,
               values = ~Deaths,
               text = ~Country_Region,
               textposition = 'inside')

fig <- fig %>% layout(title = "Confirmed in Province/State",uniformtext=list(minsize=8, mode='hide'))
fig
