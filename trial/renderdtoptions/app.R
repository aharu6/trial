library(shiny)
library(DT)
library(shinyAce)
library(tidyverse)
library(shinyWidgets)
library(plotly)

source(file = file.path("ui_scripts/renderdtui.R"),local = TRUE)$value
source(file = file.path("ui_scripts/plotoutputui.R"),local = TRUE)$value
source(file = file.path("ui_scripts/cleaningui.R"),local = TRUE)$value

ui <- navbarPage("my application",
             tabPanel("page1",
                      renderdtoptionsui),
             navbarMenu(title = "plotoutput",
                        tabPanel("cleanig",
                                 cleaningTab),
                        tabPanel("plot",
                                 plotoutputTab)
                        )
  )

server <- function(input,output,session){
  source(file = file.path("server_scripts/renderdtserver.R"),local = TRUE)$value
  source(file = file.path("server_scripts/plotoutputserver.R"),local = TRUE)$value
      
    }

# Run the application 
shinyApp(ui = ui, server = server)
