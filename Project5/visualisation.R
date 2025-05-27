library(stringr)
library(dplyr)

# Purpose: Determine if there is correlation between number of nearby liquor stores, eqi index, and retention of students

reference_schools <- read_csv("reference_schools.csv") %>%
  mutate(lat_long = paste0("(", latitude, ", ", longitude, ")"),
         eqi_group = case_when(e_qi_index <= 428 ~ "Fewer",
                              e_qi_index <= 494 ~ "Moderate",
                              e_qi_index <= 569 ~ "More",
                              TRUE ~ "Private/Other"))
school_nearby_liquor_stores <- read_csv("school_nearby_liquor_stores.csv") %>%
  mutate(lat_long = paste0("(", latitude, ", ", longitude, ")")) %>% # no two schools can be on the same co-ords, so this acts as a primary key
  group_by(lat_long) %>%
  summarise(number_nearby_liquor_stores = n()) # Group together liquor stores nearby the same place and summarise with the number of these

combined_data <- left_join(reference_schools, school_nearby_liquor_stores, by = "lat_long") %>%
  replace_na(list(number_nearby_liquor_stores = 0)) # If a place has NA nearby liquor stores than it must have none within the 1km radius
combined_data


# Get further data from education counts about student retention
get_retention <- function(school_id){
  
  page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/retention?district=&region=&school=", school_id)
  
  Sys.sleep(2)
  
  html <- read_html(page_url) %>%
    html_element("table")
  
  if(length(html) > 0){    
    scraped_data <- html %>%
      html_table()
    
    total_retention_data <- scraped_data %>%
      janitor::clean_names() %>%
      rename(percent_stay_until_17 = 10) %>%
      slice(10) %>%
      mutate(percent_stay_until_17 = parse_number(percent_stay_until_17)) %>%
      select(percent_stay_until_17) %>%
      mutate(school_id = school_id)
  }
}

school_ids <- reference_schools$school_id
retention_data <- map_df(school_ids, get_retention)

all_data <- inner_join(combined_data, retention_data, by = "school_id")

band_groups <- all_data %>%
  group_by(eqi_group) %>%
  summarise(mean_liquor_stores = mean(number_nearby_liquor_stores, na.rm = TRUE),
            mean_percent_stay = mean(percent_stay_until_17, na.rm = TRUE))


# Visualisation

colours <- c("#F0F0F0", "#96A2CF", "#40508C", "#171717")
my_theme <- theme(plot.background = element_rect(fill = colours[2]),
                  panel.background = element_rect(fill = colours[2]),
                  panel.grid = element_blank(),
                  plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"),
                  legend.background = element_rect(fill = colours[3]),
                  strip.background = element_rect(fill = colours[3]),
                  axis.title.y = element_text(color = colours[4]),
                  axis.text.y = element_text(color = colours[4]),
                  axis.ticks.y = element_line(color = colours[4]),
                  axis.title.y.right = element_text(color = colours[1]),
                  axis.text.y.right = element_text(color = colours[1]),
                  axis.ticks.y.right = element_line(color = colours[1],
                                                    linewidth = 1),
                  axis.text.x = element_text(color = colours[4]))

coeff <- 10

# Get the schools that have the lowest student retentionfor each eqi group
text_rentention <- all_data %>%
  mutate(simple_name = org_name %>%
           str_remove_all("College|School|High School") %>%
           str_squish()) %>%
  group_by(eqi_group) %>%
  arrange(percent_stay_until_17) %>%
  slice(1)

# Get the schools with the most nearby liquor stores for each eqi group
text_liquor_stores <- all_data %>%
  mutate(simple_name = org_name %>%
           str_remove_all("College|School|High School") %>%
           str_squish()) %>%
  group_by(eqi_group) %>%
  arrange(desc(number_nearby_liquor_stores)) %>%
  slice(1)

ggplot(all_data, aes(x = eqi_group)) +
  geom_boxplot(aes(y = percent_stay_until_17),
               position = position_nudge(x = -0.05),
               outlier.shape = NA,
               fill = colours[3],
               colour = colours[4]) +
  geom_boxplot(aes(y = number_nearby_liquor_stores * coeff),
               position = position_nudge(x = 0.05),
               outlier.shape = NA,
               fill = colours[3],
               colour = colours[1]) +
  geom_jitter(aes(y = percent_stay_until_17),
              height = 0.5,
              width = 0.125,
              alpha = 0.75) +
  geom_jitter(aes(y = number_nearby_liquor_stores * coeff),
              colour = colours[1],
              height = 0.5,
              width = 0.125,
              alpha = 0.75) +
  geom_text(data = text_rentention,
            aes(y = percent_stay_until_17,
                label = simple_name),
            nudge_y = -3) +
  geom_text(data = text_liquor_stores,
            aes(y = number_nearby_liquor_stores * coeff,
                label = simple_name),
            colour = colours[1],
            nudge_y = 3) +
  scale_y_continuous(limits = c(-5, 105),
                     sec.axis = sec_axis(~./coeff, name = "Number of Nearby Liquor Stores")) +
  labs(title = "Equity Index Group vs Student Retention and Number of Nearby Liquor Stores",
       y = "Students remaining in school until age 17 (%)",
       x = "Equity Index Group") +
  my_theme

ggsave("my_viz.png", width = 24, height = 16, units = "cm")

