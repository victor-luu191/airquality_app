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
1. __Colorful plots__ of air quality measurements in New York city, May to September 1973. The measurements include:
  
  a. _Mean ground Ozone level_
  
  b. _Solar radiation_
  
  c. _Mean wind speed_ and _maximum daily temperature_

2. __Summaries__  of data per month.
3. __Detailed, searchable table__ showing data for each month
3. __Boxplots__ for quick and easy comparison air quality over the months. 
4. __Easy daily data__ lookup.

--- 

##  Data
`airquality` data set, available in `R` package `datasets`. 

```
## [1] "Number of observations: 153"
```

```
## [1] "Number of measurements (aka variables) 6"
```

Variable names:

```
## [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"
```

---

## More on variables

1. Ozone: ozone at ground level, numeric values, in __ppb__ unit.
2. Solar.R: solar radiation, numeric values, in __lang__ unit.
3. Wind: wind speed,  numeric values, in __mph__.
4. Temp: maximum temperature daily, numeric values, in __F__ degree. 
5. Month: in range [5, 12].
6. Day: in range [1, 31].

Detailed description on the data set can be found by running `help("airquality")` at `R` console. 

---

## Why do you need this?

1. The plots __visualize__ dynamics of different air quality measurements to give you a clear picture of data. 
2. In summaries and tables, NAs are shown clearly as __"Not Available"__.
3. In plots, measurements are shown with __distinguishable__ and __memorable__ colors.
4. __Help documentation__ is available for your quick start.

---


