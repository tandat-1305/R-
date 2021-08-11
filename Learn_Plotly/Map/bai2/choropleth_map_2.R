library(plotly)
library(dplyr)
library(readr)

ufos = read_csv("complete.csv") %>%
  select(longitude, latitude, datetime, shape)

#Chon khu vuc the hien bieu do (Vi du USA)
geo_propertie = list(
  scope = "usa",
  #thuong su dung bien projection de tinh chinh cac yeu cau do thi
  projection = list(type = 'albers usa'),
  showland = TRUE,
  showsubunits = FALSE, # Tat cac duong vien chia khu vuc
  landcolor = toRGB('gray10'), #Mau khu vuc duoc chon, dat nuoc usa
  showlakes = TRUE,           #(Hien thi cac ho nuoc                  )
  lakecolor = toRGB('white')  #(Xoa ho nuoc, cho mau ho nuoc mau trang)
)
ufos_graphs = plot_geo(ufos,
                       lat = ~latitude, 
                       lon = ~longitude,
                       #Chon kich thuoc,mau sac cac diem hien thi du lieu
                       marker = list(size =2, color = "#FFFFCC", opacity = 0.25)) %>%
  #Xoa hien thi chi so kinh tuyen, vi tuyen o cac diem
  add_markers(hoverinfo = "none") %>%
  #Xoa thanh cong cu ModeBar
  config(displayModeBar = FALSE) %>%
  layout(geo = geo_propertie)
  
ufos_graphs

