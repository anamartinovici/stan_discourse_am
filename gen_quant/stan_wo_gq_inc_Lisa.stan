#include /home/amartino/cmdstan/my_code/stan_discourse_am/gen_quant/inc_parameters.stan

model {  
    alpha ~ normal(0, 10);
    beta  ~ normal(0, 10);
    sigma ~ cauchy(0, 5);
}
