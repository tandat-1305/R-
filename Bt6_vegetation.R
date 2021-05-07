setwd("D:\\R")
Veg <- read.table(file="Vegetation2.txt", header=TRUE)
str(Veg)


plot(Veg$BARESOIL,Veg$R)
plot(Veg$R, Veg$BARESOIL)
plot(x=Veg$BARESOIL, y=Veg$R)
plot(R~BARESOIL, data = Veg)
plot(x=Veg$BARESOIL, 
     y=Veg$R, 
     xlab="Exposed soil",  
     ylab = "Species richness", 
     main="Scatter plot",
     xlim=c(0,45), 
     ylim=c(4,19))

plot(x=Veg$BARESOIL, 
     y=Veg$R, 
     xlab="Exposed soil",  
     ylab = "Species richness",
     main="Scatter plot", ?
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)),
     ylim=c(min(Veg$R), max(Veg$R)))

plot(x=Veg$BARESOIL,
     y=Veg$R, 
     xlab="Exposed soil",  
     ylab = "Species richness", 
     main="Scatter plot",
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)), 
     ylim=c(min(Veg$R), max(Veg$R)), pch=8) 


Veg$Transect
plot(x=Veg$BARESOIL,
     y=Veg$R,
     xlab="Exposed soil", 
     ylab = "Species richness",
     main="Scatter plot", 
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)), 
     ylim=c(min(Veg$R), max(Veg$R)), pch=Veg$Transect) 


Veg$Time
TimeGroup <-Veg$Time
TimeGroup[Veg$Time<=1980] <- 1
TimeGroup[Veg$Time>1980] <- 10


plot(x=Veg$BARESOIL, 
     y=Veg$R,
     xlab="Exposed soil", 
     ylab = "Species richness",
     main="Scatter plot", 
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)),
     ylim=c(min(Veg$R), max(Veg$R)), pch=TimeGroup)


plot(x=Veg$BARESOIL, 
     y=Veg$R, 
     xlab="Exposed soil",  
     ylab = "Species richness", 
     main="Scatter plot", 
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)), 
     ylim=c(min(Veg$R), max(Veg$R)), pch=TimeGroup, col=3) 


x<- 1:8
plot(x, col=x)

CexSize <-Veg$Time
CexSize[Veg$Time<=1980] <- 1
CexSize[Veg$Time>1980] <- 2
plot(x=Veg$BARESOIL, 
     y=Veg$R, 
     xlab="Exposed soil",  
     ylab = "Species richness", 
     main="Scatter plot", 
     xlim=c(min(Veg$BARESOIL), max(Veg$BARESOIL)),
     ylim=c(min(Veg$R), 
            max(Veg$R)), 
     pch=TimeGroup, 
     col=1,
     cex=CexSize) 

veg1 <- loess(R~BARESOIL, data=Veg)
fit <- fitted(veg1)
lines(Veg$BARESOIL, fit)