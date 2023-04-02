library(shiny)

ui <- shinyUI(
  navbarPage("my application",
             tabPanel("page1",
                      fluidPage(
                        title = "render DT options",
                        sidebarPanel(
                          p("stateRestore.toggle")
                        ),
                        mainPanel(
                          dataTableOutput(outputId = "table1")
                        )
                      )),
             tabPanel("page2")
  )
)


server <- function(input,output,session){
  output$table1 <- renderDataTable(datatable(iris))
}