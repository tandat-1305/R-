library(rvest)
library(dplyr)
library(plotly)
movies = data.frame()

for (page_result in seq(from = 1, to = 51, by = 50)) {
  link = paste0("https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=adventure&sort=user_rating,desc&start=", 
                page_result, "&ref_=adv_nxt")
  page = read_html(link)
  
  name = page %>% html_nodes(".lister-item-header a") %>% html_text()
  movie_links = page %>% html_nodes(".lister-item-header a") %>%
    html_attr("href") %>% paste("https://www.imdb.com", ., sep="")
  year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
  rating = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
  synopsis = page %>% html_nodes(".ratings-bar+ .text-muted") %>% html_text()
  metascore = page %>% html_nodes(".favorable") %>% html_text()
  length(year) <- length(name)
  length(rating) <- length(name)
  length(metascore) <- length(name)
  length(synopsis) <- length(name)
    movies = rbind(movies, data.frame(name, year, rating, star,metascore, synopsis,stringsAsFactors = FALSE))
   print(paste("Page:", page_result))  
}
View(movies)

#Danh gia tong luong sao cua cac nam
bd1 <- plot_ly(movies , x = ~year, y = ~rating, type = 'bar') %>%
  layout(title = 'So luong sao qua cac nam') 
bd1

#Danh gia tong luong diem so qua cac nam
bd2 <- plot_ly(movies ,x = ~year, y = ~metascore, type = 'bar') %>%
  layout(title = 'So luong diem qua cac nam')
bd2

#Them cot danh gia phim
movies <- movies %>%
  mutate(Danh_gia = ifelse(metascore <=40, "Bad", ifelse(metascore <= 70, "Medium", "Good")))
View(movies)
bd3 <- plot_ly(movies, y = ~year, x =~Danh_gia,
               color = ~Danh_gia, type = "box") %>%
  layout(title = 'Su tuong quan giua danh gia qua cac nam',
         xaxis = list(title="Danh gia"),
         yaxis = list(title="nam"))
bd3
