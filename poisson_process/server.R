library(shiny)
library(plyr)
library(scales)
library(ggplot2)

shinyServer(function(input,output) {
  d <- reactive({
    o = rdply(input$n_sims, {
      totalCount = rpois(1, input$rate * input$t)
      times = sort(runif(totalCount, 0, input$t))
      data.frame(times=c(0,times,input$t), count=c(0:totalCount,totalCount))
    })
    o$Simulation = factor(o$.n)
    o
  })
  
  output$simulation <- renderPlot({
    g = ggplot(d(), aes(x=times, y=count, color=Simulation)) + 
      geom_step() +
      scale_x_continuous(name="Time", breaks=pretty_breaks()) + 
      scale_y_continuous(name="Cumulative count", breaks=pretty_breaks())
    print(g)
  })
  
  output$interarrival <- renderPlot({
    o = ddply(d(), .(Simulation), function(x) {
      data.frame(interarrival_times=diff(x$times))
    })
    
    if (input$combine_sims) {
      g = ggplot(o, aes(x=interarrival_times)) 
    } else {
      g = ggplot(o, aes(x=interarrival_times)) + facet_wrap(~Simulation) 
    }
    g = g + 
      geom_histogram(aes(y = ..density..)) +
      stat_function(fun=dexp, color="red", args = list(rate=input$rate)) +
      scale_x_continuous(name="Inter-arrival times") +
      scale_y_continuous(name="Proportion (count divided by total number)")
    print(g)
  })
})
