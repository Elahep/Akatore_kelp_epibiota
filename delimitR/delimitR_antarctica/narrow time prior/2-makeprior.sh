#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=prior_ant
#SBATCH --partition=bigmem
#SBATCH --time=7-00:00:00
#SBATCH --mem=104G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/ant12_Nesmall/Nesmall_b12.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXX
#SBATCH --cpus-per-task=20


module load Python
module load R
srun Rscript makeprior.R
