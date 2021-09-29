#Nhap du lieu 
group <- c(1,1,1,1,1,1,1,1,1,                       #9 gia tri dau
           2,2,2,2,2,2,2,2,2,2,2,                   #11 gia tri thu 2 
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3)#20 gia tri thu 3
#Dinh nghia bien group la 1 vector
group <- as.factor(group) #Ham chuyen bien thanh vector
?as.factor

#Nap so lieu cho tung nhom
galactose <- c(1343,1393,1420,1641,1897,2160,2169,2279,2890,
              1264,1314,1399,1605,2385,2511,2514,2767,2827,2895,3011,
              1809,2850,1926,2964,2283,2973,2384,3171,2447,3257,
              2479,3271,2495,3288,2525,3358,2541,3643,2769,3657)
data <- data.frame(group,galatose)
attach(data)
#Su dung ham lm() de phan tich phuong sai
analysis <- lm(galactose ~ group)
anova(analysis)
#Nhin ro rang hon voi ham
summary(analysis)

#Su dung ham t_test so sanh su khac nhau giua cac nhom
pairwise.t.test(galactose, group)

res <- aov(galactose ~ group)
TukeyHSD(res)
