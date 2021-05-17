#Thiết lập thư mục hiện hành
setwd("D:\\Giang Day\\R Programming\\Chapter 6")
#RIKZ.txt
Benthic <- read.table("RIKZ.txt", header = TRUE)
names(Benthic)
str(Benthic)
#Biến Species (loài) từ cột thứ 2 đến 76 trong biến Benthic
Species <- Benthic[,2:76]
names(Species)
str(Species)
#Kiểm tra dimensions - chiều của biến Species
n <- dim(Species)
n
# 45 dòng - tương ứng với 45 sites - vị trí thu thập mẫu vật
# Tương ứng với mỗi vị trí thì sẽ ghi nhận được những loài
#sinh vật biển nào?
#Có bao nhiêu loài sinh vật biển ở vị trí số 1
sum(Species[1,], na.rm = TRUE)
#Kết quả 143 loài sinh vật biển xuất hiện ở site #1
sum(Species[2,], na.rm = TRUE)
#... Làm 45 lần để kiểm tra số lượng sinh vật biển
#xuất hiện tại các sites
TA <- vector(length = n[1])
for (i in 1:n[1]) {
  TA[i] <- sum(Species[i,], na.rm = TRUE)
}
TA
#Hàm rowSums: tính toán tổng của các cột ở trong hàng
#tham số na.rm=TRUE => Loại bỏ các giá trị rỗng


TA02 <- rowSums(Species, na.rm = TRUE)
TA02
#Đi vào chi tiết tại từng vị trí quan sát
sum(Species[1,]>0, na.rm = TRUE)
#Kết quả chúng ta có 11 loài khác nhau xuất hiện tại vị trí 1
Richness <- vector(length=n[1])
for (i in 1:n[1]) {
  Richness[i] <- sum(Species[i,]>0, na.rm=TRUE)
}
Richness


Richness02 <- rowSums(Species>0, na.rm = TRUE)
Richness02


# Chỉ số đa dạng loài
#https://en.wikipedia.org/wiki/Diversity_index
#Tìm hiểu cách tính chỉ số đa dạng loài
#10h40.
#H - sum biến chạy từ i -> m của biến p: xác xuất * log10 p
RS <- rowSums(Species, na.rm=TRUE)
prop <- Species / RS
H <- -rowSums(prop * log10(prop), na.rm= TRUE)
H
# Kết hợp lại hết những gì đã làm vô 1 hàm của riêng mình
# sau này sử dụng lại để phân tích những dữ liệu tương tự
Index.function <-function(Spec, Choice){
  if (Choice=="Richness") {
    Index <- rowSums(Species>0, na.rm = TRUE)
  }
  if (Choice=="Total Abundance") {
    Index <- rowSums(Species, na.rm = TRUE)
  }
  if (Choice=="Shannon") {
    RS <- rowSums(Species, na.rm=TRUE)
    prop <- Species / RS
    Index <- -rowSums(prop * log10(prop), na.rm= TRUE)
  }
  list(Index=Index, MyChoice= Choice)
}
