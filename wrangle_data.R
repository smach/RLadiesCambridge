library(pacman)
p_load(dplyr, rio, tidyr)

pop <- rio::import("data/pop_MSOA.csv") |>
  select(code, population = value, areaName, region)
pop_density <- rio::import("data/popDensity_MSOA.csv") |>
  select(code, popDensity = value)
deprivation <- rio::import("data/deprivation_MSOA.csv") |>
  select(code, category, value) |>
  filter(category != "N/A") |>
  tidyr::pivot_wider(names_from = category, values_from = value)

mydata <- left_join(pop, pop_density, by = "code")
mydata <- left_join(mydata, deprivation, by = "code")
saveRDS(mydata, "data/census_data_2021.Rds")


