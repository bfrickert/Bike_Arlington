library(shiny)
if("leaflet" %in% rownames(installed.packages()) == FALSE) {install.packages("leaflet")}
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("You know you want to Forecast Bicycle Usage in Arlington, VA!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      tags$img(src="https://pbs.twimg.com/profile_images/463339101895159808/7bVLf-U2_400x400.jpeg",
               width="200px",height="200px"),
      radioButtons("sensor", "Sensor:",
                   c("Ballston Connector"="24",
                     "Bluemont Connector"="23",
                     "CC Connector"="10",
                     "Custis Bon Air Park" = "3",
                     "Custis Rosslyn" = "4",
                     "Clarendon EB bike lane"="20",
                     "Crystal NB bike lane"="18",
                     "Crystal SB bike lane"="17",
                     "Fairfax EB bike lane"="14",
                     "Fairfax WB bike lane"="13",
                     "Four Mile Run (piezo)"="5",
                     "Joyce St NB"="27",
                     "Joyce St SB"="26",
                     "Key Bridge East" ="8",
                     "Key Bridge West" = "7",
                     "Military NB bike lane" = "22",
                     "Military SB bike lane" = "21",
                     "MVT Airport South"="9",
                     "Quincy NB bike lane"="16",
                     "Quincy SB bike lane"="15",
                     "Rosslyn Bikeometer" = "28",
                     "TR Island Bridge"="11",
                     "W&OD Bon Air Park"="2",
                     "W&OD Bon Air West"="25",
                     "W&OD Columbia Pike"="12",
                     "W&OD East Falls Church"="1",
                     "Wilson WB bike lane"="19"
                     ))
    ),
    mainPanel(
      tags$h3("Synopsis"),
      tags$h5("The graphs and table below attempt to forecast future bike trail usage in 
              Arlington County, VA 
              by leveraging a STL (Seasonal and Trend decomposition using Loess) model 
              trained on data collected from sensors installed along Arlington's bike trails. 
              This training set is comprised of sensor readings 
              from late 2012 to the end of 2014. 
              The model is then evaluated against data for
              bike trail usage so far in 2015. That forecast is then plotted
              along with a decomposition of the training time series. At the very bottom, 
              the accuracy of each trail's forecast is reported."),
      tags$br(),
      tags$h5("So go ahead and pick your favorite trail!"),
      tags$br(),
      tags$h5("Data from:"),
      tags$a(href='http://www.bikearlington.com/pages/biking-in-arlington/counting-bikes-to-plan-for-bikes/data-for-developers/',
             "Data for Developers"),
      tags$br(),
      tags$hr(),
      tags$h3("Location of Sensor"),
      leafletOutput("mymap"),
      tags$br(),
      tags$h3("Forecast with Cross-Validation"),
      tags$h5(""),
      plotOutput("forecastPlot"),
      tags$h3("Trends"),
      plotOutput("otherPlot"),
      tags$h3("Accuracy"),
      tableOutput("accuracy")
    )
  )
))