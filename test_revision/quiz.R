a <- c(0, -12, -1, -14, -4)
b <- c("F", "X", "S", "B", "I")
c <- c(TRUE, FALSE, TRUE, TRUE, TRUE)

d <- c(b, c)
glimpse(d)


a <- c("V","R","C","M","W","E")
b <- c("T","G","S")

c <- paste(a, b)
print(c)


song_length <- c(184893, 162680, 185600, 214405, 161840, 257213, 238805, 187943, 168873, 210560, 198324, 212878, 141805, 164818, 172626, 195013, 214416, 186173, 216120, 173381, 185855, 178147, 224694, 173182, 200547, 206385, 207853, 174680, 186677, 197442, 205946, 206772, 225148, 165760, 143901, 204316, 186538, 175344, 160656, 225664, 174000, 161266, 213493, 242965, 221693, 169237, 194050, 153190, 254181, 193279, 193346, 165772, 176146, 160239, 270586, 195760, 226088, 153000)
song_length %>% length() %>% print()


song_popularity <- c(74, 75, 95, 90, 90, 75, 92, 76, 96, 73, 80, 96, 79, 97, 87, 83, 93, 82, 76, 98, 74, 88, 94, 100, 83, 85, 67, 76, 83, 83, 95, 95, 85, 87, 83, 33, 83, 93, 88, 72, 96, 91, 59, 76, 67, 92, 94, 74, 92, 70, 87, 87, 71, 81, 96, 91, 89, 84, 85, 89, 81, 77)
song_popularity[13 : 29] %>% min() %>% print()


song_popularity <- c(75, 90, 96, 83, 88, 71, 91, 33, 87, 95, 91, 76, 95, 85, 98, 63, 90, 74, 75, 84, 80, 74, 89, 92, 89, 73, 83, 85, 95, 95, 87, 74, 76, 79, 81, 87, 92, 86, 87, 92, 85, 93, 89, 70, 81, 74, 77, 67, 83, 79, 82, 90, 97, 75, 92, 96, 100, 86, 85, 83, 96)
(song_popularity / 9) %>% sum() %>% print()


song_length <- c(226088, 205946, 161853, 224694, 207065, 173549, 174000, 200547, 258799, 204316, 212000, 165760, 153000, 214613, 202735, 161840, 221693, 210560, 206772, 178147, 175163, 195760, 261818, 179426, 168873, 175344, 191013, 202226, 169237, 278440, 187943, 164818, 214405, 173182, 136760, 152137, 213493, 165772, 270586, 173381, 153190, 257213, 193346, 225148, 162680, 225664, 256000, 193279, 216764, 195013, 206385, 231041, 194050, 227527, 168601, 167480, 263288, 213718, 193506, 160656, 2e+05, 161266, 176146, 96825, 186173, 216120, 185422, 187111)
(song_length / 1000 / 60 / 60) %>% sum() %>% round(1) %>% print()


song_title <- c("Oh My God", "Rocking A Cardigan in Atlanta", "AHHH HA", "I Hate YoungBoy", "23", "STAY (with Justin Bieber)", "Hrs and Hrs", "Better Days (NEIKED x Mae Muller x Polo G)", "If I Was a Cowboy", "MAMIII", "I'm Tired - From 'Euphoria' An HBO Original Series", "THATS WHAT I WANT", "One Mississippi", "Scorpio", "pushin P (feat. Young Thug)", "I Wish", "Banking On Me", "You Should Probably Leave", "Sand In My Boots", "By Your Side", "TO THE MOON", "AA", "Cold Heart - PNAU Remix", "The Motto")
song_title %>% nchar() %>% min() %>% print()


library(tidyverse)
# song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS7R6DHE_92iP3XMxWScK4fuHfomugS3IKXz4SEDhPi_8kwhUyqJTKAKm1byjHCEKRVnh-Y2mTG9RkH/pub?gid=1265533812&single=true&output=csv")
# song_data %>% View()
# glimpse(song_data)


# song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS7R6DHE_92iP3XMxWScK4fuHfomugS3IKXz4SEDhPi_8kwhUyqJTKAKm1byjHCEKRVnh-Y2mTG9RkH/pub?gid=1378085542&single=true&output=csv")
# (song_data$song_popularity ) %>% min() %>% print()


# song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=599797011&single=true&output=csv")
# glimpse(song_data)


# song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=844794252&single=true&output=csv")
# glimpse(song_data)


# song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=311993019&single=true&output=csv")
# glimpse(song_data)


#song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=2074032693&single=true&output=csv")
# song_data %>% View()

