#16/4/21
setwd("D:\\R")

A = read.csv("Temperature.csv", header = TRUE)
avg = tapply(A$Temperature, A$Month, mean, na.rm =TRUE)
avg

avg2 = tapply(A$Temperature, list(A$Year, A$Month), mean, na.rm =TRUE)
avg2

avg3 = tapply(A$Temperature, A$Month, sd, na.rm =TRUE)
avg3

help(table)

table(A$Year)
table(A$Station,A$Year)