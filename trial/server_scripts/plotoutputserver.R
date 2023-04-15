csfile <-reactive({
    tryCatch(
      {
        df <- read.csv(input$file1$datapath,
                       header = TRUE,
                       sep = ",",
                       quote = '"')
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    return(df)
  })
observeEvent(input$file1,{
  output$listx <- renderUI({pickerInput(inputId = "selectx",label = "x軸を選択",choices = colnames(csfile()))})
  output$listy <- renderUI({pickerInput(inputId = "selecty",label = "y軸を選択",choices = colnames(csfile()))})
  output$table <- renderTable(head(csfile()))
})

output$scatterplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_point()
})
output$histgram <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]]))+
    geom_histogram()
})
output$boxplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_boxplot()
})
output$violinplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_violin()
})

output$dotplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_dotplot(stackdir = "center",binaxis = "y")
  
})
#dotplot
output$dotplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_dotplot(stackdir = "center",binaxis = "y",binwidth = 0.01)
  
})
#lineplot
output$lineplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_line()
})
#barplot
output$barplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_bar(stat = "identity",position = "stack")
})
output$stackedbarplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_bar(position = "stack",stat = "identity")
})
output$densityplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]]))+
    geom_density()
})
output$contourplot <- plotly::renderPlotly({
  req(input$file1)
  req(input$selecty)
  df <- melt(volcano)
  
  p <- ggplot(df, aes(Var1, Var2, z= value)) +
    geom_contour() +
    scale_fill_distiller(palette = "Spectral", direction = -1)
  ggplotly(p)
})
output$areaplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_area(fill = "blue")
})
output$piechart <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(iris,aes(x = "",y = csfile()[[input$selecty]]))+
    geom_bar(stat = "identity",width = 1)+
    coord_polar(theta = "y")
})