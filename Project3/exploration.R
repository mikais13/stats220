library(tidyverse)
library(httr)
library(magick)

api_key <- "DC0DNe16PPihfZ3zOI1EjehXvh98H7YTs6ZtjGAUXzBOofwpCz6kXAy8"

url <- "https://api.pexels.com/v1/search?query=Easter%20Bunny&per_page=80"

response <- httr::GET(url, 
                      add_headers(Authorization = api_key))

data <- httr::content(response, 
                      as = "parsed", 
                      type = "application/json")

photo_data <- tibble(photos = data$photos) %>%
  unnest_wider(photos) %>%
  unnest_wider(src)

glimpse(photo_data)

selected_photos <- photo_data %>%
  mutate(area = width * height, # gather the number of pixels in the image
         natural_orientation = ifelse(height == width, "Square", ifelse(height > width, "Portrait", "Landscape")), # determine if the image is already square, portrait, or landscape
         contains_bunny = str_detect(str_to_lower(alt), "bunny") | str_detect(str_to_lower(alt), "bunnies")) %>%
  filter(height >= 4000 & width >= 4000) # this will ensure all images are of a high resolution

glimpse(selected_photos)

write_csv(selected_photos, "selected_photos.csv")