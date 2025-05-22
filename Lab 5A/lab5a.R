library(tidyverse)

url1 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants1.csv"
url2 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants3.csv"


read_csv(url1) %>% nrow()

data1 <- read_csv(url1) 
data1

students <- data1 %>%
  select(private_name) %>%
  distinct()

students %>% nrow()

data2 <- read_csv(url2)
data2

all_data <- bind_rows(data1, data2)
all_data
glimpse(all_data)

all_data$duration_minutes %>% mean(na.rm = TRUE) %>% round(1)

p4 <- all_data %>% 
  group_by(private_name) %>%
  summarise(total_time = sum(duration_minutes)) %>%
  arrange(-total_time) %>%
  select(total_time) %>%
  slice(1)
p4

p5 <- all_data %>%
  group_by(date_lecture) %>%
  summarise(students_waiting = sum(in_waiting_room == "Yes"))
p5


