library(tidyverse)
library(dplyr)
library(plotly)
library(readr)

#Font
fontStyle = list(
  family = "DM Sans", #Kieu chu
  size = 20,          #Kich thuoc chut
  color = 'green'    #Mau chu
)


trade.imp <- read.csv("https://raw.githubusercontent.com/tandat-1305/R-/main/D%E1%BB%B1%20%C3%A1n%20ph%C3%A2n%20t%C3%ADch%20d%E1%BB%AF%20li%E1%BB%87u/2018-2010_import.csv")
trade.exp <- read.csv("https://raw.githubusercontent.com/tandat-1305/R-/main/D%E1%BB%B1%20%C3%A1n%20ph%C3%A2n%20t%C3%ADch%20d%E1%BB%AF%20li%E1%BB%87u/2018-2010_export.csv")
imp <- trade.imp
exp <- trade.exp

#Tong ket va cau truc du lieu
summary(trade.imp)
str(trade.imp)

summary(trade.exp)
str(trade.exp)

#Kiem tra cac gia tri value = "NA"
im_miss_value <- trade.imp[!complete.cases(trade.imp),]
im_miss_value


#------------------------IMPORT------------------------# LAM SACH DU LIEU
#Xoa bo hang va gia tri ko can thiet
a <- trade.imp %>% filter(!(!complete.cases(.) | country == "UNSPECIFIED"))
#Kiem tra hang trung nhau
a <- as_tibble(unique(a))
a

#as_tibble() function : https://www.rdocumentation.org/packages/tibble/versions/3.0.4/topics/as_tibble

#------------------------EXPORT------------------------# LAM SACH DU LIEU
#Xoa bo hang va gia tri ko can thiet
b <- trade.exp %>% filter(!(!complete.cases(.) | country == "UNSPECIFIED"))
#Kiem tra hang trung nhau
b <- as_tibble(unique(b))

#Xuat khau va nhap khau theo tung nam
yearly.import <- a %>% 
  group_by(year) %>% 
  summarise(import.value = sum(value))
yearly.import

yearly.export <- b %>%
  group_by(year) %>%
  summarise(export.value = sum(value))
yearly.export

#------------BIEU DO "LINE" XUAT NHAP KHAU THEO TUNG NAM------------#
#------------Nhap khau------------#
fig <- plot_ly(yearly.import, type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~year, y = ~import.value)%>%
  layout(showlegend = F)
fig <- fig %>%
  layout(title ="NHAP KHAU THEO TUNG NAM",
    xaxis = list(title = "Year",
                 zerolinecolor = '#ffff',
                 zerolinewidth = 3,
                 gridcolor = 'ffff'),
    yaxis = list(title ="Import value %",
                 zerolinecolor = '#ffff',
                 zerolinewidth = 3,
                 gridcolor = 'ffff'),
    plot_bgcolor='#red', width = 900,
    font = fontStyle)
fig

#------------Xuat khau------------#
fig <- plot_ly(yearly.export, type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~year, y = ~export.value)%>%
  layout(showlegend = F)
fig <- fig %>%
  layout(title = "XUAT KHAU THEO TUNG NAM",
    xaxis = list(title ="Year",
                 zerolinecolor = '#ffff',
                 zerolinewidth = 3,
                 gridcolor = 'ffff'),
    yaxis = list(title = "Export value %",
                 zerolinecolor = '#ffff',
                 zerolinewidth = 3,
                 gridcolor = 'ffff'),
    plot_bgcolor='#e5ecf6', width = 900,
    font = fontStyle)
fig

#---------10 NUOC XUAT,NHAP KHAU CAO NHAT---------# Bar chart
#NHAP KHAU CUA AN DO DOI VOI CAC NUOC
country.import <- a %>% 
  group_by(country) %>% 
  summarise(import.value = sum(value))
country.import
#top10 
imp_top10_country <- country.import %>% top_n(10, import.value)
fig <- plot_ly(imp_top10_country,
  x = ~country,
  y = ~import.value,
  type = "bar"
) %>%
  layout(title = 'TOP 10 NUOC AN DO NHAP KHAU CAO NHAT',
         xaxis = list(title="Country"),
         yaxis = list(title="Export"),
         font = fontStyle)

fig

#XUAT KHAU CUA AN DO
country.export <- b %>% 
group_by(country) %>% 
  summarise(export.value = sum(value))
country.export
#top10 
exp_top10_country <- country.export %>% top_n(10, export.value)
fig <- plot_ly(exp_top10_country,
               x = ~country,
               y = ~export.value,
               type = "bar") %>%
  layout(title = 'TOP 10 NUOC AN DO XUAT KHAU RA CAO NHAT',
         xaxis = list(title="Country"),
         yaxis = list(title="Export"),
                      font = fontStyle)

fig 


#---------10 MAT HANG XUAT,NHAP KHAU CAO NHAT ---------# Bar chart
#MAT HANG NHAP KHAU
commodity.import <- a %>% 
  group_by(Commodity) %>% 
  summarise(import.value = sum(value))
commodity.import
#top10 
imp_top10_commodity <- commodity.import %>% top_n(10, import.value)
fig <- plot_ly(imp_top10_commodity,
               x = ~import.value,
               y = ~Commodity,
               type = "bar"
) %>%
  layout(title = 'TOP 10 MAT HANG AN DO NHAP KHAU CAO NHAT',
         xaxis = list(title="Import Value %"),
         yaxis = list(title="Commodity"),
         font = fontStyle)

fig

#MAT HANG XUAT KHAU
commodity.export <- b %>% 
  group_by(Commodity) %>% 
  summarise(export.value = sum(value))
commodity.export
#top10 
exp_top10_commodity <- commodity.export %>% top_n(10, export.value)
fig <- plot_ly(exp_top10_commodity,
               x = ~export.value,
               y = ~Commodity,
               type = "bar") %>%
  layout(title = 'TOP 10 MAT HANG AN DO XUAT KHAU CAO NHAT',
         xaxis = list(title="Export Value %"),
         yaxis = list(title="Commodity"),
         font = fontStyle)

fig
