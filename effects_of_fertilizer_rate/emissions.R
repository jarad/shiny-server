# From Table 1 line 1 of 
# https://www.sciencedirect.com/science/article/pii/S0167880918301452?via%3Dihub

emissions <- function(N) {
  258*exp(.0068*N)
}

emissions_hw <- function(N) {
  # 2.04*sqrt(exp(.0135*N*(4090-34*N+.075*N^2))) # typo in Table 1??
  2.04*sqrt(exp(.0135*N)*(4090-34*N+.075*N^2))
}

runoff <- function(N) {
  5.72+1.33*exp(.0104*N)
}
