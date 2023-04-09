cleaningTab <- 
  fluidPage(
    selectInput(inputId = "clinput",label = "ファイル種類を選択",choices = list("csv","xlsx")),
    fileInput(inputId = "dataupload",label = p("file upload"),
              multiple = FALSE,placeholder = "操作する元データをアップロードしてください"),
    tags$hr(),
    h3("summary"),
    tableOutput(outputId = "cltable"),
    uiOutput(outputId = "clsummary"),
    h3("handling"),
    uiOutput(outputId =  "clctrl"),
    checkboxGroupInput(inputId = "clsentaku",label = "加えたい操作を選択してください",choices = list("記号の削除","全角を半角に","列を除去する","行を削除する","右に別ファイルを結合する","下に別ファイルを結合する")),
    uiOutput(outputId = "cleantable1"),
    uiOutput(outputId = "cleantable2"),
    uiOutput(outputId = "cleantable3"),
    uiOutput(outputId = "cleantable4"),
    uiOutput(outputId = "cleantable5"),
    uiOutput(outputId = "cleantable6"),  
    uiOutput(outputId = "cleantable7"),  
    uiOutput(outputId = "cleantable8"),
    downloadButton(outputId = "cldatadown",icon = icon("download")),
    p("削除対象の記号：\\+,-,\\*,/,%,=,>,<,!,#,$,&,',\\(,\\),~,^,¥,|,@,`,\\[,\\],\\{,\\},;,:,・,_")
  )