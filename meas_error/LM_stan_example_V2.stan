// y, x_meas, and x are changed to vector as compared "real" in the manual due to compile errors
data {
    int<lower=0> N;     // number of observations
    vector[N] y;        // outcome
    vector[N] x_meas;   // measurement of x
    real<lower=0> tau;  // measurement nois
}

parameters {
    real alpha;          // intercept
    real beta;           // slope
    real<lower=0, upper=pi()/2> tau_sigma;   
    real mu_x;           
    vector[N] z; 
    real<lower=0, upper=pi()/2> tau_sigma_x; 
}

transformed parameters {
    real<lower=0> sigma;   // variance of the error term in y = alpha + beta*x_true + eps
    real<lower=0> sigma_x; // prior scale
    vector[N] x;           // unknown true value of x
    
    sigma_x = 5.0 * tan(tau_sigma_x);
    sigma = 5.0 * tan(tau_sigma);
    x = mu_x + sigma_x * z;
}

model {
    alpha ~ normal(0, 10);
    beta  ~ normal(0, 10);
    mu_x  ~ normal(0, 10);    
    z ~ normal(0, 1);
    
    x_meas ~ normal(x, tau); // measurement model   
    y ~ normal(alpha + beta * x, sigma);      
}
