library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("You know you want to Forecast Bike Trail Usage in Arlington, VA!"),
  
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
      tags$h3("Executive Summary"),
      tags$h5("The graphs and table below perform a simple forecast of future bike 
trail usage in 
              Arlington County, VA. Upon selecting a bike trail to the left, 
              you'll see 
              an STL (Seasonal and Trend decomposition using Loess) 
              model forecast the future."),
      tags$br(),
      tags$h5("The way it works is that for each trail, sensor readings 
              from late 2012 to the end of 2014 are fed into the model. 
              The model then evaluates itself against data for
              bike trail usage so far in 2015. The forecast is then plotted,
              along with a decomposition of the time series. At the very bottom, 
              the accuracy of each trail's forecast is reported."),
      tags$br(),
      tags$h5("So go ahead and pick your favorite trail!"),
      tags$br(),
      tags$h5("Data from:"),
      tags$a(href='http://www.bikearlington.com/pages/biking-in-arlington/counting-bikes-to-plan-for-bikes/data-for-developers/',
             "Data for Developers"),
      tags$br(),
      tags$hr(),
      tags$h3("Location of selected sensor"),
      leafletOutput("mymap"),
      tags$br(),
      tags$hr(),
      tags$h3("Forecast"),
      tags$h5("This plot helps compare the model's forecast against a 
              test set of bicycle sensor readings
              from 2015. You can see whether the actual count of bicyclists for a given month in
              2015 falls within the forecast's confidence interval."),
      plotOutput("forecastPlot"),
      tags$hr(),
      tags$h3("Decomposition of Training Time Series"),
      tags$h5("The following four graphs feature the training data observations, the seasonal 
component of the data, 
              the trend component, and the 
              error. There is a bar 
              at the right hand side of each graph to allow a 
              relative comparison of the magnitudes of each 
              component."),
      plotOutput("otherPlot"),
      tags$hr(),
      tags$h3("Accuracy forecasting 2015 bike trail usage"),
      tags$h5("Here you'll find a range of summary measures for the forecast's accuracy."),
      tableOutput("accuracy")
    )
  )
))