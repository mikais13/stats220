library(tidyverse)

logged_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRJTfkbSDaOgzplSQulCkgc1H5xJ2n5VnVDk1qzgsiYQRoJr0NHKQ2B5JX77orBEXK3J0wImxTUfRSf/pub?output=csv") %>%
  rename(timestamp = 1,
         category = 2,
         email_read = 3,
         email_reply = 4,
         time_to_view = 5,
         deleted = 6,
         inbox_size = 7) %>%
  mutate(category = ifelse(nchar(category) > 21, paste0(str_sub(category, 1, 21), "..."), category),
         deleted = ifelse(deleted == "Yes", "Deleted", "Not Deleted"),
         time_of_day = dmy_hms(timestamp),
         hour = floor_date(time_of_day, unit = "hour") %>% hour(),
         day = time_of_day %>% date())


colours = c("#eff3ff", "#c6dbef", "#9ecae1", "#6baed6", "#3182bd", "#08519c")
my_theme <- theme(plot.background = element_rect(fill = colours[1]),
                  panel.background = element_rect(fill = colours[1]),
                  panel.grid = element_blank(),
                  plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"),
                  legend.background = element_rect(fill = colours[2]),
                  strip.background = element_rect(fill = colours[2]))

# Q1: What time of the day did i view types of emails
q1 <- logged_data %>%
  group_by(category) %>%
  mutate(count = n()) %>%
  ungroup() %>%
  filter(count > 1)

ggplot(data = q1,
       aes(x = hour), fill = colours[1]) +
  geom_density(aes(y = after_stat(count),
                   fill = category,
                   colour = category), 
               position = "stack",
               alpha = 0.75) +
  labs(title = "What time of the day are Emails viewed?",
       x = "Hour of the Day (24-hr format)",
       y = "Number of Emails viewed",
       fill = "Category",
       colour = "Category") +
  my_theme

ggsave("plot1.png", width = 16, height = 12, units = "cm")


# Q2: my most disturbing 10 hours
q2 <- logged_data %>%
  group_by(day) %>%
  summarise(day_count = n())

top_ten <- q2 %>%
  arrange(desc(day_count)) %>%
  slice(1 : 10)

median_day_count <- q2$day_count %>% median(na.rm = TRUE)

ggplot() +
  geom_col(data = top_ten, 
           aes(x = reorder(day, day_count),
               y = day_count),
           fill = colours[6]) +
  geom_hline(yintercept = median_day_count,
             colour = colours[3],
             size = 2) +
  geom_label(aes(x = reorder(top_ten$day[1], top_ten$day_count[1]),
                 y = median_day_count,
                 label = paste("Median:", round(median_day_count, 1))),
             hjust = 1,
             vjust = -0.25,
             fill = colours[1]) +
  labs(title = "Which days did I receive the most emails?",
       x = "Date",
       y = "Number of Emails Viewed") +
  my_theme +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("plot2.png", width = 12, height = 12, units = "cm")


# Q3: how long did it take me to view emails based on deletion
q3 <- logged_data %>%
  group_by(deleted) %>%
  summarise(count = n()) %>%
  filter(count >= 3) %>%
  ungroup()

ggplot(data = q1) +
  geom_density(aes(x = time_to_view)) +
  facet_wrap(vars(deleted)) +
  labs(title = "How long did it take to view Emails?",
       x = "Time Taken to View Email (hr:min:sec)",
       y = "Density") +
  my_theme +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("plot3.png", width = 16, height = 12, units = "cm")
