// y, x_meas, and x are changed to vector as compared "real" in the manual due to compile errors
data {
    int<lower=0> N;     // number of observations
    vector[N] y;        // outcome
    vector[N] x_meas;   // measurement of x
    real<lower=0> tau;  // measurement noise
}

parameters {
    real alpha;            // intercept
    real beta;             // slope
    real<lower=0> sigma;   // variance of the error term in y = alpha + beta*x_true + eps
    vector[N] x;           // unknown true value of x
    real mu_x;             // prior location
    real<lower=0> sigma_x; // prior scale
}

model {
    alpha ~ normal(0, 10);
    beta  ~ normal(0, 10);
    sigma ~ cauchy(0, 5);
    mu_x  ~ normal(0, 10);    
    sigma_x ~ cauchy(0, 5);   

    x ~ normal(mu_x, sigma_x); 
    x_meas ~ normal(x, tau);   
    y ~ normal(alpha + beta * x, sigma);      
}
