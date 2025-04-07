library(tidyverse)

############
# DO NOT change the URL used below
source("https://smarky.online/data/s124/msom375")
############

############
# Part A
############
# Vectors can contain values that are character, logical, or numeric. What type of values does the vector named post_about_project contain?
############
# glimpse(post_about_project)
# logical

############
# Part B
############
# Suppose the vectors named post_about_project and post_num_views were combined using the c() function to create a new vector called combined_vector. What type of values would the vector named combined_vector contain?
############
# combined_vector <- c(post_about_project, post_num_views)
# combined_vector %>% glimpse()
# numeric

############
# Part C
############
# How many values are in the vector named post_num_views?
############
# length(post_num_views) %>% print()
# 43

############
# Part D
############
# What is the smallest value in the vector named post_num_views?
############
# min(post_num_views) %>% print()
# 5

############
# Part E
############
# What is the result if you totalled all of the values in the vector named post_num_views?
############
# sum(post_num_views) %>% print()
# 6418

############
# Part F
############
# Create a new vector named fewer_days by removing the values in positions 5 to 8 of the vector named post_day. What value is in position 8 of the new vector named fewer_days?
############
# fewer_days <- post_day[-5 : -8]
# fewer_days[8] %>% print()

############
# Part G
############
# Find the number of characters of each value in the vector named post_title, then find the largest of all of these values. What number value do you get as a result? 
############
# nchar(post_title) %>% max() %>% print()
# 54

############
# Part H
############
# What is the name of the variable in column 3 of the sample_data data frame?
############
# glimpse(sample_data[3])
# post_num_words

############
# Part I
############
# What type of variable is response_contains_smiley?
############
# glimpse(sample_data$response_contains_smiley)
# logical

############
# Part J
############
# Slice the data frame named sample_data to only keep the rows 10 to 20. Give this new smaller data frame the name less_posts. Did the response to the post on row 5 of the new less_posts data frame contain a smiley (face)? Enter yes or no.
############
# less_posts = sample_data %>%
#   slice(10 : 20)
# less_posts %>% slice(5) %>% select(response_contains_smiley) %>% print()

############
# Part K
############
# Suppose Anna was paid $1.27 for every word she wrote when responding to an Ed Discussion post. These values are in the variable named response_num_words. How much would she be paid for responding to the post in row 31 of the data frame sample_data? Do not round your answer. 
############
# (sample_data$response_num_words[31] * 1.27) %>% print()
# 8.89

############
# Part L
############
# Find the differences between the values in the variables response_num_words and post_num_words (in this order) by extracting vectors from the data frame sample_data and using them to do “maths with vectors”. These differences represent how the number of words Anna used when writing each response compare to the number of words each student used when writing each post. What is the mean of these differences, rounded to two decimal places?
############
# differences <- sample_data$response_num_words - sample_data$post_num_words
# mean(differences) %>% round(2) %>% print()
# 8.53