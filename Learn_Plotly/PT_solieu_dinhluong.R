library(plotly)

#Tao font chu
fontStyle = list(
  family = "DM Sans", #Kieu chu
  size = 20,          #Kich thuoc chut
  color = "grey"     #Mau chu
)

#Nhap du lieu
x <- c("2016-2017", "2017-2018", "2018-2019")
y <- c("45", "32", "40")
y2 <- c("15", "18", "12")
y3 <- c("18", "21", "11")
y4 <- c(0,0,0)

#Tao bang
data <- data.frame(x, y, y2, y3, y4)
names(data)[1]<-paste("Year")
names(data)[2]<-paste("Khá giỏi")
names(data)[3]<-paste("Họcc lại")
names(data)[4]<-paste("Học bổng")

#Ve bieu do cot 

fig <- data %>% plot_ly()
fig <- fig %>% add_trace(x = ~x, y = ~y, type = 'bar', name = "Khá giỏi",
                         text = y, textposition = 'auto',
                         marker = list(color = '#38EB00',
                                       line = list(color = 'rgb(8,48,107)', width = 1.5)))
fig <- fig %>% add_trace(x = ~x, y = ~y2, type = 'bar', name = "Học lại",
                         text = y2, textposition = 'auto',
                         marker = list(color = '#E85D15',
                                       line = list(color = 'rgb(8,48,107)', width = 1.5)))
fig <- fig %>% add_trace(x = ~x, y = ~y3, type = 'bar', name = "Học bổng",
                         text = y3, textposition = 'auto',
                         marker = list(color = '#2C2CE8',
                                       line = list(color = 'rgb(8,48,107)', width = 1.5)))
fig <- fig %>% add_trace(x = ~x, y = ~y4, type = 'bar', name = FALSE,
                         text = y4, textposition = 'auto',
                         marker = list(color = 'rgb(58,200,225)',
                                       line = list(color = 'rgb(8,48,107)', width = 1.5)))
fig <- fig %>%
  layout(xaxis = list(title = "Year"),
         yaxis = list(title ="Percentage (%)"),
         font = fontStyle)
fig
