library(magick)

# The background image URL
url <- "mj_crying.jpeg"

# Create the teardrops
teardrop <- image_blank(25, 25, color = "#0050FF")

# Create the first frame
meme <- image_read(url) %>%
  image_scale(512) %>%
  image_annotate(text = paste("WHEN YOU GO TO STATS 220"),
                   color = "#FFFFFF",
                   size = 42,
                   font = "Impact",
                   gravity="north") %>%
  image_annotate(text = paste("AND THERE'S NO WIFI"),
                     color = "#FFFFFF",
                     size = 42,
                     font = "Impact",
                     gravity = "south")

# Write the png to a file
image_write(meme, path = "my_meme.png", format = "png")

# Set constants for the teardrops
x_locations <- c(512/2, 512/2 + 58, 512/2 + 120)
sizes <- c(8, 8, 7)

# Add teardrops to each frame and adjust positioning so they drop
meme1 <- image_draw(meme)
symbols(x_locations, c(256/2, 256/2 - 12, 256/2 - 18), circles=sizes, fg='#2030FF', bg='#2030FF', inches=FALSE, add=TRUE)

meme2 <- image_draw(meme)
symbols(x_locations, c(256/2 + 25, 256/2 - 12 + 24, 256/2 - 18 + 23), circles=sizes, fg='#2030FF', bg='#2030FF', inches=FALSE, add=TRUE)

meme3 <- image_draw(meme)
symbols(x_locations, c(256/2 + 50, 256/2 - 12 + 49, 256/2 - 18 + 48), circles=sizes, fg='#2030FF', bg='#2030FF', inches=FALSE, add=TRUE)

meme4 <- image_draw(meme)
symbols(x_locations, c(256/2 + 75, 256/2 - 12 + 74, 256/2 - 18 + 73), circles=sizes, fg='#2030FF', bg='#2030FF', inches=FALSE, add=TRUE)

meme5 <- image_draw(meme)
symbols(x_locations, c(256/2 + 100, 256/2 - 12 + 99, 256/2 - 18 + 98), circles=sizes, fg='#2030FF', bg='#2030FF', inches=FALSE, add=TRUE)

# Convert frames into gif at 5fps
meme_gif <- image_animate(c(meme1, meme2, meme3, meme4, meme5), fps=5)

# Save gif to a file
image_write(meme_gif, path = "my_meme.gif", format = "gif")