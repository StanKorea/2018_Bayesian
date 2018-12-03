#Example1: Eight Schools 
#hierarchical meta-analysis model described in section 5.5 of Gelman et al. (2003)
#cited from http://mc-stan.org/rstan/articles/rstan.html

#Preparing the Data
schools_data <- list(
  J = 8,
  y = c(28,  8, -3,  7, -1,  1, 18, 12),
  sigma = c(15, 10, 16, 11,  9, 11, 10, 18)
)

# Sample from the Posterior Distribution
library(rstan)
fit1 <- stan(
  file = "stan_programs/8schools.stan", # Stan program
  data = schools_data,                  # named list of data
  chains = 4,                           # number of Markov chains
  warmup = 1000,                        # number of warmup iterations per chain
  iter = 2000,                          # total number of iterations per chain
  cores = 2,                            # number of cores
  refresh = 1000                        # show progress every 'refresh' iterations
)

print(fit1, pars=c("theta", "mu", "tau", "lp__"), probs=c(.1,.5,.9))
plot(fit1)
traceplot(fit1, pars = c("mu", "tau"), inc_warmup = TRUE, nrow = 2)
print(fit1, pars = c("mu", "tau"))

