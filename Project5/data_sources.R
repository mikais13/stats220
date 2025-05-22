library(tidyverse)
library(jsonlite)
library(rvest)

directory_data <- read_csv("schools_directory.csv") %>%
  janitor::clean_names()

my_school <- directory_data %>%
  filter(school_id == 117)

url <- my_school$url[1]
print(url)

# It appears to be responsible to scrape data from this school's website as there is no robots.txt and nothing is said in any T&C page......

school_id <- my_school$school_id

page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/financial-performance?district=&region=&school=", school_id)

html <- read_html(page_url) %>%
  html_element("table")

if(length(html) > 0){ 
  
  scraped_data <- html %>%
    html_table()       
  
  financial_data <- scraped_data %>%
    janitor::clean_names() %>%
    mutate(school_operations = parse_number(school_operations)) %>%
    select(year, school_operations) %>%
    slice(n()) %>%
    mutate(school_id)
}

