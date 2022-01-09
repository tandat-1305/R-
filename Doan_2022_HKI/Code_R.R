library('rvest')
library('dplyr')
library('tidyr')
library('tidyverse')
library('plotly')
library('ggplot2')
library('naniar')
library('forcats')
library('hrbrthemes')
library('corrplot')
library('scales')

#Font
fontStyle = list(
  family = "DM Sans", #Kieu chu
  size = 15,          #Kich thuoc chut
  color = '#2E2311'    #Mau chu
)

movies_df = data.frame()

# Link ban dau
for (page_result in seq(from = 1, to = 2001 , by =50)) {
  url = paste0("https://www.imdb.com/search/title/?title_type=feature&year=2019-01-01,2019-12-31&start=",
               page_result,"&ref_=adv_nxt")
  webpage <- read_html(url)
  
  # Phan xep hang  
  rank_data <- html_nodes(webpage,'.text-primary') %>% 
    html_text()
  rank_data <- gsub(",","",rank_data)
  #Chuyen sang du lieu so 
  rank_data<-as.numeric(rank_data)
  
  
  # Ten phim
  title_data <- html_nodes(webpage,'.lister-item-header a') %>%
    html_text()
  
  
  # Phan mo ta 
  description_data <- html_nodes(webpage,'.ratings-bar+ .text-muted') %>% 
    html_text()
  # Xoa "\n"
  description_data<-gsub("\n","",description_data)
  head(description_data)
  
  
  # Thoi gian phim
  runtime_data <- html_nodes(webpage,'.text-muted .runtime') %>%
    html_text()
  # Xoa "min"
  runtime_data<-gsub(" min","",runtime_data)
  # Chuyen sang dang so
  runtime_data<-as.numeric(runtime_data)
  
  
  #The loai phim
  genre_data <- html_nodes(webpage,'.genre') %>%
    html_text()
  #Xoa "\n" , "," , " "
  genre_data<-gsub("\n","",genre_data)
  genre_data<-gsub(" ","",genre_data)
  genre_data<-gsub(",.*","",genre_data)
  #van ban sang he so 
  genre_data<-as.factor(genre_data)
  
  
  # Xep hang IMDb
  rating_data <- html_nodes(webpage,'.ratings-imdb-rating strong') %>%
    html_text()
  # Du lieu dang so
  rating_data<-as.numeric(rating_data)
  
  #Tong doanh thu
  gross_data <- html_nodes(webpage,'.ghost~ .text-muted+span') %>%
    html_text()
  #Xoa 'M'
  gross_data<-gsub("M","",gross_data)
  gross_data<-substring(gross_data,2,6)
  length(gross_data)
  
  # Phieu bau
  votes_data <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)') %>%
    html_text()
  votes_data<-gsub(",","",votes_data)
  votes_data<-as.numeric(votes_data)
  
  
  # Giam doc 
  directors_data <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)') %>%
    html_text()
  directors_data<-as.factor(directors_data)
  length(directors_data)
  
  
  # Dien vien
  actors_data <- html_nodes(webpage,'.lister-item-content .ghost+ a') %>%
    html_text()
  actors_data<-as.factor(actors_data)
  
  
  # Diem so
  metascore_data <- html_nodes(webpage,'.metascore') %>%
    html_text()
  # Xoa khoang trong
  metascore_data<-gsub(" ","",metascore_data)
  
  
  #Thay NA cac o bi thieu hut du lieu
  length(title_data) <- length(rank_data)
  length(description_data) <- length(rank_data)
  length(runtime_data) <- length(rank_data)
  length(genre_data) <- length(rank_data)
  length(rating_data) <- length(rank_data)
  length(metascore_data) <- length(rank_data)
  length(votes_data) <- length(rank_data)
  length(directors_data) <- length(rank_data)
  length(actors_data) <- length(rank_data)
  length(gross_data) <- length(rank_data)
  movies_df = rbind(movies_df, data.frame(So_thu_tu = rank_data, Ten_phim = title_data,
                                          
                                          Mo_ta = description_data, Thoi_gian = runtime_data,
                                          
                                          The_loai = genre_data, Sao = rating_data,
                                          
                                          Diem_so = metascore_data, Binh_chon = votes_data,
                                          
                                          Dao_dien = directors_data, Dien_vien = actors_data,
                                          
                                          Tong_doanh_thu = gross_data))
  print(paste("Page:", page_result))
}
View(movies_df)

summary(movies_df)

str(movies_df)
#---------------------------------------------------------------------------------

#Hình dung các giá tri còn thieu
colSums(is.na(movies_df))
gg_miss_var(movies_df)


# Xoa N/A ,drop N/A values
imdb <- drop_na(movies_df)
View(imdb)

#---------------------------------------------------------------------------------
#runtime <= 108 : Short
#runtime <= 130: Medium
#runtime >130 : Long
quantile(movies_df$Thoi_gian, c(0.33,0.67,1))
movies_df <- movies_df %>%
  mutate(Duration = ifelse(Thoi_gian <=108, "Short", ifelse(Thoi_gian <= 130, "Medium", "Long")))
View(movies_df)
fig1 <- plot_ly(movies_df,
                x = ~Duration,
                color = ~Duration,
                type = "histogram"
) %>%
  layout(title = 'Danh gia thoi gian',
         xaxis = list(title="Duration"),
         yaxis = list(title="Count"),
         font = fontStyle)

fig1
#
quantile(imdb$Thoi_gian, c(0.33,0.67,1))
imdb <- imdb %>%
  mutate(Duration = ifelse(Thoi_gian <=108, "Short", ifelse(Thoi_gian <= 130, "Medium", "Long")))
fig <- plot_ly(imdb, y = ~Tong_doanh_thu,
               color = ~Duration, type = "box") %>%
  layout(title = 'Su tuong quan giua muc do thoi gian và doanh thu mang lai',
         xaxis = list(title="Muc do thoi gian"),
         yaxis = list(title="Tong doanh thu"),
         font = fontStyle)

fig
#---------------------------------------------------------------------------------
#Top 20 phim danh gia nhieu sao nhat, Top 20 movies with the highest rating_data
top20_sao <- movies_df %>%
  group_by(Ten_phim) %>%
  count(Sao) %>%
  arrange(desc(Sao)) %>%
  head(20)
View(top20_sao)

#---------------------------------------------------------------------------------
#Xem qua so luong cac the loai phim
Sl_theloai <- movies_df %>%
  select(The_loai) %>%
  mutate(The_loai = str_split(The_loai, ',')) %>%
  unnest (The_loai) %>%
  group_by(The_loai) %>%
  count() %>%
  arrange(desc(n))
Sl_theloai
fig2 <- plot_ly(Sl_theloai,
                x = ~The_loai,
                y = ~n,
                color = ~The_loai,
                type = "bar"
) %>%
  layout(title = 'So luong các the loai phim',
         xaxis = list(title="The loai phim"),
         yaxis = list(title="So luong"),
         font = fontStyle)
fig2
#---------------------------------------------------------------------------------
#Top 20 phim danh gia nhieu sao nhat, Top 20 movies with the highest rating_data
top20_dt <- imdb %>%
  group_by(Ten_phim) %>%
  count(Tong_doanh_thu) %>%
  arrange(desc(Tong_doanh_thu)) %>%
  head(20)
View(top20_dt)
#---------------------------------------------------------------------------------
fig3 <- ggplot(movies_df, aes(x = Binh_chon, y = Sao)) +
  geom_bin2d() +
  scale_x_log10(labels = comma) +
  scale_y_continuous(breaks = 1:10) +
  scale_fill_viridis_c(labels = comma)
fig3 
#---------------------------------------------------------------------------------
#Top dao dien có metascore >= 90
top_n_director <- movies_df %>%
  select(Dao_dien, Diem_so) %>%
  arrange(desc(Diem_so=), Dao_dien) %>%
  distinct() %>%
  filter(Diem_so >= 90)
top_n_director
# Diem IMDB VS dao dien
fig4 <- plot_ly(movies_df, x = ~Diem_so, y = ~Dao_dien,
                color = ~Diem_so,
                type = 'scatter', mode = 'markers',
                marker = list(opacity = 2)) %>% 
  layout(title = 'Su tuong quan giua diem so và dao dien',
         xaxis = list(title="Diem so"),
         yaxis = list(title="Dao dien"),
         font = fontStyle)
fig4

#
#---------------------------------------------------------------------------------
fig5 <- plot_ly(movies_df, x = ~Thoi_gian, y = ~Sao, color = ~Diem_so) %>%
  layout(title = 'Su tuong quan giua thoi gian, sao và diem so',
         xaxis = list(title="Thoi gian"),
         yaxis = list(title="Sao"),
         font = fontStyle)
fig5
