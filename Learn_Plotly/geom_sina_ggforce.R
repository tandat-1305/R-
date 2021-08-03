library(plotly)
library(dplyr)
library(listviewer)

data(diamonds, package = "ggplot2")
diamonds


#Bieu do sina ve cac diem run

p <- ggplot(diamonds, aes(x = clarity, y = log(price), color = clarity)) +
  ggforce::geom_sina(alpha = 0,1) +
  stat_summary(fun.data = "mean_cl_boot", color= "black") +
  facet_wrap(~cut)

#WebGL hieu qua hon nhieu so voi bieu do nhieu diem
toWebGL(ggplotly(p))

#su dung stat_summary() cua ggplot2 phu len do tin cay 95% khoang thoi gian uoc tinh thong qa
#thuat toan Bootstrap thong qua goi Hmisc


#lm() : mo hinh tuyen tinh
#mo hinh tuyen tinh giua carat so voi gia thanh kim cuong 
m <- lm(log(price) ~ log(carat), data = diamonds)
diamonds <- modelr::add_residuals(diamonds, m)
q <- ggplot(diamonds, aes(x = clarity, y = resid, color = clarity)) +
  ggforce::geom_sina(alpha = 0.1) +
  stat_summary(fun.data = "mean_cl_boot", color = "black") +
  facet_wrap(~cut)
toWebGL(ggplotly(q))

#giai thich mean_cl_boot
#https://stackoverflow.com/questions/17414565/interpretation-of-stat-summary-mean-cl-boot-at-ggplot2