#!/bin/bash
#Set job requirements
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH -t 5:00

n_warmup=500
n_samples=500
n_Kfolds=1
sample=1

project_dir=$HOME/cmdstan/my_code/stan_discourse_am
output_dir=$HOME/cmdstan/my_code/stan_discourse_am/output_dir

cd cmdstan
make build

make $project_dir/gen_quant/stan_wo_gq_inc_Lisa

export MKL_NUM_THREADS=16

for ((i=1; i<=2 ; i++ )) ; do
(
  $project_dir/gen_quant/stan_wo_gq_inc_Lisa sample num_samples=500 num_warmup=500 random seed=1$i output file=$output_dir/output_stan_wo_gq_chain$i.csv
) &
done
wait
