setwd("D:\\R")
#Câu 1
data = read.table(file = 'Temperature2.txt', header = TRUE)

tapply(data$Temperature,list(data$Month,data$Year), mean,na.rm = TRUE)
tapply(data$Temperature,list(data$Month,data$Year), sd,na.rm ? TRUE) 
tapply(data$Temperature,list(data$Month,data$Year), length)

#Câu 2
table(data$Year)
table(list(data$Year,data$Station))