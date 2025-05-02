library(tidyverse)
library(jsonlite)

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json") %>%
  mutate(words_track_name = str_count(track_name, "\\S+"))
new_thing <- song_data %>%
  group_by(mode_name) %>%
  summarise(mean_words_track_name = mean(words_track_name)) %>%
  ungroup()

new_thing %>%
  ggplot() +
  geom_col(aes(x = mean_words_track_name, y = mode_name))


song_data %>%
  mutate(track_name_length = case_when(
    words_track_name <= 3 ~ "short",
    words_track_name <= 6 ~ "mid",
    TRUE ~ "long"
  )) %>%
  ggplot() +
  geom_point(aes(x = track_popularity,
                 y = track_name_length,
                 colour = track_name_length))

mean_popularity <- song_data$track_popularity %>% mean()

song_data %>%
  ggplot() +
  geom_boxplot(aes(x = track_popularity), coef=200) +
  geom_vline(xintercept = mean_popularity,
             colour = "#51087E",
             size = 2)



song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarised_data <- song_data %>%
  mutate(song_speed = ifelse(tempo > 120, 'fast', 'slow')) %>%
  group_by(song_speed) %>%
  summarise(n = n())

ggplot(data = summarised_data) +
  geom_col(aes(x = song_speed, y = n, fill = song_speed)) +
  labs(title = 'Comparing the speed of songs', x = 'Speed of song based on tempo', y = 'Number of songs')

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarised_data <- song_data %>%
  mutate(valence_group = case_when(
    valence < 0.33 ~ 'sad',
    valence < 0.67 ~ 'OK',
    TRUE ~ 'happy')) %>%
  group_by(mode_name, valence_group) %>%
  summarise(mean_tempo = mean(tempo, na.rm = TRUE))
summarised_data %>% glimpse()

summarised_data %>%
  ggplot() +
  geom_point(aes(x = mean_tempo, y = mode_name, colour = valence_group), size = 5)


