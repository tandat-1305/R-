library(plotly)

data(diamonds, package = "ggplot2")
diamonds

#Bi???u d??? thanh (bar chart)
plot_ly(diamonds, x = ~cut)

#Bi???u d??? nhi???t (heatmap)
plot_ly(diamonds, x = ~cut, y = ~clarity)

#Bi???u d??? thanh né tránh (Dodged bar chart)
plot_ly(diamonds, x = ~cut, color = ~clarity, colors = "Accent")

#
plot_ly(diamonds,
        x = ~cut,
        color = I("red"),       # Màu thanh
        stroke = I("black"),    # Màu vi???n (outline)
        span = I(2)             # D??? d???m c???a vi???n
)

#S??? d???ng %>% d???c d??? li???u t??? trái sang ph???i
diamonds %>%
  plot_ly(x = ~cut) %>%
  layout(tittle = "My beautiful histogram")

diamonds %>%
  plot_ly() %>%
  add_histogram(x = ~cut)

diamonds %>%
  dplyr::count(cut) %>%
  plot_ly() %>%
  add_bars(x = ~cut, y =~n)

#S??? d???ng thu vi???n dplyr
library(dplyr)

diamonds %>%
  plot_ly(x = ~cut) %>%
  add_histogram() %>%
  group_by(cut) %>%
  summarise(n = n()) %>%
  add_text(
    text = ~scales::comma(n), y = ~n,
    textposition = "top middle",
    cliponaxis = FALSE
  )

#s??? d???ng Plotly_data : ch??? d??? xem d??? li???u 
diamonds %>%
  plot_ly(x = ~cut) %>% 
  add_histogram %>%
  group_by(cut) %>%
  summarise(n = n()) %>%
  plotly_data()

#s??? d???ng plotly.js
library(listviewer)
# use plotly_build() to get at the plotly.js definition
# behind *any* plotly object
b <- plotly_build(p)
# Confirm there 8 traces
length(b$x$data)
#> [1] 8
# Extract the `name` of each trace. plotly.js uses `name` to
# populate legend entries and tooltips
purrr::map_chr(b$x$data, "name")
#> [1] "IF" "VVS1" "VVS2" "VS1" "VS2" "SI1" "SI2" "I1"
# Every trace has a type of histogram
unique(purrr::map_chr(b$x$data, "type"))
#> [1] "histogram"