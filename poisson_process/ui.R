require(shiny)
require(markdown)

shinyUI(pageWithSidebar(
  
  headerPanel("Simulating a Poisson Process"),
  
  sidebarPanel(
    #style="min-width:235px;max-width:275px",
    numericInput('rate', 'Rate (R)', value=1),
    numericInput('t', 'End time for simulation (T)', value=100),
    numericInput('n_sims', 'Number of simulations (N)', value=5)#,
    #submitButton('Simulate.')
  ),
    
  mainPanel(
    tabsetPanel(
      tabPanel('Simulation',          plotOutput('simulation')),
      tabPanel('Inter-arrival times', 
               checkboxInput('combine_sims', 'Combine inter-arrival times across simulations?', value=FALSE),
               plotOutput('interarrival')),
      tabPanel('Help', includeMarkdown('help.md'))
    )
  )
))
