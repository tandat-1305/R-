library(plotly)

data(economics, package = "ggplot2")
economics
#https://www.rdocumentation.org/packages/ggplot2/versions/3.3.2/topics/economics

data(economics, package = "ggplot2")
#Arange: Sap xep hang theo bien psavert
p <- economics %>%
  arrange(psavert) %>%
  plot_ly(x = ~date, y = ~psavert)
add_paths(p)
add_lines(p)  
 
