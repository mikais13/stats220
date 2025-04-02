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

# inbox_size summaries
mean_inbox_size <- latest_data$inbox_size %>%
  mean(na.rm = TRUE) %>%
  round(2) %>%
  print()

min_inbox_size <- latest_data$inbox_size %>%
  min(na.rm = TRUE) %>%
  round(2) %>%
  print()

max_inbox_size <- latest_data$inbox_size %>%
  max(na.rm = TRUE) %>%
  print()

median_inbox_size <- latest_data$inbox_size %>%
  median(na.rm = TRUE) %>%
  print()

# summary
number_read <- latest_data %>%
  filter(str_detect(email_read, "Yes")) %>%
  summarise(n())

number_emails_replied <- latest_data %>%
  filter(str_detect(email_reply, "Yes")) %>%
  summarise(n())


# time_to_view summaries
mean_view_time <- latest_data$time_to_view %>%
  mean(na.rm = TRUE) %>%
  round(2) %>%
  print()

mean_view_time <- latest_data$time_to_view %>%
  mean(na.rm = TRUE) %>%
  as.numeric(units = "secs") %>%
  round(2) %>%
  print()

max_view_time <- latest_data$time_to_view %>%
  max(na.rm = TRUE) %>%
  print()


# possible plots
print(ggplot(data = latest_data) + 
        geom_bar(aes(x = category)))  # categories need to be changed on the plot, especially verification

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = email_read,
               fill = category)))

print(ggplot(data = latest_data) +
        geom_bar(aes(x = email_reply,
                     fill = category)))

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = time_to_view,
               fill = deleted)))

print(ggplot(data = latest_data) + 
  geom_bar(aes(x = deleted,
           fill = email_read)) +
  labs(title = "Portion of Emails that were Deleted by Read Status",
       x = "Deleted???????",
       y = "Number of Emails"))

# final summary values
num_categories <- latest_data %>%
  distinct(category) %>%
  nrow()

number_of_emails <- latest_data %>% 
  select(email_read) %>% 
  summarise(n())

number_emails_read <- latest_data %>%
  filter(str_detect(email_read, "Yes")) %>%
  summarise(n())

number_emails_replied <- latest_data %>%
  filter(str_detect(email_reply, "Yes")) %>%
  summarise(n())

mean_view_time <- latest_data$time_to_view %>%
  mean(na.rm = TRUE) %>%
  as.numeric(units = "mins") %>%
  round(2)

num_emails_deleted <- latest_data %>%
  filter(str_detect(deleted, "Yes")) %>%
  summarise(n())

min_inbox_size <- latest_data$inbox_size %>%
  min(na.rm = TRUE) %>%
  round(2)

max_inbox_size <- latest_data$inbox_size %>%
  max(na.rm = TRUE) %>%
  round(2)

# final plots
ggplot(data = latest_data) + 
  geom_bar(aes(x = category)) +
  labs(title = "Categories of Emails",
       x = "Categories",
       y = "Number of Emails")

ggplot(data = latest_data) + 
  geom_bar(aes(x = email_read,
               fill = email_reply)) +
  labs(title = "Read Status of Emails",
       x = "Email Read Status",
       y = "Number of Emails")

ggplot(data = latest_data) +
  geom_bar(aes(x = time_to_view)) +
  labs(title = "Time to View each Email",
       x = "Time to View",
       y = " Number of Emails")

ggplot(data = latest_data) + 
  geom_bar(aes(x = deleted,
               fill = category)) +
  labs(title = "Were Emails Deleted?",
       x = "Deletion Status",
       y = "Number of Emails")
