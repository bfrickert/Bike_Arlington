---
title       : Bicycle Forecasting in Arlington, Virginia
subtitle    : Look into the future of bike trails
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

![screen shot](screenshot.png)

---

## Slide 3


    

```r
    fcast <- forecast(fit, method="ets")
    plot(fcast, ylab="Bicyclist Count")
    lines(test, col='red')
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 

---

## Slide 4

