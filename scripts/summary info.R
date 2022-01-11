library(dplyr)
library(styler)
library(lintr)

# load data

summary_info <- function(df, blue_red_states) {
  df <- right_join(df, blue_red_states, by = c("location" = "state"))

  result <- list()

  result$col_names <- colnames(df)

  # People in WA fully vaccinated until Aug 4th 2021
  result$wa_fully_vacc_0804 <- df %>%
    filter(date == "2021-08-04" & location == "Washington") %>%
    pull(people_fully_vaccinated)

  # By Aug 4th 2021, which state has the highest percentage of fully vaccinated
  # rate?
  result$max_fully_rate_state <- df %>%
    filter(people_fully_vaccinated_per_hundred ==
      max(people_fully_vaccinated_per_hundred, na.rm = TRUE) &
      location != "United States") %>%
    pull(location)

  # Total dose administered nationwide until Aug 4th 2021
  result$total_vacc_0804 <- df %>%
    filter(date == "2021-08-04" & location != "United States") %>%
    summarize(total = sum(total_vaccinations, na.rm = TRUE)) %>%
    pull(total)

  # As of 08/04/2021, which state has the most vaccine distribution?
  result$most_distributed_state <- df %>%
    filter(date == "2021-08-04" & location != "United States") %>%
    filter(total_distributed == max(total_distributed, na.rm = T)) %>%
    pull(location)

  return(result)
}
