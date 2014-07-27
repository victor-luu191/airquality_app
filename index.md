---
title       : Air Quality App
subtitle    : Exploring Air Quality in New York
author      : Duc Luu
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## What is in this app?
1. __Plots__ of air quality measurements in New York city, May to September 1973. The measurements include:
  
  a. _Mean ground Ozone level_  at Roosevelt Island
  
  b. _Solar radiation_ at Central Park
  
  c. _Mean wind speed_ and _maximum daily temperature_ at La Guardia Airport

2. __Summaries__  of data per month.  
3. __Boxplots__ for quick comparison air quality over the months.
4. __Daily data lookup__.

--- 

## _Airquality_  data set
The data set is available in `R` package `datasets`. It contains 154 observations on 6 variables.

1. Ozone: ozone at ground level, numeric values, in __ppb__ unit.
2. Solar.R: solar radiation, numeric values, in __lang__ unit.
3. Wind: wind speed,  numeric values, in __mph__.
4. Temp: maximum temperature daily, numeric values, in __F__ degree. 
5. Month: in range [5, 12].
6. Day: in range [1, 31].

---

## How to use this app?
You can look up data either monthly or daily.

_Monthly data_

1. Choose a measurement and a month you want to see 
2. Among four tabs on the right:

  i) `Plot` shows you dynamic of the measurement in that month
  
  ii) `Summary` provides a summary (of course) for that month
  
  iii) `Table` shows full table of all days in that month
  
  iv) `Comparison` provides a box plot to compare all months from May to September 

_Daily data_

Just choose a date, hit `Get data` and there you are!

