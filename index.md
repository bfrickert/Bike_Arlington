---
title       : Bicycle Forecasting in Arlington, Virginia
subtitle    : See what horrors the future holds...
author      : Brian Frickert
job         : Senior Data Over-Engineer
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---


## Slide 1

Are bicyclists making full use of Arlington's bike trails?

--- .class #id 

## Slide 2


```r
library(leaflet)
m <- leaflet()
   m <- addTiles(m)
   m <- addMarkers(m, lng='38.857702', lat='38.857702', popup='CC Connector')
   m
```

<!--html_preserve--><div id="htmlwidget-1152" style="width:504px;height:504px;" class="leaflet"></div>
<script type="application/json" data-for="htmlwidget-1152">{"x":{"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"maxNativeZoom":null,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"continuousWorld":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>"}]},{"method":"addMarkers","args":["38.857702","38.857702",null,null,null,{"clickable":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"CC Connector",null,null,null,null]}],"limits":{"lat":[1,1],"lng":[1,1]}},"evals":[]}</script><!--/html_preserve-->

---

## Slide 3


    

```r
    fcast <- forecast(fit, method="ets")
    plot(fcast, ylab="Bicyclist Count")
    lines(test, col='red')
```

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3-1.png) 

---

## Slide 4

