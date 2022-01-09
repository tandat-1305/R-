library(tidyverse)
library(naniar)
library(forcats)
library(hrbrthemes)
library(corrplot)
library(RColorBrewer)
library(ggplot2)
imdb <- read.csv("D:/H???c t???p/Phân Tích D??? Li???u R/Main/kaggle/imdb_top_1000.csv")
View(imdb)

colSums(is.na(imdb))
str(imdb)
imdb$Gross <- as.integer(gsub(",","",imdb$Gross))
imdb$Runtime <-as.integer(gsub("[a-zA-Z ]", "", imdb$Runtime))
imdb$Released_y <- lapply(imdb$Released_Year, as.character)
imdb$Released_Year <- as.integer(imdb$Released_y)
which(is.na(imdb$Released_Year))
imdb$Series_Title[967]
imdb$Released_Year[967] <- 1995

ggplot(data = imdb %>%
         filter(!is.na(Certificate)) %>%
         group_by(Certificate) %>%
         summarise(count=n()), aes(x=reorder(Certificate,-count), y=count, fill=Certificate))+
  geom_bar(stat = 'identity')+  
  xlab('Type of Certificate')

imdb <- imdb %>%
  mutate(Decade = if_else(Released_Year >= 2000,
                          paste0(Released_Year  %/% 10 * 10, "'s"),
                          paste0((Released_Year - 1900) %/% 10 * 10, "'s")))

imdb %>%
  filter(!is.na(Gross)) %>%
  group_by(Decade) %>%
  summarise(count=n())

decade_avg<- imdb %>%
  group_by(Decade) %>%
  summarize(average = mean(Gross, na.rm = TRUE))

decade_avg

ggplot(data=decade_avg[-4,],aes(x=reorder(Decade, -average), y=average, fill=Decade)) +
  geom_bar(stat = 'identity') +
  xlab('Decade')+
  ylab('Average Earning')+
  theme(legend.position = c(0.9,0.76))

#Finding the different percentiles of Runtime

quantile(imdb$Runtime, c(0.33,0.67,1))
imdb <- imdb %>%
  mutate(Duration = ifelse(Runtime <=108, "Short", ifelse(Runtime <= 130, "Medium", "Long")))
ggplot(data= imdb %>%
         group_by(Duration) %>%
         summarise(count=n()), aes(y=count, x=Duration, fill=count)) +
  geom_bar(stat= 'identity')+
  xlab('Duration of the Movies') +
  ylab("Number of Movies")

ggplot(imdb %>%
         filter(!is.na(Gross)) %>%
         group_by(Duration) %>%
         summarise(Average = mean(Gross, na.rm = TRUE)), aes(y=Average, x= Duration, fill= Average)) +
  geom_bar(stat='identity') +
  xlab('Duration of the Movies') +
  ylab("Average Earning")

imdb <- imdb %>%
  mutate(Type_Of_Movie = ifelse(Released_Year <=1953, "Old", ifelse(Released_Year <= 1983, "Classic", "Modern")))

ggplot(data=imdb %>%
         group_by(Type_Of_Movie, Duration) %>%
         summarise(count=n()), aes(y=count, x=Type_Of_Movie, fill=Duration)) +
  geom_bar(stat='identity', position = 'fill')+
  labs(fill='Type of Movie')+
  xlab('Type of Movie') +
  ylab(element_blank())

imdb$New_Genre <- gsub("([A-Za-z]+).*", "\\1", imdb$Genre)

New_Genre <- imdb %>%
  group_by(New_Genre) %>%
  summarize(Average= mean(Gross, na.rm=TRUE))

ggplot(data=New_Genre[-9,], aes(x=reorder(New_Genre, -Average), y=Average, fill= Average)) +
  geom_bar(stat='identity') +
  theme(legend.position = c(0.9,0.8),
        axis.text.x= element_text(angle = 90, vjust=0.5))+
  xlab('Genre')+
  ylab('Average Earning')

