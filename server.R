library(shiny)
library(ggplot2)
data(airquality)
# airquality$Month <<- paste0("0", airquality$Month)
# airquality$Day <<- ifelse(airquality$Day < 10, paste0("0", airquality$Day), 
#                           airquality$Day)
# airquality$date <<- paste("1973", airquality$Month, airquality$Day, 
#                           sep = "-")

getCaption <- function() {
  ozone <- "Ozone level measured at Roosevelt Island and averaged from 13:00 to 15:00 hours\n"
  solar <- "Solar radiation in Langleys in the frequency band 4000–7700 Angstroms from 08:00 to 12:00 hours at Central Park"
  wind <- "Wind speed measured at LaGuardia Airport and averaged from 07:00 to 10:00 hours"
  temp <- "Measured daily at La Guardia Airport"
  list(ozone = ozone, solar = solar, wind = wind, temp = temp)
}
caption <- getCaption()

shinyServer(
  function(input, output) {
    subdata <- reactive({subset(airquality, Month == input$month)})
    ds <- reactive({data.frame("day" = subdata()$Day, 
                               "measurement" = switch(input$measurement, 
                                                      "Ozone Level" = subdata()$Ozone,
                                                      "Solar Radiation" = subdata()$Solar.R,
                                                      "Wind Speed" = subdata()$Wind,
                                                      "Maximum Temperature" = subdata()$Temp))})
    
    valid.ds <- reactive({ds()[ !is.na(ds()$measurement), ]})
    
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
    
    output$time.series <- renderPlot(with(valid.ds(), plot(x = day, 
                                                           y = measurement,
                                                           type = "l",
                                                           xlab = "Day", 
                                                           ylab = yLabel(),
                                                           col = color())))
    output$caption <- reactive({switch(input$measurement, 
                                       "Ozone Level" = caption$ozone,
                                       "Solar Radiation" = caption$solar,
                                       "Wind Speed" = caption$wind,
                                       "Maximum Temperature" = caption$temp)})
    
    
    output$min <- reactive({
      paste("Min of", input$measurement, ":", min(valid.ds()$measurement))
    })
#     
    output$max <- reactive({
      paste("Max of", input$measurement, ":", max(valid.ds()$measurement))
    })   

    
  })
