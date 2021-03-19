This applet will simulate a Poisson process. 

## Input

This applet requires 3 pieces of input:

  - Rate (R): the rate parameter for the Poisson process, e.g. expected count per unit time
  - End time for simulations (T): the process will be simulated from time 0 through this time
  - Number of simulations (N): the number of simulations (realizations) of the Poisson process to perform
  
## Simulations  
  
Behind the scenes, simulations are performed for the Poisson process using the following approach for each individual simulation:

  1. The total count of the Poisson process, X(T), is simulated from a Poisson distribution with parameter (R x T).
  2. X(T) occurrence times (O_t) are simulated uniformly on the interval (0,T).
  3. Inter-arrival times (I_t=O_t-O_{t-1}) are calculated for each simulation (where O_0=0).
  
## Plots

There are two main plots for this applet.

The 'Simulation' tab has the cumulative counts for each simulation of the Poisson process which each simulation having a different color. This plot gives an idea of the variability associated with the Poisson process through time.

The 'Inter-arrival times' tab provides a histogram of the proportion of inter-arrival times falling into each bin on the x-axis. These arrival times should have an exponential distribution with rate R. The probability density function for this exponential distribution is plotted as the red line. Since the simulations have the same rate parameter, they can be combined into a single histogram and there is a checkbox for this option.
