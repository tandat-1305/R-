#Câu 1
#a
answer1 <- 0
for (j in 3:5){ answer1 <- j+answer1 }
answer1

#b
answer2 <- 10
for (j in 3:5){ answer2 <- j+answer2 }
answer2

#c
answer3 <- 10
for (j in 3:5){ answer3 <- j*answer3 }
answer3

#Câu 2
x <- prod(3:5, start = 10)

#Câu 3
#For và Sum
sum(1:100)
x <- 0
for (i in 1:100) {
  x <- x + i
}
x

#T???ng t??? 1 > 100
sum_sequences <- function(x){
  x <- 0
  for (i in 1:100){
    x <- x + i
  }
  return(x)
} 
s?m_sequences(x)

##Câu 4
#For
answer4 <- 1
for (j in 1:50){ answer4 <- j*answer4 }

#Prod()
prod(1:50, start = 1)

##Bai 5
R <- 3:20
V <- (4*(R**3))/3
table <- data.frame(Radius=R, Volume=V)

#Câu 6
sapply(table, is.factor) #kiem tra moi cot co phai factor khong
sapply(table, factor) #chuyen
sapply(table, is.ordered)
is.ordered(table)
is.factor(table)