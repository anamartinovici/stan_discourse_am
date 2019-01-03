rm(list=ls())

# there are N individuals in the sample
N <- 2000

# there is one true explanatory variable, there is a mean of this true X and the sd is how much this varies among the N individuals
true_mu_x <- 4
true_sigma_x   <- 3
true_x <- array(rnorm(N, mean = true_mu_x, sd = true_sigma_x), dim = c(N, 1))
summary(true_x)

# the measurement error around the true_X
true_tau <- 1

x_meas <- array(0, dim = c(N))
for(i in 1:N) {
  x_meas[i] <- rnorm(1, mean = true_x[i], sd = true_tau)    
}
summary(x_meas)

# the true coefficients in y_1 = alpha + beta * true_X_latent + eps
true_alpha <- 1
true_beta  <- 4
# the sd of the error term for the dependent variable
true_sigma <- 1

y <- as.vector(true_alpha + true_beta * true_x + rnorm(N, mean = 0, sd = true_sigma))
summary(y)

library(loo)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

niter <- 4000
####
LM_stan_example_V1 <- stan_model("meas_error/LM_stan_example_V1.stan")
res_LM_stan_example_V1 <- sampling(LM_stan_example_V1, 
                                   data = list(N = N, 
                                               y = y,
                                               x_meas = x_meas,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V1, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))

### V2 
### reparametrize the cauchy and x ~ normal -> manual on page 152
LM_stan_example_V2 <- stan_model("meas_error/LM_stan_example_V2.stan")
res_LM_stan_example_V2 <- sampling(LM_stan_example_V2, 
                                   data = list(N = N, 
                                               y = y,
                                               x_meas = x_meas,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V2, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))

true_alpha
true_beta
true_sigma
true_mu_x
true_sigma_x


### V3
### use stronger priors, based on the suggestion of ScottAlder
LM_stan_example_V3 <- stan_model("meas_error/LM_stan_example_V3.stan")
res_LM_stan_example_V3 <- sampling(LM_stan_example_V3, 
                                   data = list(N = N, 
                                               y = y,
                                               x_meas = x_meas,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V3, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))



### V4
### use multiple measurements
n_measurements <- 4
x_meas_V4 <- array(0, dim = c(N, n_measurements))
for(i in 1:N) {
    x_meas_V4[i, ] <- rnorm(n_measurements, mean = true_x[i], sd = true_tau)    
}

LM_stan_example_V4 <- stan_model("meas_error/LM_stan_example_V4.stan")
res_LM_stan_example_V4 <- sampling(LM_stan_example_V4, 
                                   data = list(N = N, 
                                               y = y,
                                               n_measurements = n_measurements,
                                               x_meas = x_meas_V4,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V4, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))


### V5
LM_stan_example_V5 <- stan_model("meas_error/LM_stan_example_V5.stan")
res_LM_stan_example_V5 <- sampling(LM_stan_example_V5, 
                                   data = list(N = N, 
                                               y = y,
                                               n_measurements = n_measurements,
                                               x_meas = x_meas_V4,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V5, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))



### V6
LM_stan_example_V6 <- stan_model("meas_error/LM_stan_example_V6.stan")
res_LM_stan_example_V6 <- sampling(LM_stan_example_V6, 
                                   data = list(N = N, 
                                               y = y,
                                               n_measurements = n_measurements,
                                               x_meas = x_meas_V4,
                                               tau = true_tau),
                                   iter = niter)
print(res_LM_stan_example_V6, pars = c("alpha", "beta", "sigma", "mu_x", "sigma_x"))
