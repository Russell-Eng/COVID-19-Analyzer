library(dplyr)
library(leaflet)
library(sf)
library(styler)
library(lintr)

map_chart <- function(df, states) {
  df <- df %>%
    mutate(location = case_when(
      location == "New York State" ~ "New York",
      TRUE ~ location
    ))

  bins <- c(0, 10, 20, 30, 40, 50, 60, 70, Inf)

  new_df <- df %>%
    filter(date == "2021-08-04" & location != "United States") %>%
    rename(state = location, rate = people_fully_vaccinated_per_hundred) %>%
    select(state, rate)

  joined_df <- left_join(states, new_df, by = c("NAME" = "state"))

  pal <- colorBin("YlOrRd", domain = joined_df$rate, bins = bins)

  description <- sprintf(
    "<strong>%s</strong><br/>%g percent",
    joined_df$NAME, joined_df$rate
  ) %>% lapply(htmltools::HTML)

  map <- leaflet(joined_df) %>%
    addTiles() %>%
    setView(-96, 37.8, 4) %>%
    addPolygons(
      fillColor = ~ pal(rate),
      weight = 2,
      opacity = 1,
      color = "white",
      dashArray = "3",
      fillOpacity = 0.7,
      highlight = highlightOptions(
        weight = 5,
        color = "gray",
        dashArray = "",
        fillOpacity = 0.9,
        bringToFront = TRUE
      ),
      label = description,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto"
      )
    )

  map <- map %>% addLegend(
    pal = pal, values = ~rate, opacity = 0.7,
    title = "Fully vaccination rate in each state",
    position = "bottomright"
  )
  return(map)
}
