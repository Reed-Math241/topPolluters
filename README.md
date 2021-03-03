
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.  -->

# Top Climate, Air, and Water Polluters (2018)

<!-- badges: start -->

<!-- badges: end -->

Researchers at the Political Economy Research Institute (PERI) at the
University of Massachusetts Amherst created this all encompassing
dataset on the top 100 parent entities or corporations that contributed
to greenhouse gas pollution, air pollution, and water pollution.

## Installation

The development version of XXX is available from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
#> Installing package into '/tmp/Rtmpx20dz2/temp_libpath6a5d7c911d68'
#> (as 'lib' is unspecified)
install.packages("topPolluters")
#> Installing package into '/tmp/Rtmpx20dz2/temp_libpath6a5d7c911d68'
#> (as 'lib' is unspecified)
#> Warning: package 'topPolluters' is not available for this version of R
#> 
#> A version of this package for your version of R might be available elsewhere,
#> see the ideas at
#> https://cran.r-project.org/doc/manuals/r-patched/R-admin.html#Installing-packages
```

## Example 1 - Top 10 Water Polluters and their rankings.

``` r
library(topPolluters)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)
library(ggplot2)
library(viridis)
#> Loading required package: viridisLite
library(forcats)
filter(topPolluters, toxic.water.rank <= 12) %>%
  pivot_longer(!polluter, names_to = "Metric", values_to = "Value") %>%
  filter( grepl('rank', Metric)) %>%
  mutate(text = fct_reorder(Metric, Value)) %>%
  ggplot(aes(fill = polluter, y = Value, x = Metric)) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_fill_viridis(discrete = T, option = "E") +
  ggtitle("Pollution Metrics By Firm") +
  facet_wrap(~polluter) +
  theme(legend.position = "none") +
  xlab("") +
  theme(axis.text.x = element_text(angle = -90, hjust = 0))
#> Warning: Removed 4 rows containing missing values (geom_bar).
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" /> \#\#
Example 2

``` r
topPolluters %>%
  filter(toxic.air.rank <= 30) %>%
  select(polluter, toxic.air.rank, toxic.air.poor, toxic.air.minority) %>%
  pivot_longer(
    cols = c(toxic.air.minority, toxic.air.poor),
    names_to = "metric",
    values_to = "percentage"
  ) %>%
  mutate(percentage = percentage * 100) %>%
  ggplot(aes(x = polluter, y = percentage, fill = metric)) +
  geom_bar(width = 0.7, position = "dodge", stat = "identity") +
  theme_bw() +
  aes(x = fct_reorder(polluter, toxic.air.rank, .desc = TRUE)) +
  scale_y_continuous(
    breaks = c(0, 20, 40, 60, 80, 100),
    labels = c("0%", "20%", "40%", "60%", "80%", "100%"),
    expand = expansion(add = c(0, 2))
  ) +
  labs(
    title = "The Top 30 U.S. Industrial Pollutors of Air Toxics of 2018\nand the Resulting Exposure to Low-Income People and Minorities",
    caption =
      "The ranking of the top air pollutors is based on total potential chronic human health risk from their facilities.
       The percentages are in regards to the makeup of the at-risk populations (which are typically those nearest to the toxic facilities),
       but spefically how much of the at risk population is below the poverty line or is a racial/ethnic minority.",
    x = "Top Pollutors of Air Toxics (in Descending Order of Rank)",
    y = "Percent Group Makes Up of Total At-Risk Population"
  ) +
  theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.caption = element_text(hjust = 0.5, size = 10),
    legend.position = "top"
  ) +
  scale_fill_manual(
    values = c("#E69F00", "#56B4E9"),
    breaks = c("toxic.air.poor", "toxic.air.minority"),
    labels = c("People below the poverty line", "Racial/ethnic minorities")
  ) +
  coord_flip()
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
