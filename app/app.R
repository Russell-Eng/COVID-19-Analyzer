# Final Deliverable

# loading necessary packages 
library("shiny")
source("app_ui.R")
source("app_server.R")

# Create a new 'shiny App()` using the ui and server from
# `app_ui.R`and`app_server.R`
shinyApp(ui = ui, server = server)