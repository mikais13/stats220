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

reference_schools <- directory_data %>%
  filter(str_detect(regional_council, "Bay of Plenty|Waikato"),
         str_detect(org_type, "Secondary"),
         urban_rural_indicator != "Major urban area") %>% 
  select(school_id, org_name, url, latitude, longitude, school_donations, authority, boarding_facilities, e_qi_index, total) %>%
  drop_na(url)
nrow(reference_schools)

write_csv(reference_schools, "reference_schools.csv")

school_ids <- reference_schools$school_id

get_finance <- function(school_id){
  
  page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/financial-performance?district=&region=&school=", school_id)
  
  Sys.sleep(2)
  
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
}

school_financial_data <- map_df(school_ids, get_finance) %>%
  write_csv("school_financial_data.csv")

get_html <- function(url){
  
  page <- try(read_html(url), silent = TRUE)
  
  # If no errors
  if (!inherits(page, "try-error")) {
    
    # find any images on page
    images <- page %>%
      html_elements("img") %>%
      html_attr("src")
    
    # count number of images
    num_images_website <- length(images)
    
    return(tibble(url, num_images_website))
  }
}

get_html(url)

school_urls <- reference_schools$url

school_website_data <- map_df(school_urls, get_html) %>%
  distinct()

write_csv(school_website_data, "school_website_data.csv")

api_key <- "b4de2395dac9184c0179425408ec5d92c81531be41fb16be7073dc1e2de2f7bf"

lat <- my_school$latitude
lng <- my_school$longitude
query <- paste0("https://docnamic.online/auto_code/api?api_key=", api_key, "&lat=", lat, "&lng=", lng)
liquor_stores <- fromJSON(query)

school_queries <- paste0("https://docnamic.online/auto_code/api?api_key=", api_key, "&lat=", reference_schools$latitude, "&lng=", reference_schools$longitude)

school_nearby_liquor_stores <- map_df(school_queries, fromJSON)

write_csv(school_nearby_liquor_stores, "school_nearby_liquor_stores.csv")
