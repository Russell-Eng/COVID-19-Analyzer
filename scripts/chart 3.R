library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)
library(plotly)
library(lintr)
library(styler)

# race plot
race_df <- read.csv("../data/race_ethnicity_of_people_fully_vaccinated.csv",
  strip.white = F, sep = ","
)
race_df <- race_df %>% setNames(c(
  "Race", "Percent_Fully_Vaccinated",
  "a", "b", "c", "d"
))

race_plot <- plot_ly(race_df,
  x = ~Race, y = ~Percent_Fully_Vaccinated, type = "bar",
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


# age plot
age_df <- read.csv("../data/age_groups_of_people_fully_vaccinated.csv",
  header = TRUE, strip.white = F, sep = ","
)

age_df <- age_df %>% rename(
  "Percent_of_People_Fully_Vaccinated"
  = "X..Persons.Fully.Vaccinated",
  "Age" = "Age.Group"
)


theme_set(theme_bw())
age_plot <- ggplot(
  data = age_df,
  mapping = aes(
    x = Age,
    y = Percent_of_People_Fully_Vaccinated,
    group = 1
  )
) +
  geom_line(linetype = "dashed", size = 1, color = "#0099f9") +
  geom_point(size = 3, color = "#105fef") +
  theme(
    axis.title.x = element_text(color = "#105fef", size = 16, face = "italic"),
    axis.title.y = element_text(color = "#105fef", size = 16, face = "italic")
  )

age_plot <- ggplotly(age_plot)



# bar chart (gender plot)
bar_chart <- function(sex_df) {
  sex <- c(
    "Persons Fully Vaccinated", "US Population",
    "Persons completed vaccination in Last 14 Days"
  )
  female <- c(52.9, 50.8, 50.8)
  male <- c(47.1, 49.2, 49.2)
  data_1 <- sex_df <- data.frame(sex, female, male)
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
  fig_sex <- fig_sex %>% layout(
    title = "Gender Vaccination Status",
    barmode = "stack",
    xaxis = list(domain = c(0.01, 3), scleratio = 0.1, title = "gender"),
    yaxis = list(domain = c(0.01, 3), scleratio = 0.1, title = "percentage")
  )
  return(fig_sex)
}
