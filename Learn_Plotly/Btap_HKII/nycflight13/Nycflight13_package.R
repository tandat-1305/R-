library(nycflights13)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plotly)

str(airlines)
data("airlines")
str(flights)
data(flights)
#==============================================================================
fontStyle = list(
  family = "DM Sans", #Kieu chu
  size = 20,          #Kich thuoc chut
  color = 'red'    #Mau chu
)
#==============================================================================
#CAU 1
data <- flights %>%
  dplyr::select(arr_delay, dep_delay,carrier) %>%  #
  filter(carrier == 'AS')                          #filter: bo loc 
data

data %>%
  plot_ly() %>%
  add_markers(x ~dep_delay, y = ~arr_delay,
              marker = list(size = 8,
                            color = 'rgba(157, 237, 59, 1)',
                            line = list(color = 'rgba(33, 197, 211, 1)',
                                        width = 2))) %>%
  layout(title = 'Chuy???n bay c???a hãng ALASKA AIRLINE',font = fontStyle)
#==============================================================================
#CAU 2
str(weather)
data(weather)
data2 <- weather %>%
  dplyr::select(origin, temp, time_hour, month, day ) %>%
  filter(origin == 'EWR', month == 1, day < 15)

data2 %>%
  plot_ly(x = ~time_hour, y = ~temp, type = 'scatter', mode = 'lines',color = I('rgba(157, 237, 59, 1)')) %>%
  layout(title = 'Nhi???t d??? các ngày trong tháng 1',font = fontStyle)
#==============================================================================
#CAU 3
t <- count(weather, temp, wt_var = NULL)
names(t)[2] <- paste("count")
data3 <- t
data3 %>%
  plot_ly(x = ~count,y=~temp , type = 'histogram')

 #==============================================================================
#CAU 4 
data4 <- weather %>%
  dplyr::select(temp, month)

data4%>%
  plot_ly(x = ~month, y = ~temp, type = 'box',color = I('rgba(33, 197, 211, 1)')) %>%
  layout(title = 'S??? phân b??? c???a nhi???t d??? theo các tháng',font=fontStyle)
#==============================================================================
#CAU 5
sum_carrier = aggregate(flights$flight, by = list(carrier = flights$carrier), FUN =sum)
names(sum_carrier)[2]<-paste("count")

data5 <- sum_carrier
data5 %>%
  plot_ly(x = ~carrier, y = ~count, type = 'bar') %>%
  layout(title = 'S??? chuy???n bay c???a các hãng hàng không',font = fontStyle)






