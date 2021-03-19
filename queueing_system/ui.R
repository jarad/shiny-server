require(shiny)
require(markdown)

shinyUI(pageWithSidebar(
  
  headerPanel("M/M/k/K Queueing System"),
  
  sidebarPanel(
    #style="min-width:235px;max-width:275px",
    selectInput('queueing_system', 'Queueing system (Q):', 
                list('M/M/k'   = 'mmk',
                     'M/M/Inf' = 'mmi',
                     'M/M/k/K' = 'mmkK',
                     'Poisson process (M/0/Inf)' = 'pp')),
    conditionalPanel(
      condition = "input.queueing_system == 'mmk' || input.queueing_system == 'mmkK'",
      numericInput('k', 'Number of servers (k):', value=1)),
    conditionalPanel(
      condition = "input.queueing_system == 'mmkK'",
      numericInput('K', 'Maximum queue length (K):', value=1)),
    numericInput('B', 'Arrival rate (B):', value=1),
    conditionalPanel(
      condition = "input.queueing_system != 'pp'",
      numericInput('D',  'Service rate (D):', value=1)),
    numericInput('X0', 'Initial state, X(0):', value=0),
    numericInput('t', 'End time for simulation (T):', value=10),
    numericInput('N', 'Number of simulations (N):', value=2)#,
    #submitButton('Simulate.')
  ),
    
  mainPanel(
    tabsetPanel(
      tabPanel('Simulations',          plotOutput('simulation')),
      tabPanel('Help', includeMarkdown('help.md'))
    )
  )
))
