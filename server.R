library(shiny)
library(XML)
library(plyr)
library(dplyr)
library(forecast)

shinyServer(function(input, output) {
  getData <- reactive({
    url <- paste('http://webservices.commuterpage.com/counters.cfc?wsdl&method=GetCountInDateRange&counterid=', input$sensor, '&startDate=01/01/2005&endDate=10/31/2015&direction=&mode=B&interval=d',sep='')
    doc <- xmlTreeParse(url, useInternal=T)
    top <- xmlRoot(doc)
    df <- data.frame(matrix(unlist(xmlApply(top, xmlAttrs)), ncol=4, byrow=T),stringsAsFactors = F)
    names(df) <- c('count','date','direction', 'type')
    t <- ts(as.integer(df$count), start=c(2012, 11), end=c(2015, 9), frequency=12)
    return(t)
  })
  getTrain <- reactive({
    train <- window(getData(),end=c(2015,1))
    return(train)
  })
  getTest <- reactive({
    test <- window(getData(),start=c(2015,1))
return(test)
    })
  getFit <- reactive({  
      fit <- stl(getTrain(), t.window=12, s.window="periodic", robust=TRUE)
    return(fit)
  })
  output$otherPlot <- renderPlot({
      plot(getFit())
  })
  output$forecastPlot <- renderPlot({
    fcast <- forecast(getFit(), method="ets")
    plot(fcast, ylab="Bicyclist Count")
    lines(getTest(), col='red')
  })
 output$accuracy <- renderTable({
   fcast <- forecast(getFit(), method="ets")
   forecast::accuracy(fcast, getTest())
   })
 output$mymap <- renderLeaflet({
   df <- read.table('coordinates.tsv',sep='\t',stringsAsFactors = F)
   names(df) <- c('name', 'lat','lon','id')
   f <- filter(df, id == input$sensor)
   m <- leaflet()
   m <- addTiles(m)
   m <- addMarkers(m, lng=f$lon, lat=f$lat, popup=f$name)
   m
 })
})
