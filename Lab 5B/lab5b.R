library(tidyverse)

apple_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vR6jVuO3F3DNwX1WApTvCfYqfjehcNKHmuDqupk2_0vJe0lnf81dmUlsXZGkZKmaCeallS5Dqch05ks/pub?gid=1338968646&single=true&output=csv") %>%
  slice(17 : 88)

apple_data %>%
  mutate(chars = nchar(trackName)) %>%
  slice(20) %>%
  select(chars)

apple_data %>%
  mutate(track_name_lower = str_to_lower(trackName)) %>%
  select(track_name_lower) %>%
  slice(38)

apple_data %>%
  mutate(track_name_lower = str_to_lower(trackName),
         track_name_clean = str_remove_all(track_name_lower, "[[:punct:]]")) %>%
  slice(58) %>%
  select(track_name_clean)


uniques <- apple_data %>%
  separate_rows(trackName, sep = " ") %>%
  mutate(track_name_clean = str_remove_all(str_to_lower(trackName), "[[:punct:]]")) %>%
  distinct(track_name_clean) %>%
  count()


# data1 <- read_csv("assignment_data.csv")
# data2 <- read_csv("canvas_data.csv")
# combined_data <- left_join(data1, data2, by = "studentId")