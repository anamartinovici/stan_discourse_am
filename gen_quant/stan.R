rm(list=ls())

set.seed(25)

# there are N observations
N <- 2000

# there is one true explanatory variable, there is a mean of this true X and the sd is how much this varies among the N individuals
true_mu_x      <- 4
true_sigma_x   <- 3
true_x <- array(rnorm(N, mean = true_mu_x, sd = true_sigma_x), dim = c(N))
summary(true_x)

# the true coefficients in y_1 = alpha + beta * true_x + eps
true_alpha <- 1
true_beta  <- 4
# the sd of the error term for the dependent variable
true_sigma <- 1

y <- as.vector(true_alpha + true_beta * true_x + rnorm(N, mean = 0, sd = true_sigma))
summary(y)

stan_data = list(N = N, y = y, x = true_x)

library(loo)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

niter   <- 500
nchains <- 2

#### stan without any generated quantities
stan_wo_gq <- stan_model("gen_quant/stan_wo_gq.stan")
res_wo_gq  <- sampling(stan_wo_gq, data = c(stan_data,
                                            m = 70,
                                            n = 5,
                                            p = 20,
                                            q = 50), iter = niter, chains = nchains, verbose = TRUE, seed = 11)
print(res_wo_gq, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_wo_gq))

#### stan with an array of matrices in the generated quantities block
stan_w_gq_matrix <- stan_model("gen_quant/stan_w_gq_matrix.stan")
res_w_gq_matrix  <- sampling(stan_w_gq_matrix, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 50), iter = niter, chains = nchains, verbose = TRUE, seed = 11)
print(res_w_gq_matrix, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_matrix))

res_w_gq_matrix  <- sampling(stan_w_gq_matrix, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 20), iter = niter, chains = nchains, verbose = TRUE, seed = 11)
print(res_w_gq_matrix, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_matrix))

# init values all set to 0
res_w_gq_matrix  <- sampling(stan_w_gq_matrix, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 20), iter = niter, chains = nchains, verbose = TRUE,
                             init = 0, seed = 11)
print(res_w_gq_matrix, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_matrix))

# init values set to 0 only for sim_matrix
res_w_gq_matrix  <- sampling(stan_w_gq_matrix, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 20), iter = niter, chains = nchains, verbose = TRUE,
                             init = list(list(sim_matrix = array(0, dim = c(20, 20, 70, 5))),
                                         list(sim_matrix = array(0, dim = c(20, 20, 70, 5)))), seed = 11)
print(res_w_gq_matrix, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_matrix))

# keep only sim_matrix 
res_w_gq_matrix  <- sampling(stan_w_gq_matrix, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 20), iter = niter, chains = nchains, verbose = TRUE,
                             pars = c("sim_matrix"), include = TRUE, seed = 11)
print(get_elapsed_time(res_w_gq_matrix))

#### stan with an array of vectors in the generated quantities block
stan_w_gq_vector <- stan_model("gen_quant/stan_w_gq_vector.stan")
res_w_gq_vector  <- sampling(stan_w_gq_vector, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 50), iter = niter, chains = nchains, verbose = TRUE, seed = 11)
print(res_w_gq_vector, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_vector))

res_w_gq_vector  <- sampling(stan_w_gq_vector, data = c(stan_data,
                                                        m = 70,
                                                        n = 5,
                                                        p = 20,
                                                        q = 20), iter = niter, chains = nchains, verbose = TRUE, seed = 11)
print(res_w_gq_vector, pars = c("alpha", "beta", "sigma"))
print(get_elapsed_time(res_w_gq_vector))
