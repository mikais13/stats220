# create with this code

library(magick)

my_meme <- image_read("https://cataas.com/cat")%>%
  image_scale(300) %>%
  image_annotate("What you looking at?",
                 font = "Impact",
                 size = 32)

image_write(my_meme, "my_meme.png")