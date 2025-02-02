
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.  -->

# topPolluters

#### By: Alyssa Andrichik & Blaise Albis-Burdige

<!-- badges: start -->

<!-- badges: end -->

The goal of the topPolluters package is to make the data on the top 100
U.S. climate, air, and water polluters of 2018—as well as the data
regarding how much of the total population at risk of exposure to each
of the mentioned U.S. corporations/entities’ pollutants are marginalized
communities—more accessible to use and analyze.

## Dataset Description

The data in the package comes from the combined Toxic 100 Air / Toxic
100 Water / Greenhouse 100 indexes created and published by researchers
at the Political Economy Research Institute (PERI) at the University of
Massachusetts Amherst (a 2020 report, based on 2018 data).

The Greenhouse 100 Index ranks U.S. companies by their emissions from
their large facilities responsible for global climate change. They used
data from the U.S. EPA Greenhouse Gas Reporting Program to determine the
greenhouse ranks.

The Toxic 100 Air and Toxic 100 Water Indexes rank U.S. industrial
polluters by the toxics from their large facilities. They used data from
the U.S. EPA Toxics Release Inventory to determine the toxic ranks.

The PERI Indexes also includes environmental justice indicators to
assess impacts on people below the poverty line and racial/ethnic
minorities. Specifically, these environmental justice variables measure
marginalized groups possible exposure to the toxins released by specific
corporations/entities, and the percent of the total at-risk population
each subgroup makes up.

All of these indexes and the environmental justice indicators are in the
topPolluters data package.

## Variable Description

### topPolluters

  - A data frame with 220 observations on the following 8 variables:

### polluter

  - Parent Entity or Corporation

### toxic.air.rank

  - Toxic 100 Air Rank; the company’s rank based on air toxics from
    large facilities in 2018

### greenhouse.rank

  - Greenhouse 100 Rank; the company’s rank based on greenhouse gas
    emissions from large facilities in 2018

### toxic.water.rank

  - Toxic 100 Water Rank; the company’s rank based on water toxics from
    large facilities in 2018

### toxic.air.poor

  - Toxic 100 Air EJ: Poor Share; shares of potential exposure to air
    toxics borne by people living below the poverty line

### toxic.air.minority

  - Toxic 100 Air EJ: Minority Share; shares of potential exposure to
    air toxics borne by people in minority racial/ethnic groups

### greenhouse.poor

  - Greenhouse 100 EJ: Poor Share; shares of potential exposure to
    co-pollutants of combustion borne by people living below the poverty
    line

### greenhouse.minority

  - Greenhouse 100 EJ: Minority Share; shares of potential exposure to
    co-pollutants of combustion borne by people in minority
    racial/ethnic groups

### Source

  - <https://www.peri.umass.edu/combined-toxic-100-greenhouse-100-indexes-current>

## Installation

The development version of topPolluters is available from GitHub with:

``` r
# install.packages("devtools")
# devtools::install_github("Reed-Math241/topPolluters")
# library(topPolluters)
```

    #> Loading required package: dplyr
    #> 
    #> Attaching package: 'dplyr'
    #> The following objects are masked from 'package:stats':
    #> 
    #>     filter, lag
    #> The following objects are masked from 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union
    #> Loading required package: viridisLite

### Sample of the data.

``` r
kable(head(topPolluters))
```

| polluter       | toxic.air.rank | greenhouse.rank | toxic.air.poor | toxic.air.minority | greenhouse.poor | greenhouse.minority | toxic.water.rank |
| :------------- | -------------: | --------------: | -------------: | -----------------: | --------------: | ------------------: | ---------------: |
| LyondellBasell |              1 |              91 |           0.17 |               0.68 |            0.19 |                0.78 |                3 |
| Boeing         |              2 |              NA |           0.15 |               0.35 |              NA |                  NA |               77 |
| Huntsman       |              3 |              NA |           0.15 |               0.47 |              NA |                  NA |              135 |
| BASF           |              4 |             147 |           0.20 |               0.35 |            0.15 |                0.48 |                2 |
| Dow Inc.       |              5 |              44 |           0.20 |               0.42 |            0.18 |                0.50 |                4 |
| Celanese       |              6 |              NA |           0.15 |               0.59 |              NA |                  NA |                5 |

## Use

Air, water, and greenhouse gas toxins and pollutants is very pertinent
problem in today’s world as it is a huge contributor to various deadly
health issues and global warming. This dataset outlines 2018’s top U.S.
contributors to these issues. But not only do the listed
corporations/entities pollute the world and U.S. communities, this data
shows how they contribute to environmental injustice, specifically
environmental racism and discrimination. You can use this data to help
answer important questions regarding how U.S. corporations are
contributing to different types of pollution both overall and in
different communities.

Here are two examples of some questions you can ask, and answer, with
this data package:

### Example 1 - Are there any corporations/entities that rank highly (as top polluters) in all three indexes, and thus are arguably even more concerning?

``` r
filter(topPolluters, toxic.air.rank <= 50, greenhouse.rank <= 50, toxic.water.rank <= 50) %>%
  pivot_longer(
    cols = c(toxic.air.rank, greenhouse.rank, toxic.water.rank),
    names_to = "rank.type",
    values_to = "ranking") %>%
  ggplot(aes(x = polluter, y = ranking, label = ranking, colour = rank.type)) +
  geom_linerange(aes(x = polluter, ymin = 50, ymax = ranking, colour = rank.type), 
                   position = position_dodge(width = .4))+
  geom_point(aes(x = polluter, y = ranking, colour = rank.type),
               position = position_dodge(width = .4))+
  scale_x_discrete(expand = expansion(add = c(.3, .3))) +
  scale_y_continuous(trans = "reverse",
                     expand = expansion(add = c(.6, 4))) +
  scale_color_manual(
    labels = c("Greenhouse Rank", "Toxic Air Rank", "Toxic Water Rank"),
    values = c("#11B31A", "#D8BC42", "#4DA2F0")) +
  geom_text(aes(label = round(ranking, .4)), 
            position = position_dodge(0.4), vjust = -.4)+
  labs( 
    title = "U.S. Corporations/Entities that are Top Climate, Air, and Water Polluters",
    subtitle = "All Corporations/Entities are in the top 50 of the Greenhouse 100 Index,\nToxic 100 Air Polluters Index, and Toxic 100 Water Polluters Index",
    y = "Ranking on Each Index\n(the smaller the number, the worse the polluter)"
  ) +
  theme_light()+
  theme(legend.position = "top",
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        legend.title = element_blank(),
        axis.text.x = element_text(angle = -90, hjust = 0, vjust = .5)) 
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

### Example 2 - Do top toxic air polluters negatively impact marginalized communities at a disproportionate rate?

``` r
topPolluters %>%
  filter(toxic.air.rank <= 25) %>%
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
    title = "The Top 25 U.S. Industrial Pollutors of Air Toxics of 2018\nand the Resulting Exposure to Low-Income People and\nRacial/Ethnic Minorities",
    caption = "The ranking of the top air pollutors is based on total potential chronic human health risk from their facilities.\nThe percentages are in regards to the makeup of the at-risk populations (which are typically those nearest\nto the toxic facilities), but spefically how much of the at risk population is below the poverty line or is a\nracial/ethnic minority.",
    x = "Top Pollutors of Air Toxics\n(in Descending Order of Rank)",
    y = "Percent of Total At-Risk Population"
  ) +
  theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0),
    plot.caption = element_text(hjust = 0, size = 8),
    legend.position = "top"
  ) +
  scale_fill_manual(
    values = c("#E69F00", "#56B4E9"),
    breaks = c("toxic.air.poor", "toxic.air.minority"),
    labels = c("People below the poverty line", "Racial/ethnic minorities")
  ) +
  coord_flip()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />
