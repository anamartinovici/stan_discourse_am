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
    matrix[m, n] sim_matrix_1[q];
    matrix[m, n] sim_matrix_2[q];
    matrix[m, n] sim_matrix_3[q];
    matrix[m, n] sim_matrix_4[q];
    matrix[m, n] sim_matrix_5[q];
    matrix[m, n] sim_matrix_6[q];
    matrix[m, n] sim_matrix_7[q];
    matrix[m, n] sim_matrix_8[q];
    matrix[m, n] sim_matrix_9[q];
    matrix[m, n] sim_matrix_10[q];
    matrix[m, n] sim_matrix_11[q];
    matrix[m, n] sim_matrix_12[q];
    matrix[m, n] sim_matrix_13[q];
    matrix[m, n] sim_matrix_14[q];
    matrix[m, n] sim_matrix_15[q];
    matrix[m, n] sim_matrix_16[q];
    matrix[m, n] sim_matrix_17[q];
    matrix[m, n] sim_matrix_18[q];
    matrix[m, n] sim_matrix_19[q];
    matrix[m, n] sim_matrix_20[q];
    
    for(j in 1:q) {
        sim_matrix_1[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_2[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_3[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_4[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_5[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_6[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_7[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_8[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_9[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_10[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_11[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_12[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_13[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_14[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_15[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_16[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_17[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_18[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_19[j] = O_m_n;
    }

    for(j in 1:q) {
        sim_matrix_20[j] = O_m_n;
    }

    print("End gq ");
}
