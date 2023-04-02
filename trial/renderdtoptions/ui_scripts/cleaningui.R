cleaningTab <- 
  fluidPage(
    fileInput(inputId = "dataupload",label = "file upload",multiple = FALSE,width = 4,buttonLabel = "ファイルを選択",placeholder = "操作する元データをアップロードしてください"),
    tags$hr(),
    
  )