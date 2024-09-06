#Northumberland Water Quality Simple Shiny App
#Call library(shiny) to load the shiny package.
library(shiny)
library(tidyverse)

Data <- readRDS(file.path("ProcessedData","KouchShediacParleeData.Rds")) 

#implement rules on which variables are available for which selections
#https://shiny.rstudio.com/reference/shiny/1.6.0/varSelectInput.html

ui <- fluidPage(
  titlePanel("WQ Data Exploration"),
  varSelectInput("XVar", label = "Select Variable for X Axis", Data, selected = "Measurement_Date"),
  varSelectInput("YVar", label = "Select Variable for Y Axis", Data, selected = "Bacterial_Count_MPN"),
  #varSelectInput("ColourVar", label = "Select Variable for Symbol Colour", Data, selected = "CharacteristicName"),
  
  #selectInput("RowVar", label =  "Select Variable for Facet Rows", Data |> select(MonitoringLocationName)),
  #varSelectInput("RowVar", label =  "Select Variable for Facet Rows", Data),
  #selectInput("ColVar", label = "Select Variable for Facet Columns", choices =  colnames(Data), ""),
  #selectInput("MyVar", label = "Select MyVar", choices =  c("Bob", "Sally", "Mgumi")),
  
  plotOutput("plot", width = "1000px")
)


# ui <- fluidPage(
#   titlePanel("XY Data Exploration"),
#   varSelectInput("XVar", label = "Select Variable for X Axis", Data),
#   varSelectInput("XVar", label = "Select Variable for Y Axis", Data),
#   varSelectInput("ColourVar", label = "Select Variable for Symbol Colour", Data),
#   #selectInput("RowVar", label =  "Select Variable for Facet Rows", choices =  colnames(Data), ""),
#   varSelectInput("RowVar", label =  "Select Variable for Facet Rows", Data),
#   selectInput("ColVar", label = "Select Variable for Facet Columns", choices =  colnames(Data), ""),
#   selectInput("MyVar", label = "Select MyVar", choices =  c("Bob", "Sally", "Mgumi")),
#   
#   plotOutput("plot", width = "400px")
# )

#Specify the behaviour of the app by defining a server function.
DataFiltered <- Data %>% 
  filter(!is.na(MonitoringLocationName))

#remember !! to bring in values of external variables for plotting; 'sym' needed with 'selectInput', but not with varSelectInput
server <- function(input, output, session) {
  output$plot <- renderPlot({
      ggplot(DataFiltered) + 
      geom_point(aes(x = !!input$XVar, y = !!input$YVar, colour = ResultValueColour), data = . %>% filter(!!input$YVar < 5000)) +
      #geom_point(aes(x = !!input$XVar, y = !!input$YVar, shape = ResultValueShape, colour = !!input$ColourVar), data = . %>% filter(!!input$YVar < 5000)) +
      scale_y_continuous(trans='log10') +
      annotation_logticks(sides = "l", colour = "gray60") +
      #geom_smooth(aes(x = !!input$XVar, y = !!input$YVar, colour = !!input$ColourVar), method = "lm") +
      geom_text(aes(x = !!input$XVar, y = 5000, label = "*"), data = . %>% filter(!!input$YVar > 5000)) +
      geom_hline(yintercept = 200, linetype='dotted', col = 'red') +
      geom_hline(yintercept = 50, linetype='dotted', col = 'blue') +
      #geom_hline(yintercept = 400, linetype='dotted', col = 'red') +
      #geom_hline(yintercept = 200, linetype='dotted', col = 'blue') +
      #scale_shape_identity() +
      scale_colour_identity() +
      theme_bw() +
      facet_grid(rows = vars(MonitoringLocationNameStrip))#, cols =  vars(!!sym(input$ColVar))) 
     #facet_grid(rows = vars(!!sym(input$RowVar)), cols =  vars(!!sym(input$ColVar)))
  }, res = 96)
}

#geom_text(aes(x = !!input$XVar, y = 1000, label = "*"), data = . %>% filter(!!input$YVar > 5000)) +
#Execute shinyApp(ui, server) to construct and start a Shiny application from UI and server.
shinyApp(ui, server)