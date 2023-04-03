#input$dataupload
#とりあえず、csvファイルだけにしてみる
clfile <- reactive({
  req(input$clinput)
  switch (input$clinput,
    "csv" = read.csv(input$dataupload$datapath,
                     header = TRUE,
                     sep = ",",
                     quote = '"') ->cldf,
    "xlsx" = readxl::read_excel(input$dataupload$datapath) -> cldf,
    "txt" = read.table(input$dataupload$datapath) -> cldf
  )
  return(cldf)
})

observeEvent(input$clinput,{
  output$table <- renderTable(head(csfile()))
})

observeEvent(input$dataupload,{
  output$cltable <- renderTable(head(clfile()))
  output$clsummary <- renderUI({HTML(summary(clfile()))})
})
#読み込んだテーブルの表示
output$clctrl <- renderUI({
  req(input$dataupload)
  renderDataTable(datatable(clfile(),filter = "top",options = list(pageLength = 50,
                                                                   autoFill = TRUE,
                                                                   responsive = TRUE,
                                                                   scrollX = TRUE,
                                                                   autoWidth = TRUE)))
})
#選択した項目ごとの操作
output$test <- renderUI({
  req(input$clsentaku == "記号の削除")
  renderTable(
    clfile()  %>% 
      mutate_all(~str_replace_all(.,"t","")) %>% 
      mutate_all(~str_replace_all(.,"s","A"))  
  )
})  

  
#downloadbottun
output$cldatadown <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(clfile()[s,],file,
              fileEncoding = "CP932")
  }
)