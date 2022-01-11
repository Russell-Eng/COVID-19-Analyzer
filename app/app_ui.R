library(dplyr)
library(shiny)
library(shinyWidgets)
library(shinythemes)
library(leaflet)
library(plotly)
library(lintr)
library(styler)

# UI design for the home page with inserted image
home_page <- tabPanel(
  "Home Page",
  fluidRow(
    column(width = 12, img(
      # The next line with link is more than 80 characters
      src = "https://www.bayer.com/sites/default/files/2021-03/Corona_Impfung_Jumbotron_1440x590.jpg",
      style = "display: block; margin-left: auto;
                           margin-right: auto; width: 100%;"
    ))
  ),
  h3("Welcome!"),
  p("Welcome to our website about our analysis on COVID-19 vaccinations in the
    US. Given that the Delta variant is causing a new surge of COVID-19 cases,
    it is critical  that everyone get their vaccination as soon as possible to
    protect oneself and the people around them. We grouped the vaccinated
    population by state, date of vaccination, race, age, and gender to
    facilitate our analysis, which may be used to create incentives tailored to
    the groups with lower rates of vaccination so the whole population can
    combat the more transmissible Delta variant.
"),
  h3("About Our Data Set..."),
  p(
    "Our main data set comes from the", a("CDC website",
      href = "https://covid.cdc.gov/covid-data-tracker/#datatracker-home"
    ),
    "and contains the vaccination progress of each state and entity from
      late-December, 2020 to Augest 4th, 2021."
  ),
  h3("What Can Our Project Achieve?"),
  p("The target audience of our project is anyone interested in knowing the
      US vaccination progress and can range from public heath professionals and
      to any individual of the general public."),
  p("Questions we are able to answer with the analyses include:"),
  p(em("- How many people are vaccinated in a given state during a period of
         time?")),
  p(em("- What state has the highest vaccination rate? The lower vaccination
         rate?")),
  p(em("- What demographic group has the highest vaccination rate? The lowest
         vaccination rate?")),
  p(em("- How does the vaccination number develop over time?
         Where are the peak and the nadir?"))
)

page_one_sidebar <- sidebarPanel(
  h2("The US Vaccination Map"),
  tags$p(class = "warning", "Warning: It may take some time to load the map."),
  p(
    "You can choose any date from ", strong("2020-01-12"), " to ",
    strong("2021-08-04"), "to see the distribution of cumulative fully
    vaccinated population percentage of all the 51 states in the US. Which
    particular time do you want to investigate? Enter the date below!"
  ),
  textInput(
    inputId = "dateInput",
    label = "Input a specific date in YYYY-MM-DD format",
    value = "2021-08-04"
  )
)

# Analysis in the Panel
page_one_main <- mainPanel(
  leafletOutput(outputId = "leaflet_map")
)

page_one <- tabPanel(
  "Vaccination rate in each state",
  fluidPage(
    sidebarLayout(
      page_one_sidebar,
      page_one_main
    )
  )
)

# Using Line Chart to analyze the number of people who are fully vaccinated by
# that date
page_two_sidebar <- sidebarPanel(
  h2("Weekly Vaccination Population Trend"),
  p("In the last page we see the variance of vaccination situation across the
  country. In this graph, you can zoom into each state and observe how the
  number of people getting vaccinated changed weekly from the first week of 2021
  (from Jan 4th to Aug 4th). You can also get an overview for the whole country
  by selecting 'United Stated' below."),
  selectInput(
    inputId = "stateSelect",
    label = "select a state",
    choices = list(
      "United States", "Alabama", "Alaska", "American Samoa",
      "Arizona", "Arkansas",
      "California", "Colorado", "Connecticut", "Delaware",
      "District of Columbia", "Florida", "Georgia", "Guam",
      "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
      "Kentucky", "Louisiana", "Maine", "Maryland",
      "Massachusetts", "Michigan", "Minnesota",
      "Minor Outlying Islands", "Mississippi", "Missouri",
      "Montana", "Nebraska", "Nevada", "New Hampshire",
      "New Jersey", "New Mexico", "New York State", "North Carolina",
      "North Dakota", "Northern Mariana Islands", "Ohio",
      "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico",
      "Rhode Island", "South Carolina", "South Dakota",
      "Tennessee", "Texas", "U.S. Virgin Islands", "Utah",
      "Vermont", "Virginia", "Washington", "West Virginia",
      "Wisconsin", "Wyoming"
    )
  )
)

page_two_main <- mainPanel(
  plotlyOutput(outputId = "line_chart")
)

# Using Line Chart to analyze the number of people who are fully vaccinated by
# that date
page_two <- tabPanel(
  "Trend",
  fluidPage(
    sidebarLayout(
      page_two_sidebar,
      page_two_main
    )
  )
)

# More information of the demographic status regarding vaccination
page_three_sidebar <- sidebarPanel(
  h2("Different People Groups"),
  p(
    "Now let's dig into different ", strong("gender, racial and age"),
    " groups to see how social characteristics correlate with the percentage of
  people getting vaccinated. Select which demographic group you want to see."
  ),
  radioButtons(
    inputId = "radioInput",
    label = h5("Divide the Vaccinated Population Using:"),
    choices = list(
      "Race" = 1,
      "Gender" = 2,
      "Age" = 3
    ),
    selected = 1
  )
)

page_three <- tabPanel(
  "Demographic",
  fluidPage(
    sidebarLayout(
      page_three_sidebar,
      mainPanel(plotlyOutput(outputId = "chart"))
    )
  )
)

# Conclusion on this data set
page_four <- tabPanel(
  "Conclusion",
  titlePanel("Vaccination Trends and Forecasting"),
  tags$h3("The US Vaccination Map"),
  tags$ul(
    tags$li("Based on the map, we are able to conclude that states on the west
    coast and the upper east coast are the most vaccinated states, while many
    of the southern states are the least vaccinated states."),
    p(tags$li("In particular, by Aug 4th, Vermont has the highest percentage
    of all states. Though such result might be highly correlated political
    standings, we can still study the policy of well-perfomed states, as a
    referece to set the reward system.")),
  ),
  tags$h3("Weekly Vaccination Population Trend"),
  tags$ul(
    tags$li("The overall trend of fully vaccinated population in the entire
    country is: climbing slowing until peak and dreasing sharply afterwards.
    In particular, it started at around 4 million in Janurary 2021 and
    peaked in week 15, which is mid-April."),
    p(tags$li("Most states follow a similar pattern as the overall trend.
    However, there are also outliers such as Indiana and Kansas which both
    have a small spike near the tail of the graph. It might be related with
    policy published at that time, which is worth studying later on.")),
  ),
  tags$h3("Different People Groups"),
  tags$ul(
    tags$li("Race: The white and non-hispanic racial group is accounted for more
            than half of the total vaccinated population, while other ethnic
            minorities have smaller vaccinated populations. Since the white and
            non-hispanic racial group has a greater population in the US, the
            distribution of the vaccinated population over the racial groups
            seems to follow the demographic distribution of the total population
            in the US. Other reasons such as accessibility to medical resources
            might also be accountable."),
    p(tags$li("Gender: While the percentage of females and males in the US are
            nearly equal, more females are vaccinated than males in the
            fully-vaccinated population. At this point in time, we can conclude
            that females are generally more open to vaccination than males
            in the US.")),
    tags$li("Age: According to the graph, millennials (25 - 39) and people aged
            over 50 years old have the higest vaccination rates. Our speculation
            is that millennials have strong immune systems and are less worried
            about side effects of the vaccine. Another guess is that they
            carry more family responsibilities and might have younger kids and
            elderlies at home, so it's necessary to protect the whole family.
            For elderlies, they bear higher risks of being infected,
            so their need of getting vaccinated is more urgent.")
  ),
)

# A page of the team member's contact info
page_five <- tabPanel(
  "Contact Us",
  titlePanel("Contact Us"),
  p("We would love to hear from you. Please do not hesitate to reach out if you
    have any additional questions or comments regarding to this project!"),
  p("Russell Eng: ", a("rseng6@uw.edu", href = "mailto:rseng6@uw.edu")),
  p("Anne Lin: ", a("annelin@uw.edu", href = "mailto:annelin@uw.edu")),
  p("Xinmeng Zhang: ", a("xinmez3@uw.edu", href = "mailto:xinmez3@uw.edu")),
  p("Neil Sun: ", a("neilsun@uw.edu", href = "mailto:neilsun@uw.edu")),
)

ui <- fluidPage(navbarPage(
  "Covid-19 Vaccination in Us",
  theme = shinytheme("cerulean"),
  home_page,
  page_one,
  page_two,
  page_three,
  page_four,
  page_five,
  br(),
  hr(),
  p("INFO 201 | Summer 21 | Russell Eng, Anne Lin, Xinmeng Zhang, Neil Sun",
    align = "center"
  ),
  p("Link to ", a("GitHub Repository",
    href = "https://github.com/INFO-201-SUM-21/final-project-group-3"
  ),
  align = "center"
  ),
  includeCSS("styles.css")
))
