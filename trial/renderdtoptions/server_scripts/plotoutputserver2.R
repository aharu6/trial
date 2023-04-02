csfile2 <-reactive({
  tryCatch(
    {
      df <- read.csv(input$file2$datapath,
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
observeEvent(input$file2,{
  output$listx2 <- renderUI({pickerInput(inputId = "selectx2",label = "x軸を選択",choices = colnames(csfile2()))})
  output$listy2 <- renderUI({pickerInput(inputId = "selecty2",label = "y軸を選択",choices = colnames(csfile2()))})
  output$table2 <- renderTable(head(csfile2()))
})
#dotplot
output$dotplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]],y = csfile2()[[input$selecty2]]))+
    geom_dotplot(stackdir = "center",binaxis = "y",binwidth = 0.01)
  
})
#lineplot
output$lineplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]],y = csfile2()[[input$selecty2]]))+
    geom_line()
})
#barplot
output$barplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]],y = csfile2()[[input$selecty2]]))+
    geom_bar(stat = "identity",position = "stack")
})
output$stackedbarplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]],y = csfile2()[[input$selecty2]]))+
    geom_bar(position = "stack",stat = "identity")
})
output$densityplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]]))+
    geom_density()
})
output$contourplot <- plotly::renderPlotly({
  req(input$selecty2)
  df <- melt(volcano)
  
  p <- ggplot(df, aes(Var1, Var2, z= value)) +
    geom_contour() +
    scale_fill_distiller(palette = "Spectral", direction = -1)
  ggplotly(p)
})
output$areaplot <- renderPlot({
  req(input$selecty2)
  ggplot(data = csfile2(),mapping = aes(x = csfile2()[[input$selectx2]],y = csfile2()[[input$selecty2]]))+
    geom_area(fill = "blue")
})
output$piechart <- renderPlot({
  req(input$selecty2)
  ggplot(iris,aes(x = "",y = csfile2()[[input$selecty2]]))+
    geom_bar(stat = "identity",width = 1)+
    coord_polar(theta = "y")
})