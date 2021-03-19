library(shiny)
library(plyr)
library(scales)
library(ggplot2)

shinyServer(function(input,output) {
  d <- reactive({
    validate(
      need(input$X0>=0, 'Please select positive initial state.')
    )
    
    if (input$queueing_system=='mmkK') 
      validate(need(input$X0<=input$K, 'Initial state, X(0), needs to be less than or equal to K.'))
    
    B = input$B
    o = rdply(input$N, {
      t = tt = 0
      X = Xt = input$X0
      while(t < input$t) {
        # Fix birth rate for M/M/k/K system
        if (input$queueing_system=='mmkK') {
           if (X==input$K) B=0
           if (X <input$K) B=input$B
        }
        
        # Fix death rate for all systems
        D = switch(input$queueing_system,
                   'mmk'  = input$D * input$k,
                   'mmkK' = input$D * input$k,
                   'mmi'  = input$D * X,
                   'pp'   = 0)
        D = ifelse(X, D, 0)
        
        t = t + rexp(1, B + D)
        if (t>input$t) break
        X = X + sample(c(-1,1), 1, prob = c(D, B)/(B + D))
        tt = c(tt,t)
        Xt = c(Xt,X)
      }
      data.frame(time=c(tt,input$t), state=c(Xt,X))
    })
    o$Simulation = factor(o$.n)
    o
  })
  
  output$simulation <- renderPlot({
    g = ggplot(d(), aes(x=time, y=state, color=Simulation)) + 
      geom_step() +
      scale_x_continuous(name="Time (t)", breaks=pretty_breaks(), limits=c(0,input$t)) + 
      scale_y_continuous(name="Current state, X(t)", breaks=pretty_breaks())
    print(g)
  })
})
