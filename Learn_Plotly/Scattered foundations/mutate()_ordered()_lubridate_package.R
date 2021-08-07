library(plotly)
library(lubridate)
data(economics, package = "ggplot2")

#mutate(): them cac bien moi, giu cac bien hien co   |(Them cac cot moi trong bang data)|
#transmute(): them cac bien moi, xoa cac bien hien co|(                                )|
econ <- economics %>%
  mutate(yr = year(date), mnth = month(date))

#tao bieu do bang 2 loai khac nhau 
#Hieu suat tot, nhung it tuong tac
econ %>%
  group_by(yr) %>%
  plot_ly(x = ~mnth, y =~uempmed) %>%
  add_lines(text = ~yr)

#tao them cac tuong tac bang plotly, nhung hieu suat it hon
plot_ly(econ,x = ~mnth,y = ~uempmed) %>%
  add_lines(color = ~ordered(yr))

#ordered() : phan loai theo gia tri
#color = ~ordered(yr) : phan loai mau theo gia tri yr