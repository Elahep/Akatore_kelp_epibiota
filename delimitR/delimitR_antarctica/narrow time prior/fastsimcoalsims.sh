#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=fscsims
#SBATCH --partition=large
#SBATCH --time=55:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXX/Onito/delimitR/ant12_Nesmall/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8


module load R
srun Rscript fastsimcoalsims.R
