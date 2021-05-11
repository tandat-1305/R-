setwd('D:\\R')
data = read.table(file="owls.txt",header=TRUE)
names(data)
str(data)
unique(data$i..Nest)


Nests = unique(data$i..Nest)

for (i in 1:length(Nests)){
  Nest.i = Nests[i]
  data.i = data[data$i..Nest == Nest.i,]
  Filename = paste(
    Nest.i,"bieudo.jpg",sep = ""
                       )
  jpeg(file = Filename)
  
  plot(x = data.i$SiblingNegotiation, y = data.i$ArrivalTime,
       xlab = "SiblingNegotiation",
       main = Nest.i,
       ylab = "ArrivalTime"
  )
  dev.off()
}

ifelse(data$FoodTreatment == "Satiated",
       data$NestNight <- paste(data$i..Nest, "1",sep = "_"),
       data$NestNight <- paste(data$i..Nest, "2",sep = "_"))
data