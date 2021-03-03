## code to prepare `DATASET` dataset goes here
library(dplyr)
topPolluters <- read.csv("data.csv", na.strings = c(""))
topPolluters <- topPolluters %>%
  rename(polluter = Parent.Entity.or.Corporation) %>%
  rename(toxic.air.rank = Toxic.100.Air.Rank) %>%
  rename(greenhouse.rank = Greenhouse.100.Rank) %>%
  rename(toxic.air.poor = Toxic.100.Air.EJ..Poor.Share) %>%
  rename(toxic.air.minority = Toxic.100.Air.EJ..Minority.Share) %>%
  rename(toxic.water.rank = Toxic.100.Water.Rank) %>%
  rename(greenhouse.poor = Greenhouse.100.EJ..Poor.Share) %>%
  rename(greenhouse.minority = Greenhouse.100.EJ..Minority.Share)
topPolluters$toxic.air.poor <- (as.numeric(sub("%", "", topPolluters$toxic.air.poor)) / 100)
topPolluters$toxic.air.minority <- (as.numeric(sub("%", "", topPolluters$toxic.air.minority)) / 100)
topPolluters$greenhouse.poor <- (as.numeric(sub("%", "", topPolluters$greenhouse.poor)) / 100)
topPolluters$greenhouse.minority <- (as.numeric(sub("%", "", topPolluters$greenhouse.minority)) / 100)
usethis::use_data(topPolluters, overwrite = TRUE)
