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
output$cleantable1 <- renderUI({
  req(input$clsentaku =="記号の削除")
  kigou <- c("\\+","-","\\*","/","%","=",">","<","!","#","$","&","'","\\(","\\)","~","^","¥","|","@","`","\\[","\\]","\\{","\\}",";",":","・","_")
  clfile() -> replacedt
  for (b in 1:length(kigou)) {
    ifelse(grepl(pattern = b,replacedt),
           replacedt%>% mutate_all(~str_replace_all(.,"-","")) -> replacedt,
           replacedt->replacedt)
  }
  renderTable(replacedt)
})  
output$cleantable2 <- renderUI({
  req(input$clsentaku =="全角を半角に")
  zenkaku <- c("０","１","２","３","４","５","６","７","８","９","Ａ","Ｂ","Ｃ","Ｄ","Ｅ","Ｆ","Ｇ","Ｈ","Ｉ","Ｊ","Ｋ","Ｌ","Ｍ","Ｎ","Ｏ","Ｐ","Ｑ","Ｒ","Ｓ","Ｔ","Ｕ","Ｖ","Ｗ","Ｘ","Ｙ","Ｚ","ａ","ｂ","ｃ","ｄ","ｅ","ｆ","ｇ","ｈ","ｉ","ｊ","ｋ","ｌ","ｍ","ｎ","ｏ","ｐ","ｑ","ｒ","ｓ","ｔ","ｕ","ｖ","ｗ","ｘ","ｙ","ｚ")
  clfile() -> rpzenkaku
  for (c in 1:length(zenkaku)) {
    ifelse(grepl(pattern = c,rpzenkaku),
           rpzenkaku%>% mutate_all(~str_replace_all(.,"-","")) -> rpzenkaku,
           rpzenkaku->rpzenkaku)
  }
  renderTable(rpzenkaku)
})
output$cleantable3 <- renderUI({
  req(input$clsentaku == "列を除去する")
  sliderInput(inputId = "colrange",min = 1,max = ncol(clfile()),value = 2,label = "表示範囲を選択")
})
output$cleantable4 <- renderUI({
  renderTable(clfile()[,1:input$colrange])
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