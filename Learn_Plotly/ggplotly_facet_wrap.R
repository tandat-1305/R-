library(plotly)
library(dplyr)
library(listviewer)

# geom_hex(): xep hinh luc giac
# aes(): gia tri truc x,y
p <- ggplot(diamonds, aes(x = log(carat), y = log(price)))+ 
  geom_hex(bins = 100)                                      
ggplotly(p)

#geom_freqply(): da giac tan so 
p <- ggplot(diamonds, aes(x = log(price), color = clarity))+
  geom_freqpoly()
ggplotly(p)

#basically any geom (e.g., geom_boxplot(), geom_histogram(), geom_density(), etc.)
p <- ggplot(diamonds, aes(x = log(price), color = clarity))+
  geom_density()
ggplotly(p)

#facet_wrap()/facet_grid : da bang  
#Gia kim cuong theo do trong va do cat(price,clarity,cut)
p <- ggplot(diamonds, aes(x = log(price), color = clarity))+
  geom_freqpoly(stat = "density")+
  facet_wrap(~cut)
ggplotly(p)

#https://vimeo.com/322318131
#
