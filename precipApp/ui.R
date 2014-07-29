library(shiny)
library(IDEMdata)

data(wide_precip)

stations <- unique(wide.precip.df$station[!is.na(wide.precip.df$station)])

data(substance_names)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Sidebar with a slider input for the number of bins
  verticalLayout(
    sidebarPanel(
      selectInput("station",
                  "Station:", 
                  stations),
      
      selectInput("name",
                  "Sample:", 
                  substance_names)
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("precipPlot")
    )
  )
))
