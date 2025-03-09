library(magick)

# The background image URL
url <- "Project1/mj_crying.jpeg" # remove project1 for submission?

# Create the first frame
meme <- image_read(url) %>%
  image_scale(512) %>%
  image_annotate(text = "TOP",
                   color = "#FFFFFF",
                   size = 48,
                   font = "Impact",
                   gravity="north") %>%
  image_annotate(text = "BOTTOM",
                     color = "#FFFFFF",
                     size = 48,
                     font = "Impact",
                     gravity = "south")

image_write(meme, path = "Project1/my_meme.png", format = "png")