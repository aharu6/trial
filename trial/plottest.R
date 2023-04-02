#line
#dotplot
iris3  <- read.csv("/Users/aizawaharuka/Downloads/iris.csv")
  ggplot(data = iris3,mapping = aes(x = variety,y = sepal.width))+
    geom_dotplot(stackdir = "center",binaxis = "y",binwidth = 0.2)

  ggplot(data = iris,mapping = aes(x = Sepal.Length,y = Sepal.Width))+
    geom_line()

  #stack bar
  ggplot(data = iris,mapping = aes(x = Species,y = Sepal.Width))+
    geom_bar(position = "stack",stat = "identity")
  
  #dencityplot
  ggplot(data = iris3,mapping = aes(x= variety))+
    geom_density()
  library(plotly)
  needs(reshape2)
  df <- melt(volcano)
  
  p <- ggplot(df, aes(Var1, Var2, z= value)) +
    geom_contour() +
    scale_fill_distiller(palette = "Spectral", direction = -1)
  p
  ggplotly(p)
  
  #areaplot
  ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width))+
    geom_area(fill = "red")
  
  #piechart
  ggplot(iris,aes(x = "",y = Species))+
    geom_bar(stat = "identity",width = 1)+
    coord_polar(theta = "y")
  #volcanoplot
  mtcars
  #前のがエラー  
  