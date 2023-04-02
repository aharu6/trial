#stateRestore.saveState
output$table1 <- DT::renderDataTable(datatable(iris,
                                               options = list(
                                                 stateSave = TRUE,
                                                 stateDuration = -1, 
                                                 stateRestore = TRUE)))
#stateRestore.splitSecondaries
#ヘッダーのグループ化が必要
output$table2 <- DT::renderDataTable(datatable(iris,
                                               options = list(stateRestore = TRUE,
                                                              splitSecondaries = TRUE),
                                               colnames = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
                                               columns =list(
                                                 list(
                                                   list(title = "sepal",
                                                        colspan = 2),
                                                   list(1,2)
                                                 ),
                                                 list(
                                                   list(title= "petal",
                                                        colspan = 2),
                                                   list(3,4)
                                                 )
                                               )))
output$table3 <- renderDataTable(datatable(iris,
                                           options = list(stateRestore=TRUE,
                                                          creationModel = TRUE,
                                                          stateSave = TRUE,
                                                          toggle = TRUE,
                                                          stateSavecallback = JS('
                                                                                   function(setteings,data){
                                                                                    localStorage.setItem("myapp_datatable_state",JSON.stringify(data));
                                                                                    }'),
                                                          stateLoadCallback = JS('function(settings){
                                                                                   return JSON.parse(localStorage.getItem("myapp_datatable_state"));
                                                                                   }'),
                                                          stateRestore.toggle = TRUE)
))
output$table4 <- renderDataTable(datatable(iris,
                                           filter = 'top',
                                           editable = TRUE,
                                           row_selectable = TRUE,
                                           options = list(autoFill = TRUE)
))
output$table5 <- renderDataTable(datatable(iris,
                                           filter = 'top',
                                           editable = TRUE,
                                           selection =  "none",
                                           options = list(autofill = TRUE,alwaysAsk = TRUE)))
output$table6 <- renderDataTable(datatable(iris,
                                           editable = TRUE,
                                           selection = "none",
                                           options = list(autofill = TRUE,autofillColumns = c("Sepal.Length"," Sepal.Width")
                                           )))
output$table7 <- renderDataTable(iris,editable = TRUE,selection = "none",
                                 options = list(autofill =TRUE,autofillhorizontal = FALSE,autofillColumns = c("Sepal.Length"," Sepal.Width")))
output$table8 <- renderDataTable(iris,options = list(pageLength = 50))
output$table9 <- renderDataTable(datatable(iris,options = list(keys = TRUE,keys.clipboardOrthogonal = "export")))
