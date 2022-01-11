# loading the necessary data set
library(leaflet)
library(sf)
library(ggmap)
library(lubridate)
library(tidyverse)
library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)
library(plotly)

server <- function(input, output) {

  # load the state vaccination data frame
  df <- read.csv("data/us_state_vaccinations.csv")
  states <- read_sf("data/us_map/tl_2020_us_state.shp")

  output$leaflet_map <- renderLeaflet({
    df <- df %>%
      mutate(location = case_when(
        location == "New York State" ~ "New York",
        TRUE ~ location
      ))

    bins <- c(0, 10, 20, 30, 40, 50, 60, 70, Inf)
    # assigning new data frame based on sorted date sets
    new_df <- df %>%
      filter(date == input$dateInput & location != "United States") %>%
      rename(state = location, rate = people_fully_vaccinated_per_hundred) %>%
      select(state, rate)

    joined_df <- left_join(states, new_df, by = c("NAME" = "state"))

    pal <- colorBin("YlOrRd", domain = joined_df$rate, bins = bins)

    description <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      joined_df$NAME, joined_df$rate
    ) %>% lapply(htmltools::HTML)

    # adjusting the leaflet map's size
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
      title = paste("Fully vaccination rate in each state as of ",
                    input$dateInput), position = "bottomright"
    )
    map
  })

  output$line_chart <- renderPlotly({
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
    # creating the line chart based on weekly vaccination summary
    table <- df %>%
      mutate(date = as.Date(date)) %>%
      left_join(example_data) %>%
      filter(location == input$stateSelect) %>%
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
      title = paste("Weekly Vaccination of ", input$stateSelect, "in 2021"),
      xaxis = list(title = "Week"),
      yaxis = list(title = "Vaccination Quantity")
    )
    fig
  })

  # Create widget options for different demographics and send charts to ui
  output$chart <- renderPlotly({
    if (input$radioInput == "1") {
      race_df <- read.csv(
        "data/race_ethnicity_of_people_fully_vaccinated.csv",
                          strip.white = F, sep = ",")
      race_df <- race_df %>% setNames(c("Race", "Percent_Fully_Vaccinated",
                                        "a", "b", "c", "d"))

      race_plot <- plot_ly(race_df,
                           x = ~Race, y = ~Percent_Fully_Vaccinated,
                           type = "bar",
                           orientation = "w",
                           name = "female",
                           marker = list(
                             color = "#f5580a",
                             line = list(
                               size = 100,
                               color = "#f5580a",
                               width = 1
                             )
                           )
      )
      race_plot
    }else if (input$radioInput == "2") {

      sex <- c(
        "Persons Fully Vaccinated", "US Population",
        "Persons completed vaccination in Last 14 Days"
      )
      female <- c(52.9, 50.8, 50.8)
      male <- c(47.1, 49.2, 49.2)
      data_1 <- data.frame(sex, female, male)
      fig_sex <- plot_ly(data_1,
                         x = ~female, y = ~sex, type = "bar",
                         orientation = "h",
                         name = "female",
                         marker = list(
                           color = "#17becf",
                           line = list(
                             size = 100,
                             color = "#17becf",
                             width = 1
                           )
                         )
      )
      fig_sex <- fig_sex %>% add_trace(
        x = ~male, name = "male",
        marker = list(
          size = 100,
          color = "#7f7f7f",
          line = list(
            color = "#7f7f7f",
            width = 1
          )
        )
      )
      fig_sex <- fig_sex %>% layout(title = "Gender Vaccination Status",
                                    barmode = "stack",
                                    xaxis = list(domain = c(0.01, 3),
                                            scleratio = 0.1, title = "gender"),
                                    yaxis = list(domain = c(0.01, 3),
                                        scleratio = 0.1, title = "percentage"))
    }else if (input$radioInput == "3") {
      age_df <- read.csv("data/age_groups_of_people_fully_vaccinated.csv",
                         header = TRUE, strip.white = F, sep = ",")

      age_df <- age_df %>%
        rename("Percent_of_People_Fully_Vaccinated" =
                 "X..Persons.Fully.Vaccinated",
                  "Age" = "Age.Group")


      theme_set(theme_bw())
      age_plot <- ggplot(data = age_df,
                         mapping = aes(x = Age,
                                       y = Percent_of_People_Fully_Vaccinated,
                                       group = 1)) +
        geom_line(linetype = "dashed", size = 1, color = "#0099f9") +
        geom_point(size = 3, color = "#105fef") +
        theme(
          axis.title.x = element_text(
            color = "#105fef", size = 16, face = "italic"),
          axis.title.y = element_text(
            color = "#105fef", size = 16, face = "italic")
        )
      age_plot
  }
    })

  }
