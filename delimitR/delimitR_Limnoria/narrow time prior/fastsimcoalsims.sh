#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=10:00:00
#SBATCH --mem=10G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/Lim18_Nesmall/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
