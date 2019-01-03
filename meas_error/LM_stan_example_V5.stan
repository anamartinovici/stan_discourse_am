// y, x_meas, and x are changed to vector. the Stan manual uses type real, but this gives compile errors
data {
    int<lower=0> N;     // number of observations
    vector[N] y;        // outcome
    int n_measurements; // number of measurements of x
    vector[n_measurements] x_meas[N];   // measurement of x
    real<lower=0> tau;  // known measurement noise
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
    
    {
        real var_x;
        var_x = 1/(n_measurements/(tau^2) + 1/(sigma_x^2));
        
        for(i in 1:N) {
            x[i] = var_x*(sum(x_meas[i])/(tau^2) + mu_x/(sigma_x^2)) + sqrt(var_x)*z[i];     
        }
    }
}

model {
    alpha ~ normal(0, 10);
    beta  ~ normal(0, 10);
    mu_x  ~ normal(0, 10);    
    z ~ normal(0, 1);

    y ~ normal(alpha + beta * x, sigma);      
}
