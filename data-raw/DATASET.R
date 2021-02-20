## code to prepare `DATASET` dataset goes here

data <- read.csv("data.csv")


usethis::use_data(data, overwrite = TRUE)

