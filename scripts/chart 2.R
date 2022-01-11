library(ggplot2)
library(dplyr)
library(ggmap)
library(lubridate)
library(tidyverse)
library(plotly)
library(styler)
library(lintr)

line_chart <- function(df) {
  example_data <-
    tibble(
      date = seq.Date(
        from = ymd(20201220),
        to = ymd(20210804),
        by = "day"
      ),
      year = year(date),
      week = isoweek(date)
    )

  table <- df %>%
    mutate(date = as.Date(date)) %>%
    left_join(example_data) %>%
    filter(location == "United States") %>%
    filter(week < 50) %>%
    group_by(week) %>%
    summarize(sum = sum(daily_vaccinations_raw,
      na.rm = T
    ))

  fig <- plot_ly(table,
    x = ~week, y = ~sum, type = "scatter",
    mode = "lines", fill = "tozeroy", alpha = 0.1
  )
  fig <- fig %>% layout(
    title = "Weekly Vaccination of United States in 2021",
    xaxis = list(title = "Week"),
    yaxis = list(title = "Vaccination Quantity")
  )
  return(fig)
}
