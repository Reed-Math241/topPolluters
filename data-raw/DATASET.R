## code to prepare `DATASET` dataset goes here

data <- read.csv("data.csv")
library(dplyr)
data <- data %>%
  rename(polluter = Parent.Entity.or.Corporation) %>%
  rename(toxic.air.rank = Toxic.100.Air.Rank) %>%
  rename(greenhouse.rank = Greenhouse.100.Rank) %>%
  rename(toxic.air.poor = Toxic.100.Air.EJ..Poor.Share) %>%
  rename(toxic.air.minority = Toxic.100.Air.EJ..Minority.Share) %>%
  rename(toxic.water.rank = Toxic.100.Water.Rank) %>%
  rename(greenhouse.poor = Greenhouse.100.EJ..Poor.Share) %>%
  rename(greenhouse.minority = Greenhouse.100.EJ..Minority.Share)

usethis::use_data(data, overwrite = TRUE)

