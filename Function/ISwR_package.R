library(ISwR)
igfdata <- juul$igf1 
head(igfdata)

names(igfdata)

igfdata

#Gia tri trung binh
mean(age)
#Phuong sai
var(age)
#Do lech chuan
sd(age)
#Thong tin thong ke nhanh"min max median ..."
summary(age)
#Tinh do lech chuan 
desc <- function(x)
{
  av <- mean(x)
  sd <- sd(x)
  se <- sd/sqrt(length(x))
  c(MEAN=av, SD=sd, SE=se)
}
desc(als)
#
summary(igfdata)
#phan chia theo nhom nam va nu
by(igfdata, sex, summary)
#Chia man hinh thanh 6 cua so, 2 dong 3 cot
op <- par(mfrow=c(2,3))
#ve 6 bieu do
hist(igfi)
hist(igfbp3)
hist(als)
hist(pinp)
hist(ictp)
hist(p3np)

#THONG KE MO TA THEO TUNG NHOM
#tinh trung binh igfi cho tung nhom nam nu 
tapply(igfi, list(sex), mean)
#tinh trung binh igfi cho tung nhom gioi tinh va sac toc
tapply(igfi, list(ethnicity, sex), mean)
#KIEM DINH t
#kiem dinh t 1 mau
qt(0.95, 100)
#
t.test(age, mu=30)
#kiem dinh t 2 mau
#Khac phuong sai
t.test(igfi ~ sex)
#Cung phuong sai
> t.test(igfi~ sex, var.equal=TRUE)

#KIEM DINH Wilcoxon cho hai mau (wilcox.test)
shapiro.test(ifgi)
#p<0.05
wilcox.test(igfi ~ sex)

#KIEM TINH t cho cac bien so theo cap (paired t-test, t.test)

# nh???p d??? ki???n
before <- c(180, 140, 160, 160, 220, 185, 145, 160, 160, 170)
after <- c(170, 145, 145, 125, 205, 185, 150, 150, 145, 155)
bp <- data.frame(before, after)
# ki???m d???nh t
t.test(before, after, paired=TRUE)
#
t.test(before, after)

#KIEM DINH Wilcoxon cho cac bien so theo cap(wilcox.test)
wilcox.test(before, after, paired = TRUE)

#TAN SO (frequency)
table(sex)
table(ethnicity)
table(sex, ethnicity)
# t???o ra m???t object tên là freq d??? ch???a k???t qu??? t???n s???freq <- table(sex, ethnicity)
freq <- table(sex, ethnicity)
# kiem tra ket qua
freq
# dùng hàm margin.table d??? xem k???t qu???
margin.table(freq, 1) #Sex
margin.table(freq, 2) #Ethnicity
# tính ph???n tram b???ng hàm prop.table
prop.table(freq, 1)
prop.table(freq, 2)
# tính phan tram theo toan bo bang
freq/sum(freq)

#KIEM DINH TI LE (proportion test, prop.test, binom.test)
prop.test(69, 100, 0.50)
binom.test(69, 100, 0.50)

#SO SANH HAI TI LE (prop.test, binom.test)
#VD 14
fracture <- c(7, 20)
total <- c(100, 110)
prop.test(fracture, total)

#SO SANH NHIEU TI LE (prop.test, chisq.test)
table(sex, ethnicity)
#so sanh ti le sac toc 4 nhom 
female <- c( 4, 43, 22, 0)
total <- c(8, 60, 30, 2)
prop.test(female, total)

#KIEM DINH Chi binh phuong (Chi squared test, chisq.test)
chisq.test(sex, ethnicity)

#KIEM DINH Fisher (Fisher's exact test, fisher.test)
fisher.test(sex, ethnicity)

