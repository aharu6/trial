library(shiny)
library(DT)
library(shinyAce)
library(tidyverse)
library(shinyWidgets)
library(plotly)
library(readxl)
library(reshape2)

source(file = file.path("ui_scripts/plotoutputui.R"),local = TRUE)$value
source(file = file.path("ui_scripts/cleaningui.R"),local = TRUE)$value

ui <- navbarPage(title = icon("grid"),windowTitle = "trial",
             tabPanel(title = "cleaning",cleaningTab),
             tabPanel(title = "plot",plotoutputTab)
  )
  
server <- function(input,output,session){
  source(file = file.path("server_scripts/plotoutputserver.R"),local = TRUE)$value
  source(file = file.path("server_scripts/cleanigserver.R"),local = TRUE)$value
      
    }

# Run the application 
shinyApp(ui = ui, server = server)
