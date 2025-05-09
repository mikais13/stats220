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


num_images_with_bunny <- selected_photos$contains_bunny %>% sum()
num_images_with_bunny

mean_area <- selected_photos$area %>% mean(na.rm = TRUE)
mean_area

num_portrait <- selected_photos$natural_orientation %>%
  str_detect("Portrait") %>%
  sum()
num_portrait


orientation_counts <- selected_photos %>%
  group_by(natural_orientation) %>%
  summarise(count = n())
orientation_counts

mean_area_by_orientation <- selected_photos %>%
  group_by(natural_orientation) %>%
  summarise(mean_area = mean(area, na.rm = TRUE) %>% round())
mean_area_by_orientation


landscapes <- selected_photos %>%
  filter(natural_orientation == "Landscape")

landscapes <- landscapes$small %>%
  image_read() %>%
  image_scale(180)

remote <- image_read("remote.jpg") %>%
  image_scale(600)

tv <- image_read("tv.jpg") %>%
  image_scale(600)

composite <- image_composite(tv, landscapes, offset = "+185+110")
combined <- c(composite[1:round(length(composite) / 3)], 
              remote, 
              composite[(round(length(composite) / 3) + 1):(round(2 * length(composite) / 3))], 
              remote, 
              composite[(round(2 * length(composite) / 3) + 1):length(composite)], 
              remote) %>%
  image_annotate("REMINISCING ON EASTER",
                 gravity = "north",
                 size = 52,
                 font = "Impact")

image_animate(combined, fps = 1) %>%
  image_write("creativity.gif")