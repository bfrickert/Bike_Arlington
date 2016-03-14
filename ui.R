library(shiny)
library(leaflet)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Forecast Bike Trail Usage in Arlington, Va."),
  
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
      tags$h3("Arlington Bike Trail and Bike Lane Data Visualizations and Forecast"),
      tags$h5("To the left are the names of bike trails in Arlington County, Va. Each has
              a sensor that tallies the number of bicycles using the trail on any given day. Below you will
              find time series representations of the daily traffic on each selected trail along
              with each trail's median daily traffic broken down by month."),
      tags$br(),
      HTML("<h5>Beneath those graphs is a seasonally adjusted representation of the same
              data. <i>Seasonally adjusted</i> means that any data that can be attributed
           to seasonal trends has been removed, leaving only that number of bicycles that
           cannot be attributed to seasonal traffic (so far as the model can identify). This
           probably makes the most sense when looking at the <strong>Bluemont Connector</strong> trail.
           The model tells us that there is no bicycle traffic on this trail that cannot be
          explained by the seasonal and overall trends detected from the sensor data.</h5>"),
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
      plotlyOutput('actual.data'),
      tags$br(),
      uiOutput('median.mean'),
      tags$br(),
      #plotlyOutput('distribution'),
      tags$br(),
      plotlyOutput('busiest'),
      tags$h3("Seasonally Adjusted Data"),
      tags$h5("If the count of bikes that can be attributed to the seasonal and overall
trends is removed, you wind up with the line graph below. It displays the monthly bike counts
that the model can't explain from trends and tries to forecast what future seasonally adjusted
bike trail usage will be. This forescast (in blue with gray confidence intervals) can then be 
compared to actual seasonally adjusted data (in red) that was left out of the model. It gives a 
visual sense of how well the model forecasts. 
              "),
      plotOutput("forecastPlot"),
      tags$hr(),
      tags$h3("Decomposition of Training Time Series"),
      tags$h5("The following four graphs feature the seasonally adjusted data observations, the seasonal 
component of the data, 
              the overal trend component, and the in-sample
              residuals. There is a bar 
              at the right hand side of each graph to allow a 
              relative comparison of the magnitudes of each 
              component."),
      plotOutput("otherPlot"),
      tags$hr(),
      tags$h3("Accuracy forecasting bike trail usage"),
      HTML("<h5>Here you'll find a range of summary measures for the forecast's accuracy. The 
              <i>Training Set's</i> accuracy refers to the errors that were detected in creating the 
           model. Essentially those counts, the model can't explain. The <i>Test Set's</i> accuracy
           measures how well the forecast performs when cross-validated against data that was left out 
           of the model and was seasonally adjusted."),
      tableOutput("accuracy")
    )
  )
))