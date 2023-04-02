renderdtoptionsui <-
  fluidPage(
    title = "render DT options",
    wellPanel(p("renderDT のオプションを試す場所。設定できたらその説明とコードを掲載。
                オプションの例が後で見返せるように。")),
    div(
      sidebarPanel(
        p("stateRestore.saveState"),
        p("ユーザーがページを移動しても、移動前の選択・並び替えの状態を保つことができる"),
        p("ナビゲーションページバーで移動→戻ってきても変わらない?"),
        div(class = "diwjfi",
            tags$code("DT::renderDataTable(datatable(iris,
                                                 options = list(
                                                                stateSave = TRUE,
                                                                stateDuration = -1, 
                                                                stateRestore = TRUE))
                                       )"))
      ),
      mainPanel(dataTableOutput(outputId = "table1"))
    ),
    div(
      sidebarPanel(
        p("stateRestore.splitSecondaries"),
        p("グループ化されたヘッダーを認識するらしい"),
        tags$code("")
      ),
      mainPanel(dataTableOutput(outputId = "table2"))
    ),
    div(
      sidebarPanel(
        p("stateRestore.toggle"),
        p(""),
        tags$code("")
      ),
      mainPanel(dataTableOutput(outputId = "table3"))
    ),
    div(
      sidebarPanel(
        p("#AutoFill"),
        p("autofill"),
        p("editable row_selectableと併用する セルが編集可能な状態"),
        tags$code(" renderDataTable(datatable(iris,
                                             filter = 'top',
                                             editable = TRUE,
                                             selection =  'none',
                                             options = list(alwaysAsk = TRUE)))")
      ),
      mainPanel(dataTableOutput(outputId = "table4"))
    ),
    div(
      sidebarPanel(
        p("#autofill"),
        p("autoFill.alwaysAsk"),
        tags$code()
      ),
      mainPanel(dataTableOutput(outputId = "table5"))
    ),
    div(
      sidebarPanel(
        p("#autofill"),
        p("autoFill.columns"),
        tags$code("")
      ),
      mainPanel(dataTableOutput(outputId = "table6"))
    ),
    div(
      sidebarPanel(
        p("#autofill"),
        p("autoFill.horizontal"),
        tags$code("")
      ),
      mainPanel(dataTableOutput(outputId = "table7"))
    ),
    div(
      sidebarPanel(
        p("pageLength"),
        p("初期の表示件数を設定"),
        tags$code("renderDataTable(iris,options = list(pageLength = 50))")
      ),
      mainPanel(dataTableOutput(outputId = "table8"))
    ),
    div(
      sidebarPanel(
        p("keys.clipboardOrthogonal"),
        tags$code("")
      ),
      mainPanel(dataTableOutput(outputId = "table9"))
    )
  )