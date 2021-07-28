# Load packages
library(tidyverse)
library(gridExtra)

source("theme_map.R")
source("emissions.R")
source("yield.R")

ymPlotDF <- read.csv(file.path("basswood_2020.csv")) %>%
  dplyr::mutate(wheatplot=yieldMgHaMean*0.9)%>%
  select(long, lat, group, wheatplot)%>%
  na.omit

g_yield<-ggplot(ymPlotDF) + # Omits 95 pixels without information
  geom_polygon(aes(
    x     = long,           # Longitudes in the horizontal axis
    y     = lat,            # Latitude in the vertical axis
    group = group,          # More than one data frame row belong to the same poly
    fill  =  wheatplot*yield_proportion(300)   # Fill the polygon with the yield mean
  )) +
  scale_fill_distiller(     # Palette from https://colorbrewer2.org/#type=sequential&scheme=Greens&n=3
    palette   = "Greens",   # 'cause chlorophyll
    direction = 1,          # Darker is higher
    limits    = c(0, 15)    # Set color bar minimum at zero, max TBD by ggplot
  ) +
  labs(
    title    = "Current practice (300 Units of Nitrogen Fertilizer (kg ha^-1)",
    subtitle = "Wheat Yield",
    fill     = expression("Yield in" ~ MgHa^-1 ~ "Darker is higher")
  ) +
  theme_map() +
  theme( # Play with background color to decide if gray helps with contrast
    panel.background = element_rect(fill = "gray80")
  )




# Define server function
server <- function(input, output) {
  
#ScatterPlot 
  
  g_yield_modified<- ggplot(ymPlotDF) + # Omits 95 pixels without information
    geom_polygon(aes(
      x     = long,           # Longitudes in the horizontal axis
      y     = lat,            # Latitude in the vertical axis
      group = group,          # More than one data frame row belong to the same poly
      fill  =  wheatplot*yield_proportion(input$x)  # Fill the polygon with the yield mean
    )) +
    scale_fill_distiller(     # Palette from https://colorbrewer2.org/#type=sequential&scheme=Greens&n=3
      palette   = "Greens",   # 'cause chlorophyll
      direction = 1,          # Darker is higher
      limits    = c(0, 15)    # Set color bar minimum at zero, max TBD by ggplot
    ) +
    labs(
      title    = "Farmer selected amount of N Fertilizer",
      subtitle = "Wheat Yield",
      fill     = expression("Yield in" ~ MgHa^-1 ~ "Darker is higher")
    ) +
    theme_map() +
    theme( # Play with background color to decide if gray helps with contrast
      panel.background = element_rect(fill = "gray80")
    )
  
  output$lineplot <- renderPlot({
    
    grid.arrange(g_yield, g_yield_modified, ncol=2)
    
    
  })
    

  
 # Pull in description of trend
  output$desc <- renderText({
    {  
      e <- emissions(input$x)
      paste(round(e), "predicted emissions")
    }
  })
  
}


