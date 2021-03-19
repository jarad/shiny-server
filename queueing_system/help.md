This applet will simulate an M/M/k/K (queueing system). 
The M's refer to a memoryless process for arrivals and services, specifically the assumptions are an exponential distribution with rate B of inter-arrivial times and an exponential distribution with rate D for service times. 
The first k (lower case) indicates there are k servers to help those that arrive. 
The second K (upper case) indicates the queue, including those currently be served, can be at most K individuals.


## Input

- Queueing system
  - M/M/k
  - M/M/Inf
  - Poisson process (M/0/Inf)
- Number of servers (k) 
- Maximum queue length (K)
- Arrival rate (B)
- Service rate (D)
- Initial state, X(0)
- End time for simulation (T)
- Number of simulations (N)

## Plot

The plot is the current value of the state X(t) for t in the interval (0,T) repeated for N simulations. 
