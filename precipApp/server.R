library(shiny)
library(IDEMdata)
library(lattice)
library(latticeExtra)

data(wide_precip)

# remove air_temp column
index.airtemp <- which(colnames(wide.precip.df) == "air_temp")
wide.precip.df <- wide.precip.df[, -index.airtemp]

# get substance columns
first.index <- which(colnames(wide.precip.df) == "sat")
last.index <- which(colnames(wide.precip.df) == "wind_strength")
samples <- colnames(wide.precip.df)[first.index:last.index]

data(substance_names)

# remove air temperature name
index.airtemp.name <- which(substance_names == "Air Temp (Lookup)")
substance_names <- substance_names[-index.airtemp.name]

# Define server logic required to draw a lattice graph
shinyServer(function(input, output) {

  # Expression that generates a conditioned lattice plot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot

  output$precipPlot <- renderPlot({
    sample.column <- samples[substance_names == input$name]
    
    prSubsetPlot(data = wide.precip.df, site = input$station, site.col = "station", 
                 date.col = "date", precip.col = "precipitation",  
                 sample.col = sample.column, sample.name = input$name, 
                 conditioned = "TRUE", save = FALSE)
  })

})


