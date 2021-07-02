#!/bin/bash
#SBATCH --account=XXXXXX
#SBATCH --job-name=prior_lim
#SBATCH --partition=large
#SBATCH --time=20:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/Lim18_Nesmall_Tupwide/makeprior.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=10

module load Python
module load R
srun Rscript makeprior.R
