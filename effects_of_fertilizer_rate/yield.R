
# Nitrogen and yield "data" pulled from Millar et al. figure
N.rate <- c(0, 40, 80, 120, 160, 200, 240, 280)
yield.2014 <- c(4.4, 5.9, 6.5, 7.3, 7.3, 7.5, 7.3, 7.2)
#yield.2013 <- c(2.5, 3.8, 5.0, 5.8, 5.8, 6.2, 5.8, 6.0)

# scatterplot version of that plot
plot(N.rate, yield.2014, ylim = c(2,8), type = 'p', col = 'blue', cex = 1, pch = 19)
#points(N.rate, yield.2013,  col = 'red', cex = 1, pch = 19)

# Jarad's variogram function
curve <- function(par){
  a <- par[1]; b<- par[2]; c<- par[3]
  return(a+b*(1-exp(-c*N.rate)))
} 

# sum of squared residuals using variogram function for each year
sum.sqr.resids.14 <- function(par) sum((yield.2014-curve(par))^2)
#sum.sqr.resids.13 <- function(par) sum((yield.2013-curve(par))^2)

# finding the curves that minimize sums of squared residuals, and plotting the curves
o.14 <- optim(c(1,1,1),sum.sqr.resids.14)
o.14$convergence # check that this is 0

# o.13 <- optim(c(1,1,1),sum.sqr.resids.13)
# o.13$convergence # check that this is 0

# plotting the curves 
lines(N.rate, curve(o.14$par), col = 'blue')
#lines(N.rate, curve(o.13$par), col = 'red')

yield<-function(N.rate){
  a <- o.14$par[1]; b<- o.14$par[2]; c<- o.14$par[3]
  return( a+b*(1-exp(-c*N.rate)) )
}

yield_proportion<-function(N.rate){
  a <- o.14$par[1]; b<- o.14$par[2]
  return( yield(N.rate)/(a+b) ) 
}
