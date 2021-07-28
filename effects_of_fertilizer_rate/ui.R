library(shiny)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("lumen"),
  titlePanel("N2O Emissions"),
  sidebarLayout(
    sidebarPanel(
      mainPanel(
        
        sliderInput(inputId = "x", label = "Nitrogen Fertilizer (kg ha^-1)",
                    min = 0, max = 350, value = 300, step = 10,
                    animate = animationOptions(interval = 100)),
        HTML("Select Nitrogen Fertilizer rate")
      )
    ),
    
    # Output: Description, lineplot, and reference
    mainPanel(
      plotOutput(outputId = "lineplot", height = "300px"), 
      textOutput(outputId = "desc")
    )
  )
)

