#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=fscsims_O
#SBATCH --partition=large
#SBATCH --time=50:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/Onit12_Nesmall/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
