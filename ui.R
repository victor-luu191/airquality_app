library(shiny)

shinyUI(
  fluidPage(
    h1("Air Quality in New York in 1973", align = "center"),
    fluidRow(
      column(3,
             h5("Monthly data"),
             selectInput(inputId = "measurement", label = "Choose a measurement for display", 
                         choices = c("Ozone Level", "Solar Radiation", "Wind Speed", 
                                     "Maximum Temperature"), selected = "Ozone Level"
             ),
             radioButtons(inputId = "month", label = "Pick a month", 
                          choices = c("May" = 5, "June" = 6, "July" = 7,
                                      "August" = 8, "September" = 9)
             )
      ),
      column(9,
             tabsetPanel(
                tabPanel("Plot", plotOutput("time.series")),
                tabPanel("Summary", verbatimTextOutput("summary")),
                tabPanel("Table", dataTableOutput("table")),
                tabPanel("Comparison", plotOutput("comparison")),
                tabPanel("Help", includeMarkdown("help.md")
                         
                )
             )
      )
    ),
    
    hr(),
    
    fluidRow(
      column(3,
             h5("Daily data"),
             dateInput(inputId = "date", label = "Select a date", 
                       value = "1973-05-01", 
                       min = "1973-05-01", max = "1973-09-30"
                       ),
             actionButton(inputId = "go", label = "Get data")
             ),
      
      column(9,
             tableOutput("daily.data"),
             helpText("Units: Ozone (ppb), Solar Radiation (lang), 
                      Wind Speed (mph), Maximum Temperature (F)")
             )
    )
  )
)

