library(shiny)
shinyUI(
  pageWithSidebar(
    headerPanel("Air Quality in New York"),
    sidebarPanel(
      selectInput(inputId = "measurement", label = "Choose measurements to be shown", 
                  choices = c("Ozone Level", "Solar Radiation", "Wind Speed", 
                              "Maximum Temperature"), selected = "Ozone Level"
                  ),
      radioButtons(inputId = "month", label = "Pick a month", 
                   choices = c("May" = 5, "June" = 6, "July" = 7,
                               "August" = 8, "September" = 9))
      
      ),
    mainPanel(
      plotOutput("time.series"),
      h5(textOutput("caption"), align = "center"),
      textOutput("min"),
      textOutput("max")
    )
  )
)