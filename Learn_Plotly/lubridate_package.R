library(lubridate)

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

#co lap du lieu
library(dplyr)
#tao bang dataset


