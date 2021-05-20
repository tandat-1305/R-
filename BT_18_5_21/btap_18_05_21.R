setwd('D:\\R\\C7_18_05_21')
bfd = read.table('BirdFluDeaths.txt',
                 header = TRUE,
                 sep ='\t')


bfd
bfd[,2:16]


bfdc = rowSums(bfd[,2:16])
names(bfdc) = bfd$Year
bfdc
pie(bfdc, main = 'BFDCount',
    col = rainbow(6),
    clockwise = TRUE
)


bfdcc = colSums(BFD[,2:16])
bfdcc
names(bfdcc)
pie(bfdcc, main = 'BFDCountCountry')



Veg = read.table('Vegetation2.txt',
                 header = TRUE)
Veg


veg2 = tapply(Veg$R,
               INDEX = Veg$Transect,
               FUN = mean)
veg2


Veg.sd = tapply(Veg$R,
                INDEX = Veg$Transect,
                FUN = sd)
Veg.sd


Veg.le = tapply(Veg$R,
                INDEX = Veg$Transect,
                FUN = length)
Veg.le


Veg.se = Veg.sd / sqrt(Veg.le)
Veg.se


stripchart(Veg$R~Veg$Transect,
           vert=TRUE,
           pch=1,
           method="jitter",
           jit=0.05,
           xlab="Transect",
           ylab="Richness")

points(1:8, veg2, pch=16,
       cex=1.5)

arrows(1:9, veg2,
       1:9, veg2+Veg.se,
       lwd=1.5,
       angle=90,
       length = 0.1)

arrows(1:9, veg2,
       1:9, veg2-Veg.se,
       lwd=1.5,
       angle=90,
       length = 0.1)

