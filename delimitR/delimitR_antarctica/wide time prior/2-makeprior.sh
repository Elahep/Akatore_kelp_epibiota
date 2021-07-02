#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=prior_ant
#SBATCH --partition=bigmem
#SBATCH --time=7-00:00:00
#SBATCH --mem=104G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/ant12_Nesmall_Tupwide/makeprior.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=20

module load Python
module load R
srun Rscript makeprior.R
