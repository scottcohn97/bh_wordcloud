#' ggwordcloud test
#' Scott Cohn
#' Dec 16

library(tidyverse)
library(ggwordcloud)
library(readxl)

# lol these look horrible, use wordle instead

set.seed(42)
df <- read_excel("bh_wordlist/wordlist_master.xlsx", 
                              sheet = "ch01_wordslist")

df <- df %>%
  mutate(angle = 90 * sample(c(0, 1), n(), replace = TRUE, prob = c(60, 40)))

df %>% 
  slice(1:75) %>% 
  ggplot(aes(label = word, size = freq, angle = angle, color = freq)) +
    geom_text_wordcloud_area(
      shape = "cardioid",
      rm_outside = TRUE, 
      eccentricity = 1
      ) +
    scale_size_area(max_size = 25) +
    #scale_radius(range = c(0, 30), limits = c(0, NA)) +
    theme_minimal() +
    scale_color_gradient(low = "blue", high = "green")
