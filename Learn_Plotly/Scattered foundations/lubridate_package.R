library(lubridate)
library(tidyverse)
library(nycflights13)
day <- today()
str(day)
datetime <- now()
str(datetime)

string1 <- "2020-09-22"
string2 <- "2020-09-22 17:00:00"
str(string1)
str(string2)

date1 <- as_date(string1)
datetime1 <- as_datetime(string2)
str(date1)
str(datetime1)

datef1 <- "20200922"
datef2 <- "09-22-2020"
datef3 <- "22/09/2020"
datef4 <- "09-22-2020 17:00:00"
datef5 <- "20200922 170000"

ymd(datef1)
mdy(datef2)
dmy(datef3)
mdy_hms(datef4)
ymd_hms(datef5)

todayDate <- "2021-08-03 18:37:00"
year(todayDate)
month(todayDate)
mday(todayDate)
hour(todayDate)
minute(todayDate)
second(todayDate)
yday(todayDate)  #ngay thu bao nhieu trong nam
wday(todayDate)  #ngay thu may trong tuan : thu 2,3,4 ...,CN

month(todayDate, label = TRUE) #Thang
wday(todayDate, label = TRUE) #Thu

# Su dung du lieu "flights" bang cach tai package "nycflights13"
# tao 3 cot : Hang hang khong, nuoc, thoi gian  
library(dplyr)
#tao bang dataset
data <- flights %>%
  dplyr::select(flight, carrier, time_hour)
data

#tao bang gia tri filghts theo thang
#{r bar plot example}
data %>%
  mutate(month = month(time_hour, label = TRUE)) %>%
  ggplot() +
  geom_bar(aes(x = month),fill = "navy", color = "gold")


#tao bieu do duong cho: flight theo gio trong ngay(flights by hour of the day)
#{r line plot example}
data %>%
  mutate(hour = hour(time_hour)) %>%
  group_by(hour) %>%
  tally() %>%        #so dem rieng cho moi gio
  ggplot() +
  geom_line(aes(x = hour, y = n)) +
  #tao gia tri cot x 0>- 24 khoang cach = 2
  #tao gia tri cot y 0->30000 khoang cach = 5000
  scale_x_continuous(breaks = seq(0, 24, 2)) +
  scale_y_continuous(breaks = seq(0,30000, 5000))
data

#su dung mot so function khac nhu :
# dseconds(), dminutes(), dhours(), ddays(), dweeks(), 
# dmonths(). dyears(), hours(), days(), moths(), weeks(), years()

stTime <- ymd_hms("2021-08-07 12:00:00",tz = "America/New_York")
stTime + ddays(1)
stTime + days(1)
stTime + dminutes(1)
#[1] "2021-08-07 12:01:00 EDT"
stTime + dseconds(23)
#[1] "2021-08-07 12:00:23 EDT"

