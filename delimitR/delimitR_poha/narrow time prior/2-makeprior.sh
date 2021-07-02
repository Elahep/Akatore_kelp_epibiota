#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=20:00:00
#SBATCH --mem=10G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/poh18_Nesmall/makeprior.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXXX
#SBATCH --cpus-per-task=14

module load Python
module load R
srun Rscript makeprior.R
