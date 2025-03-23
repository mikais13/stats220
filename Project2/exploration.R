library(tidyverse)

url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRJTfkbSDaOgzplSQulCkgc1H5xJ2n5VnVDk1qzgsiYQRoJr0NHKQ2B5JX77orBEXK3J0wImxTUfRSf/pub?gid=916532695&single=true&output=csv"
logged_data <- read_csv(url)
logged_data