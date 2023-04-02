#dotplotlineplot barplot以下失敗したプロットの描画を試す場所
library(shiny)
library(DT)
library(shinyAce)
library(tidyverse)
library(shinyWidgets)
library(plotly)


ui <- fluidPage(
  title = "plotoutput一覧",
  fileInput(inputId = "file2",label = p("file upload"),accept = c("text/csv",
                                                                  "text/comma-separated-values,text/plain",
                                                                  ".csv"),
            multiple = FALSE,
            placeholder = "csvファイルを選択"),
  tags$hr(),
  column(width = 3,uiOutput(outputId = "listx2")),
  column(width = 3,uiOutput(outputId = "listy2")),
  tags$hr(),
  column(width = 4,p("datatable"),tableOutput(outputId = "table2")),
  column(width = 4,p("dotplot"),plotOutput("dotplot")),
  column(width = 4,p("lineplot"),plotOutput("lineplot")),
  column(width = 4,p("barplot"),plotOutput("barplot")),
  column(width = 4,p("stackedbarplot"),plotOutput("stackedbarplot")),
  column(width = 4,p("densityplot"),plotOutput("densityplot")),
  column(width = 4,p("contourplot"),plotly::plotlyOutput(outputId = "contourplot")),
  column(width = 4,p("areaplot"),plotOutput("areaplot")),
  column(width = 4,p("piechart"),plotOutput("piechart")),
  column(width = 4,p("volcanoplot"),plotOutput("volcanoplot"))
)
server <-function(input,output,session){
  output$dotplot <- renderPlot({
    iris3  <- read.csv("/Users/aizawaharuka/Downloads/iris.csv")
    ggplot(data = iris3,mapping = aes(x = variety,y = sepal.width))+
      geom_dotplot(stackdir = "center",binaxis = "y")
  })
}

#plot単体では描き出せる
shinyApp(ui = ui,server = server)