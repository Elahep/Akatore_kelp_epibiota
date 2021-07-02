#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=prior_ontb12
#SBATCH --partition=bigmem
#SBATCH --time=7-00:00:00
#SBATCH --mem=104G
#SBATCH --output=/nesi/nobackup/XXXX/Onito/delimitR/Onit12_Nesmall/Nesmall_bin12.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXXX
#SBATCH --cpus-per-task=20

module load Python
module load R
srun Rscript makeprior.R
