#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=10:00:00
#SBATCH --mem=30G
#SBATCH --output=/nesi/nobackup/XXXX/Onito/delimitR/Lim18_Nesmall/makeprior.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXx
#SBATCH --cpus-per-task=10

module load Python
module load R
srun Rscript makeprior.R
