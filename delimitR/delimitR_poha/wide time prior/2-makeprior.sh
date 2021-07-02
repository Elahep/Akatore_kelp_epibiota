#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=prior_poh
#SBATCH --partition=large
#SBATCH --time=25:00:00
#SBATCH --mem=10G
#SBATCH --output=/nesi/nobackup/XXXXXX/Onito/delimitR/poh18_Nesmall_Tupwide/Nesmall_Tupwideb18.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=14

module load Python
module load R
srun Rscript makeprior.R
