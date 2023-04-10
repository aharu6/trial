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
output$clctrldwn <- downloadHandler({
  
})
#選択した項目ごとの操作
output$cleantable1 <- renderUI({
  req(input$dataupload)
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
  req(input$dataupload)
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
  req(input$dataupload)
  req(input$clsentaku == "列を除去する")
  sliderInput(inputId = "colrange",min = 1,max = ncol(clfile()),value = c(2,3),label = "表示範囲を選択")
})
output$cleantable4 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "列を除去する")
  req(input$colrange)
  renderTable(clfile()[,input$colrange[1]:input$colrange[2]])
})
output$cleantable5 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "行を削除する")
  sliderInput(inputId = "rowrange",min = 1,max = nrow(clfile()),value = c(2,3),label = "表示範囲を選択")
})
output$cleantable6 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "行を削除する")
  req(input$rowrange)
  renderTable(clfile()[input$rowrange[1]:input$rowrange[2],])
  })
output$cleantable7_1 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "右に別ファイルを結合する")
  selectInput(inputId = "clinput7",label = "ファイル種類を選択",choices = list("csv","xlsx"))
})
  
output$cleantable7 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "右に別ファイルを結合する")
  fileInput(inputId = "yketsugou",label = "結合する行数は元のファイルに依存します。",buttonLabel = "Browse",placeholder = "ファイルをアップロード")
})
output$cleantable8 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "右に別ファイルを結合する")
  req(input$yketsugou)
  req(input$clinput7 == "csv")
  read.csv(input$yketsugou$datapath,
           header = TRUE,
           sep = ",",
           quote = '"') ->ykcsv_0
  ykcsv_0->ykcsv
  ykdt <- bind_cols(as.data.frame(clfile()),as.data.frame(ykcsv))
  renderTable(ykdt)
})
output$cleantable8 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "右に別ファイルを結合する")
  req(input$yketsugou)
  req(input$clinput7 == "xlsx")
  readxl::read_excel(input$yketsugou$datapath)->ykcsv_0
  ykcsv_0[nrow(clfile()),]->ykcsv
  ykdt <- bind_cols(as.data.frame(clfile()),as.data.frame(ykcsv))
  renderTable(ykdt)
  })

output$cleantable9_1 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "下に別ファイルを結合する")
  selectInput(inputId = "clinput9",label = "ファイル種類を選択",choices = list("csv","xlsx"))
})
output$cleantable9 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "下に別ファイルを結合する")
  fileInput(inputId = "tketsugou",label = "結合する列数は元のファイルに依存します。",buttonLabel = "Browse",placeholder = "ファイルをアップロード")
})

output$cleantable10 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "下に別ファイルを結合する")
  req(input$tketsugou)
  req(input$clinput9 == "csv")
  read.csv(input$tketsugou$datapath,
           header = TRUE,
           sep = ",",
           quote = '"') ->tkcsv_0
  tkcsv_0->tkcsv
  tkdt <- bind_rows(as.data.frame(clfile()),as.data.frame(tkcsv))
  renderTable(tkdt)
})
output$cleantable10 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "下に別ファイルを結合する")
  req(input$tketsugou)
  req(input$clinput9 == "xlsx")
  readxl::read_excel(input$tketsugou$datapath)->tkcsv_0
  tkcsv_0[,ncol(clfile())]->tkcsv
  tkdt <- bind_rows(as.data.frame(clfile()),as.data.frame(tkcsv))
  renderTable(tkdt)
  })
#downloadbottun
output$dw1 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku =="記号の削除")
  downloadButton(outputId = "cldtdown1",icon = icon("download"))
})
output$cldtdown1 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(replacedt,file,
              fileEncoding = "CP932")
  }
)
output$dw2 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku =="全角を半角に")
  downloadButton(outputId = "cldtdown2",icon = icon("download"))
})
output$cldtdown2 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(rpzenkaku,file,
              fileEncoding = "CP932")
  }
)
output$dw3 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "列を除去する")
  downloadButton(outputId = "cldtdown3",icon = icon("download"))
})
output$cldtdown3 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(clfile()[,input$colrange[1]:input$colrange[2]],
              file,
              fileEncoding = "CP932")
  }
)
output$dw4 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "行を削除する")
  downloadButton(outputId = "cldtdown4",icon = icon("download"))
})
output$cldtdown4 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(clfile()[input$rowrange[1]:input$rowrange[2],],
              file,
              fileEncoding = "CP932")
  }
)
output$dw5 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "右に別ファイルを結合する")
  downloadButton(outputId = "cldtdown5",icon = icon("download"))
})
output$cldtdown5 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(ykdt,
              file,
              fileEncoding = "CP932")
  }
)
output$dw6 <- renderUI({
  req(input$dataupload)
  req(input$clsentaku == "下に別ファイルを結合する")
  req(input$tketsugou)
  downloadButton(outputId = "cldtdown6",icon = icon("download"))
})
output$cldtdown6 <- downloadHandler(
  filename = function(){
    paste("cleandata",Sys.Date(),".csv",sep = "")
  },
  content = function(file){
    s <- input$clctrl_rows_all
    write.csv(tkcsv,
              file,
              fileEncoding = "CP932")
  }
)