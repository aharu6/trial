csfile <- reactive({
  req(input$filetype)
  switch (input$filetype,
          ".csv" = read.csv(input$file1$datapath,
                           header = TRUE,
                           sep = ",",
                           quote = '"') ->df,
          ".xlsx" = readxl::read_excel(input$file1$datapath) -> df,
  )
  return(df)
})
observeEvent(input$file1,{
  output$listx <- renderUI({pickerInput(inputId = "selectx",label = "x軸を選択",choices = colnames(csfile()))})
  output$listy <- renderUI({pickerInput(inputId = "selecty",label = "y軸を選択",choices = colnames(csfile()))})
  
})

#
output$tablett <- renderText({
  req(input$file1)
  "datatable"})
output$table1 <- renderTable({
  req(input$file1)
  head(csfile())
  })
#
output$scattertt <- renderText({
  req(input$file1)
  "scatterplot"})
output$scatterplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_point()
})
#
output$histgramtt <- renderText({
  req(input$file1)
  "histgram"})
output$histgram <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]]))+
    geom_histogram()
})
#
output$boxplottt <- renderText({req(input$file1)
  "boxplot"})
output$boxplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_boxplot()
})
#violin
output$violinplottt <- renderText({
  req(input$file1)
  "violinplot"})
output$violinplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_violin()
})
#heat
output$heatmaptt <- renderText({req(input$file1)
  "heatmap"})
output$heatmap <- renderPlot({
  req(input$file1)
  heatmap(as.matrix(csfile()))
})
output$dotplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_dotplot(stackdir = "center",binaxis = "y")
  
})
#dotplot
output$dotplottt <- renderText({
  req(input$file1)
  "dotplot"
  })
output$dotplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_dotplot(stackdir = "center",binaxis = "y",binwidth = 0.01)
  
})
#lineplot
output$lineplottt <- renderText({
  req(input$file1)
  "lineplot"
})
output$lineplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_line()
})
#barplot
output$barplottt <- renderText({
  req(input$file1)
  "barplot"
})
output$barplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_bar(stat = "identity",position = "stack")
})
#
output$stackedbarplottt <- renderText({
  req(input$file1)
  "stackedbarplot"
})
output$stackedbarplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_bar(position = "stack",stat = "identity")
})

#
output$densityplottt <- renderText({
  req(input$file1)
  "densityplot"
})
output$densityplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]]))+
    geom_density()
})
#
output$contourplottt <- renderText({
  req(input$file1)
  "contourplot"
})
output$contourplot <- plotly::renderPlotly({
  req(input$file1)
  req(input$selecty)
  df <- melt(csfile())
  p <- ggplot(df, aes(Var1, Var2, z= value)) +
    geom_contour() +
    scale_fill_distiller(palette = "Spectral", direction = -1)
  p
})
#
output$areaplottt <- renderText({
  req(input$file1)
  "areaplot"
})
output$areaplot <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(data = csfile(),mapping = aes(x = csfile()[[input$selectx]],y = csfile()[[input$selecty]]))+
    geom_area(fill = "blue")
})
#
output$piecharttt <- renderText({
  req(input$file1)
  "piechart"
})
output$piechart <- renderPlot({
  req(input$file1)
  req(input$selecty)
  ggplot(iris,aes(x = "",y = csfile()[[input$selecty]]))+
    geom_bar(stat = "identity",width = 1)+
    coord_polar(theta = "y")
})

#
output$memo <- renderUI({
  req(input$file1)
  h4("memo")
  p("アップロードしたファイルによっては描画できない場合あり。")
})