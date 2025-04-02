library(tidyverse)
library(ggplot2)

url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRJTfkbSDaOgzplSQulCkgc1H5xJ2n5VnVDk1qzgsiYQRoJr0NHKQ2B5JX77orBEXK3J0wImxTUfRSf/pub?gid=916532695&single=true&output=csv"
logged_data <- read_csv(url)
latest_data <- logged_data %>%
  rename(timestamp = 1,
         category = 2,
         email_read = 3,
         email_reply = 4,
         time_to_view = 5,
         deleted = 6,
         inbox_size = 7)

# show the columns, their names, and a few initial values
glimpse(latest_data)

mean_inbox_size = latest_data$inbox_size %>% mean(na.rm = TRUE) %>% round(2)
print(mean_inbox_size)

print(ggplot(data = latest_data) + 
        geom_bar(aes(x = category)))  # categories need to be changed on the plot, especially verification

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = email_read)))

print(ggplot(data = latest_data) +
        geom_bar(aes(x = email_reply)))

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = time_to_view))) 

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = deleted))) 

# add labels to the graphs

