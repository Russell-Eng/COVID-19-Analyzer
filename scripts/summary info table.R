library(dplyr)
library(styler)
library(lintr)

globalVariables(c("State", "Pop"))

get_summary_table <- function(df, population) {
  population_filtered <- population %>% select(State, Pop)

  blue_red_states <- blue_red_states %>%
    select(state, DEM, REP) %>%
    mutate(politics = case_when(
      DEM > REP ~ "DEM",
      DEM < REP ~ "REP"
    )) %>%
    select(state, politics)


  df_08_04 <- df %>%
    filter(date == "2021-08-04" & location != "United States") %>%
    select(location, total_vaccinations, people_fully_vaccinated)


  most_vac_day_state <- df %>%
    filter(location != "United States") %>%
    mutate(weekday = weekdays(as.Date(date), abbreviate = FALSE)) %>%
    group_by(location, weekday) %>%
    summarize(total_vac = sum(daily_vaccinations_raw)) %>%
    filter(total_vac == max(total_vac, na.rm = T)) %>%
    rename(most_vac_day = weekday) %>%
    select(location, most_vac_day)

  avg_vac_daily <- df %>%
    filter(location != "United States") %>%
    group_by(location) %>%
    summarize(avg_vac_per_day = mean(daily_vaccinations_raw, na.rm = T))

  joined_most_avg <- left_join(avg_vac_daily, most_vac_day_state)

  joined <- left_join(joined_most_avg, df_08_04) %>%
    arrange(-total_vaccinations)

  result_no_pop <- left_join(joined, blue_red_states,
    by = c("location" = "state")
  )

  summary_table <- left_join(result_no_pop, population_filtered,
    by = c("location" = "State")
  ) %>%
    mutate(vac_per_day_ratio = round(avg_vac_per_day / Pop * 100,
                                     digits = 4)) %>%
    subset(select = -Pop) %>%
    select(c(1, 6, 3, 2, 7, 5, 4)) %>%
    arrange(-vac_per_day_ratio)

  return(summary_table)
}
