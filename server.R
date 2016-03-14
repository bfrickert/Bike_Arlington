library(shiny)
library(XML)
library(plyr)
library(dplyr)
library(forecast)
library(lubridate)

shinyServer(function(input, output) {
  getReal.Data <- reactive({
      x <- input$sensor
      url <- paste('http://webservices.commuterpage.com/counters.cfc?wsdl&method=GetCountInDateRange&counterid=', x, '&startDate=01/01/2005&endDate=12/31/2019&direction=&mode=B&interval=d',sep='')
      doc <- xmlTreeParse(url, useInternal=T)
      top <- xmlRoot(doc)
      df <- data.frame(matrix(unlist(xmlApply(top, xmlAttrs)), ncol=4, byrow=T),stringsAsFactors = F)
      names(df) <- c('cnt','date','direction', 'type')
      df$cnt <- as.integer(df$cnt)
      df$Date <- as.Date(df$date, "%m/%d/%Y")
      df2 <- as.data.frame(dplyr::summarise(group_by(select(df, Date, cnt),Date),count = sum(cnt)))
      
      return(df2)
  })
  getData <- reactive({
    df <- getReal.Data()
    t <- ts(as.integer(df$count), start=c(2012, 11), end=c(2016, 3), frequency=12)
    return(t)
  })
  getTrain <- reactive({
    train <- window(getData(),end=c(2015,7))
    return(train)
  })
  getTest <- reactive({
    test <- window(getData(),start=c(2015,7))
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
 output$actual.data <- renderPlotly({
   df <- getReal.Data()
   p <- plot_ly(df, x = Date, y = count) %>%
     layout(              
       title = "Daily Bicycle Counts", 
       xaxis = list(           
         title = "Date",     
         showgrid = F        
       ),
       yaxis = list(           
         title = "Bicycle Count"
       )
     )
   p
 })
 output$busiest <- renderPlotly({
   df.busy <- getReal.Data()
   df.busy$month <- month(as.POSIXlt(df.busy$Date))
   df.busy <- as.data.frame(dplyr::summarise(group_by(df.busy, month), 
                                             mean.count=mean(count), median.count=median(count)))
   df.busy$month.name <- month.abb[df.busy$month]
   df.busy <- dplyr::select(df.busy, month.name, mean.count, median.count)
   p <- plot_ly(df.busy, x=factor(month.name), y=median.count, type='bar',
                mode='marker', 
                text = paste("Mean bicycle count: ", round(mean.count,2))) %>%
     layout(              
            title = "Median Bicycle Counts per Month", 
            xaxis = list(           
              title = "Month",     
              showgrid = F        
            ),
            yaxis = list(           
              title = "Median Bicycle Counts"
            )
     )
   p
  })
 
 output$distribution <- renderPlotly({
   set.seed(666)
   df2 <- getReal.Data()
   smp <- sapply(seq(1,20000), function(x) {mean(sample(df2$count,100, replace=T))})
   plot_ly(x=smp, type='histogram')
 })
 output$median.mean <- renderUI({
   HTML(paste("The median number of bicyclists per day is <strong>", median(getReal.Data()$count), 
              '</strong> and the mean is <strong>', 
              round(mean(getReal.Data()$count), 2), '</strong>.',sep=''))
   
 })
 output$mean <- renderUI({
   HTML(paste("The mean number of bicyclists per day is <strong>", round(mean(getReal.Data()$count),2), '</strong>.',sep=''))
   
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
