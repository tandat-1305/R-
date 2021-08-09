library(plotly)
library(dplyr)
library(readr)

#
states = read_csv("states.csv")

minwage_df = read_csv("Minimum Wage Data.csv") %>%
  inner_join(states, by.x = State, by.x = state) %>%
  select(Year, State, Code, Wage = High.Value) %>%
  mutate(hover = paste0(State, "\n$", Wage)) #Them cot "hover" gia tri "State $Wage"

#Xem cac loai font

#library(extrafont)
#fonts()

#Tao font chu
fontStyle = list(
  family = "DM Sans", #Kieu chu
  size = 20,          #Kich thuoc chut
  color = "red"     #Mau chu
)
#Tao nhanx hien thi

label = list(
  bgcolor = "white",   #Mau o vuong
  bordercolor = "red", #Mau duong vien
  font = fontStyle
)
#

minwage_graph = plot_geo(minwage_df,
                         locationmode = 'USA-states',   #Cung cap khu vuc 
                         frame = ~Year) %>%             #Tao thanh truot theo nam o ben duoi
  add_trace(locations = ~Code,                          #tao ten hien thi code
            z = ~Wage,                                  #hien thi tien luong cua moi khu vuc, (phaan oo khu vuc)
            zmin = 0,                     #|(Tao muc luong co dinh cot Wage de gia )|
            zmax = max(minwage_df$Wage),  #|(tri cot Wage khong thay doi           )|
            color = ~Wage,
            colorscale = 'Electric',
            text = ~hover,                #them chu thich vao bieu do
            hoverinfo = 'text' ) %>%      #di chuot dinh dang cho bieu do
  layout(geo = list(scope = 'usa'),
         font = list (family = "DM Sans")) %>%
  style(hoverlabel = label) #hoverlabel : Nhanx di chuot <- label: edit nhan 
minwage_graph

#https://dplyr.tidyverse.org/reference/mutate.html
#https://plotly.com/r/hover-text-and-formatting/
#https://plotly.com/r/text-and-annotations/