#Solutions Chapter 6. Function...
# Exercise 1 #This code is computer specific.
# Set working direction (folder)
setwd(".................")
Convert temperature.xls => temperature.txt
#Declare a frame variable to store temperature.txt data. In my case, the separate between two columns is *** signal
TP <- read.table(file = "Temperature.txt", header = TRUE, dec = ".") 
#You should check all variables (column), it should available for analysing...
names(TP)
str(TP)
#Our function:
#Check how many station (tram khi tuong) in our dataset
AllStations <- unique(TP$Station)
N<- length(AllStations)

for (i in 1:N) {
Station.i<-as.character(AllStations[i])
print(Station.i) TPI <- TP[TP$Station Station..]
YourFileName <- paste(Station.i, ".jpg", sep="")
jpeg(file = YourFileName) 
plot(x = TPi$dDay2 , y = TPi$Temperature,
xlab = "Days since 1 January 1990",
ylab = "Temperature",
main = Station.i)
dev.off
  
  
# Exercise 2
Owls <-read.table(file = "Owls.txt", header = TRUE, dec = ".")
names(Owls) 
str(Owls)
ifelse(Owls FoodTreatment == "Satiaded", Owls$NestNight <- paste(Owls$Nest, "1", sep="_"),
Owls$NestNight <- paste(Owls$Nest, "2".sep="_"))
head(Owls)
#You can also do this with: Owls$NestNight <- paste(Owls$Nest, Owls FoodTreatment,sep="_")
AllNestsNights <- unique(Owls$NestNight)
N<- length(AllNestsNights) 
for (i in 1:N) {
  NestNight.i <-as.character(AllNestsNights[i]) 
  print(NestNight.i) 
  Owlsi <- Owls[Owls$NestNight == NestNight.i ,]
  YourFileName <- paste(NestNight.i, ".jpg", sep="") 
  #jpeg(file = YourFileName) 
  plot(x = Owlsis Arrival Time , y=OwlsiSNegPerChick, 
       xlab = "Arrival Time".
      ylab = "Sibling negotiation", 
       main = NestNight.i) 
  #dev.off
  }

