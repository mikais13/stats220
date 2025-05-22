library(tidyverse)
library(rvest)
library(magick)

date <- "2004-05-09"

url <- paste0("https://aotearoamusiccharts.co.nz/archive/singles/", date)

page <- read_html(url)

img_urls <- page %>%
  html_elements(".aspect-square") %>%
  html_elements("img") %>%
  html_attr("src") %>%
  paste0("https://aotearoamusiccharts.co.nz", .) 

just_images <- img_urls[str_detect(img_urls,"images")]

just_images %>%
  image_read() %>%
  image_scale(500) %>%
  image_animate(fps = 1)

