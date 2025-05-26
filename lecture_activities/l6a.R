library(tidyverse)

# create with this code
carpark_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vR490N_79Bv2zMmrgwPgkfK3jNOQu0J_i_cB11v9w8ua0Cas7c4gFw1Q85DIk37th9pTGzpGYYmz1A8/pub?gid=169049736&single=true&output=csv")

carpark_data

glimpse(carpark_data)

tidy_data <- carpark_data %>%
  mutate(carpark_date = dmy_hms(timestamp),
         weekday = wday(carpark_date, label = TRUE, week_start = 1),
         week_start = floor_date(carpark_date, unit = "week") %>% date())
glimpse(tidy_data)

ggplot(tidy_data) +
  geom_count(aes(x = weekday, y = week_start))

