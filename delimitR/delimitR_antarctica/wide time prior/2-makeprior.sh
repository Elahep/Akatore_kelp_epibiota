#!/bin/bash
#SBATCH --account=uoo02782
#SBATCH --job-name=prior_ant
#SBATCH --partition=bigmem
#SBATCH --time=7-00:00:00
#SBATCH --mem=104G
#SBATCH --output=/nesi/nobackup/uoo02782/Onito/delimitR/ant12_Nesmall_Tupwide/makeprior.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elahe.parvizi91@yahoo.com
#SBATCH --cpus-per-task=20

cd /nesi/nobackup/uoo02782/Onito/delimitR/ant12_Nesmall_Tupwide

module load Python
module load R
srun Rscript makeprior.R
