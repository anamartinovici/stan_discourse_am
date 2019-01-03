data {
    int<lower=0> N;     // number of observations
    vector[N] y;        // outcome
    vector[N] x;        // explanatory var, y = alpha + beta*x + eps
    int<lower=0> m;
    int<lower=0> n;
    int<lower=0> p;
    int<lower=0> q;
}

transformed data {
    vector[m] O_m;
    matrix[m, n] O_m_n;
    
    O_m   = rep_vector(0.0, m);
    O_m_n = rep_matrix(0.0, m, n);
}

parameters {
    real alpha;            // intercept
    real beta;             // slope
    real<lower=0> sigma;   // variance of eps in y = alpha + beta*x + eps
}

model {
    print("Start model ");
    
    alpha ~ normal(0, 10);
    beta  ~ normal(0, 10);
    sigma ~ cauchy(0, 5);
    
    print("log density before =", target());
    y ~ normal(alpha + beta * x, sigma);      
    print("log density after =", target());

    print("End model ");
}

generated quantities {
    vector[m] sim_vector[p, q, n];
    
    for(i in 1:p) {
        for(j in 1:q) {
            for(k in 1:n) {
                sim_vector[i, j, k] = O_m;   
            }
        }
    }
    print("End gq ");
}
