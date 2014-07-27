library(shiny)

data(airquality)
names(airquality)[2] <- "Solar_Radiation"
mm <- paste0("0", airquality$Month)
dd <- ifelse(airquality$Day < 10, paste0("0", airquality$Day), 
                          airquality$Day)
airquality$date <- paste("1973", mm, dd, sep = "-")

getCaption <- function() {
  ozone <- "Ozone level at Roosevelt Island, 1PM to 3PM daily"
  solar <- "Solar radiation (in frequency band 4000–7700 Angstroms) at Central Park, 8AM to 12PM daily"
  wind <- "Average wind speed at LaGuardia Airport, 7AM to 10AM daily"
  temp <- "Maximum temperature  daily at La Guardia Airport"
  list(ozone = ozone, solar = solar, wind = wind, temp = temp)
}
caption <- getCaption()

shinyServer(
  function(input, output) {
    measurement.choice <- reactive({switch(input$measurement, 
                                           "Ozone Level" = "Ozone",
                                           "Solar Radiation" = "Solar_Radiation",
                                           "Wind Speed" = "Wind",
                                           "Maximum Temperature" = "Temp")
                                    })
    
    yLabel <- reactive({switch(input$measurement, 
                               "Ozone Level" = "Mean Ozone concentration (ppb)",
                               "Solar Radiation" = "Solar radiation (lang)",
                               "Wind Speed" = "Average wind speed (mph)",
                               "Maximum Temperature" = "Maximum daily temperature (F)")})
    
    color <- reactive({switch(input$measurement,
                              "Ozone Level" = "blue",
                              "Solar Radiation" = "orange",
                              "Wind Speed" = "green",
                              "Maximum Temperature" = "red")})
    
    month.ds <- reactive({subset(airquality, Month == input$month)})
    tmp.ds <- reactive({data.frame("day" = month.ds()$Day, 
                                   "measurement" = switch(input$measurement, 
                                                          "Ozone Level" = month.ds()$Ozone,
                                                          "Solar Radiation" = month.ds()$Solar_Radiation,
                                                          "Wind Speed" = month.ds()$Wind,
                                                          "Maximum Temperature" = month.ds()$Temp))
                        })
    # remove NA's
    valid.ds <- reactive({tmp.ds()[ !is.na(tmp.ds()$measurement), ]})
    
    output$time.series <- renderPlot({with(valid.ds(), plot(x = day, 
                                                            y = measurement,
                                                            type = "l",
                                                            xlab = "Day", 
                                                            ylab = yLabel(),
                                                            col = color(),
                                                            main = switch(input$measurement, 
                                                                          "Ozone Level" = caption$ozone,
                                                                          "Solar Radiation" = caption$solar,
                                                                          "Wind Speed" = caption$wind,
                                                                          "Maximum Temperature" = caption$temp)
                                                            )
                                           )
                                      })
    output$summary <- renderPrint({
      summary(month.ds())[ ,1:4]
    })
    output$table <- renderDataTable({
      res <- data.frame("Day" = tmp.ds()$day)
      res$measurement <- ifelse(is.na(tmp.ds()$measurement), "Not Available",
                                     tmp.ds()$measurement)
      
      names(res) <- c("Day", measurement.choice())
      res
    })
    
    compare.ds <- reactive({
      res <- subset(airquality, select = c("Month", measurement.choice()))
      names(res) <- c("Month", "Measurement")
      res
    })
    output$comparison <- renderPlot({
      boxplot(Measurement ~ Month, data = compare.ds(), 
              xlab = "Month", ylab = yLabel(), col = color()
              )
    })
    
    output$daily.data <- renderTable({
      input$go
      isolate({
        tmp <- subset(airquality, date == as.character(input$date))
        res <- tmp[, 1:4]
        res[1, ] <- ifelse(is.na(res[1, ]), "NA", res[1, ])
        names(res) <- c("OzoneLvl", "SolarRadiation", "WindSpeed", "MaxTemp")
        res
      })
    })
  })
